// Standalone PostgreSQL check. Full Supabase validation remains a separate CI gate.
const { Client } = require('pg');
const fs = require('node:fs');
const path = require('node:path');
async function main() {
  const base = {
    host: process.env.PGHOST || '127.0.0.1',
    port: Number(process.env.PGPORT || 55432),
    user: process.env.PGUSER || 'postgres',
    password: process.env.PGPASSWORD || 'postgres',
  };
  const admin = new Client({ ...base, database: 'postgres' });
  await admin.connect();
  for (const role of ['anon', 'authenticated', 'service_role']) {
    if (!(await admin.query('select 1 from pg_roles where rolname = $1', [role])).rowCount) {
      await admin.query(`create role ${role} nologin ${role === 'service_role' ? 'bypassrls' : ''}`);
    }
  }
  for (let run = 1; run <= 2; run++) {
    const database = `phase1_fresh_${Date.now()}_${run}`;
    await admin.query(`create database ${database}`);
    const client = new Client({ ...base, database });
    await client.connect();
    let passed = 0;
    client.on('notice', notice => { if (notice.message.startsWith('PASS:')) passed++; });
    try {
      const fixture = fs.readFileSync('scripts/postgres-platform-fixture.sql', 'utf8').replace(/^create role .*;\r?\n/gm, '');
      await client.query(fixture);
      for (const file of fs.readdirSync('supabase/migrations').filter(f => f.endsWith('.sql')).sort()) {
        await client.query(fs.readFileSync(path.join('supabase/migrations', file), 'utf8'));
      }
      await client.query(fs.readFileSync('supabase/seed.sql', 'utf8'));
      await client.query(fs.readFileSync('supabase/tests/foundation.sql', 'utf8'));
      console.log(`Fresh PostgreSQL run ${run}: 8 migrations + seed; ${passed} assertions passed`);
    } finally {
      await client.end();
      await admin.query(`drop database if exists ${database}`);
    }
  }
  await admin.end();
}
main().catch(error => { console.error(error); process.exit(1); });
