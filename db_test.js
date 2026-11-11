import { query } from './db.js';

async function testConnection() {
  try {
    console.log('--- Testing Database Connection ---');
    const timeResult = await query('SELECT NOW()');
    console.log('Database Connected Successfully at:', timeResult.rows[0].now);

    console.log('\n--- Fetching Projects & Clients ---');
    const projects = await query(`
      SELECT p.project_code, p.project_name, c.bride_full_name, c.groom_full_name, p.current_stage
      FROM projects p
      JOIN clients c ON p.client_id = c.client_id;
    `);
    console.table(projects.rows);

    console.log('\n--- Fetching Staff Members ---');
    const staff = await query(`
      SELECT s.staff_id, u.user_name, u.user_email, s.job_role, s.phone
      FROM staff s
      JOIN users u ON s.user_id = u.user_id;
    `);
    console.table(staff.rows);

    process.exit(0);
  } catch (error) {
    console.error('Database connection test failed:', error.message);
    process.exit(1);
  }
}

testConnection();