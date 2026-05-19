#!/usr/bin/env node
/**
 * Reads the latest entry from CHANGELOG.md and sets it as the release note
 * on the most recent balena fleet release via the balena API.
 *
 * Required env vars:
 *   BALENA_API_TOKEN  — balena auth token
 *   BALENA_FLEET      — fleet slug, e.g. "marcus7/netop-prod"
 *
 * Optional env vars:
 *   BALENA_API_URL    — defaults to https://api.balena-cloud.com
 */

import { readFileSync } from 'fs';

const token = process.env.BALENA_API_TOKEN;
const fleet = process.env.BALENA_FLEET;
const apiUrl = process.env.BALENA_API_URL ?? 'https://api.balena-cloud.com';

if (!token || !fleet) {
  console.error('BALENA_API_TOKEN and BALENA_FLEET must be set');
  process.exit(1);
}

const headers = {
  Authorization: `Bearer ${token}`,
  'Content-Type': 'application/json',
};

// Extract the first version section from CHANGELOG.md
function parseLatestEntry(changelog) {
  const match = changelog.match(/##\s+v[\d.]+\s*\n([\s\S]*?)(?=\n##\s+v[\d.]|\s*$)/);
  return match ? match[1].trim() : null;
}

const changelog = readFileSync('CHANGELOG.md', 'utf8');
const note = parseLatestEntry(changelog);

if (!note) {
  console.log('No release notes found in CHANGELOG.md — skipping.');
  process.exit(0);
}

// Look up the fleet app ID from the slug
const fleetRes = await fetch(
  `${apiUrl}/v6/application?$filter=slug eq '${encodeURIComponent(fleet)}'&$select=id`,
  { headers },
);
if (!fleetRes.ok) {
  console.error(`Failed to look up fleet: ${fleetRes.status} ${fleetRes.statusText}`);
  process.exit(1);
}
const fleetData = await fleetRes.json();
const appId = fleetData.d?.[0]?.id;
if (!appId) {
  console.error(`Fleet '${fleet}' not found`);
  process.exit(1);
}

// Fetch the latest finalized release
const releaseRes = await fetch(
  `${apiUrl}/v6/release?$filter=belongs_to__application eq ${appId} and status eq 'success'&$orderby=created_at desc&$top=1&$select=id,commit`,
  { headers },
);
if (!releaseRes.ok) {
  console.error(`Failed to fetch releases: ${releaseRes.status} ${releaseRes.statusText}`);
  process.exit(1);
}
const releaseData = await releaseRes.json();
const release = releaseData.d?.[0];
if (!release) {
  console.error('No successful release found for fleet');
  process.exit(1);
}

// PATCH the release note
const patchRes = await fetch(`${apiUrl}/v6/release(${release.id})`, {
  method: 'PATCH',
  headers,
  body: JSON.stringify({ note }),
});
if (!patchRes.ok) {
  console.error(`Failed to set release note: ${patchRes.status} ${patchRes.statusText}`);
  process.exit(1);
}

console.log(`Set release note on release ${release.id} (${release.commit})`);
