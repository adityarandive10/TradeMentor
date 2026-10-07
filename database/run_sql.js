const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const connectionString = process.env.SUPABASE_DB_URL || "postgresql://postgres:postgres@localhost:5432/postgres";

async function run() {
    const client = new Client({ connectionString });
    try {
        await client.connect();
        console.log("Connected to Supabase.");

        const schema = fs.readFileSync(path.join(__dirname, 'schema.sql'), 'utf8');
        await client.query(schema);
        console.log("Executed schema.sql");

        const seed = fs.readFileSync(path.join(__dirname, 'seed.sql'), 'utf8');
        await client.query(seed);
        console.log("Executed seed.sql");

        const views = fs.readFileSync(path.join(__dirname, 'views.sql'), 'utf8');
        await client.query(views);
        console.log("Executed views.sql");

        console.log("\nValidation Queries:");
        const tables = ['investors', 'accounts', 'stocks', 'holdings', 'orders', 'trades', 'price_history'];
        for (const table of tables) {
            const res = await client.query(`SELECT COUNT(*) FROM ${table}`);
            console.log(`Table ${table} row count: ${res.rows[0].count}`);
        }

        const view1 = await client.query(`SELECT * FROM portfolio_summary LIMIT 2`);
        console.log("\nportfolio_summary view:");
        console.log(view1.rows);

        const view2 = await client.query(`SELECT * FROM stock_trading_volume LIMIT 2`);
        console.log("\nstock_trading_volume view:");
        console.log(view2.rows);
        
        console.log("\nTop 5 stocks by trading volume:");
        const topStocks = await client.query(`SELECT stock_symbol, total_trading_volume FROM stock_trading_volume ORDER BY total_trading_volume DESC LIMIT 5`);
        console.log(topStocks.rows);

        console.log("\nPending BUY orders:");
        const pendingBuys = await client.query(`SELECT * FROM orders WHERE status = 'PENDING' AND order_type = 'BUY' LIMIT 2`);
        console.log(pendingBuys.rows);

    } catch (e) {
        console.error("Error:", e);
    } finally {
        await client.end();
    }
}

run();
