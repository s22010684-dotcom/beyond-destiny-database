const db = require('./db');

async function testDatabase() {
    try {
        const res = await db.query(`
            SELECT 
                p.project_id, 
                p.event_date, 
                p.event_type, 
                p.current_stage, 
                p.is_completed,
                c.*
            FROM projects p
            JOIN clients c ON p.client_id = c.client_id
            LIMIT 5;
        `);
        console.log("✅ Database (Test Passed):");
        console.table(res.rows);
    } catch (err) {
        console.error("❌ Query Error:", err.message);
    } finally {
        process.exit();
    }
}

testDatabase();