# TradeSphere Database Schema

## Architecture
The database is built on Supabase PostgreSQL. It acts as the read-only analytical backend for the AI Analyst. The schema is highly normalized with clear naming conventions, foreign keys, and indexes designed to make natural language to SQL translation easy for Gemini.

## Tables
The core schema consists of 7 normalized tables.

1. **investors**
   - `id` (SERIAL, PK)
   - `first_name` (VARCHAR)
   - `last_name` (VARCHAR)
   - `email` (VARCHAR, UNIQUE)
   - `created_at` (TIMESTAMP)

2. **accounts**
   - `id` (SERIAL, PK)
   - `investor_id` (INT, FK -> investors.id)
   - `account_number` (VARCHAR, UNIQUE)
   - `balance` (NUMERIC)
   - `created_at` (TIMESTAMP)

3. **stocks**
   - `id` (SERIAL, PK)
   - `symbol` (VARCHAR, UNIQUE)
   - `company_name` (VARCHAR)
   - `sector` (VARCHAR)
   - `current_price` (NUMERIC)
   - `market_cap` (NUMERIC)
   - `created_at` (TIMESTAMP)

4. **holdings**
   - `id` (SERIAL, PK)
   - `investor_id` (INT, FK -> investors.id)
   - `account_id` (INT, FK -> accounts.id)
   - `stock_id` (INT, FK -> stocks.id)
   - `shares` (INT)
   - `average_buy_price` (NUMERIC)
   - `UNIQUE` (account_id, stock_id)

5. **orders**
   - `id` (SERIAL, PK)
   - `investor_id` (INT, FK -> investors.id)
   - `account_id` (INT, FK -> accounts.id)
   - `stock_id` (INT, FK -> stocks.id)
   - `order_type` (VARCHAR - BUY/SELL)
   - `quantity` (INT)
   - `target_price` (NUMERIC)
   - `status` (VARCHAR - PENDING/FILLED/CANCELLED)
   - `created_at` (TIMESTAMP)

6. **trades**
   - `id` (SERIAL, PK)
   - `order_id` (INT, FK -> orders.id)
   - `stock_id` (INT, FK -> stocks.id)
   - `execution_price` (NUMERIC)
   - `quantity` (INT)
   - `executed_at` (TIMESTAMP)

7. **price_history**
   - `id` (SERIAL, PK)
   - `stock_id` (INT, FK -> stocks.id)
   - `price` (NUMERIC)
   - `recorded_at` (TIMESTAMP)

## Relationships
- `investors` (1) to `accounts` (N)
- `investors` (1) to `holdings` (N)
- `investors` (1) to `orders` (N)
- `stocks` (1) to `holdings` (N)
- `stocks` (1) to `orders` (N)
- `stocks` (1) to `trades` (N)
- `stocks` (1) to `price_history` (N)
- `orders` (1) to `trades` (N)

## Constraints & Rules
- Delete cascades are implemented for foreign keys.
- `CHECK` constraints ensure positive quantities, prices, and shares.
- `UNIQUE` constraints prevent duplicate accounts, emails, stock symbols, and holding pairs.

## Indexes
- Foreign key columns (e.g., `investor_id`, `account_id`, `stock_id`)
- Searching columns: `stocks.symbol`, `stocks.sector`, `orders.status`, `orders.order_type`
- Timestamp columns: `orders.created_at`, `trades.executed_at`, `price_history.recorded_at`

## Views
1. **portfolio_summary**: Aggregates holdings with current stock prices to compute total portfolio values for accounts.
2. **order_book**: Presents a human-readable order list including investor name, account, and stock symbol.
3. **stock_trading_volume**: Aggregates trades to show the total volume and value of trading per stock.

## Seed Data
- 8 Investors and Accounts
- 15 Stocks across 7 sectors (Technology, Finance, Healthcare, Automobile, Energy, Consumer, Telecommunications)
- 20 Holdings
- 35 Orders (Pending, Filled, Cancelled)
- 25 Trades
- 12 Price History records

## Example AI Queries
1. *Show the top 5 stocks by trading volume.*
   ```sql
   SELECT stock_symbol, total_trading_volume FROM stock_trading_volume ORDER BY total_trading_volume DESC LIMIT 5;
   ```
2. *Show all pending buy orders.*
   ```sql
   SELECT * FROM order_book WHERE status = 'PENDING' AND order_type = 'BUY';
   ```

## Supabase Configuration
- PostgreSQL is hosted on Supabase (Project Name: Trandmentor).
- **Read-Only Strategy**: For the MVP, the backend will perform strict SQL validation ensuring only `SELECT` or `WITH` keywords are present. In production, an explicit read-only Postgres role should be created and used for the JDBC connection to provide a defense-in-depth guarantee.
