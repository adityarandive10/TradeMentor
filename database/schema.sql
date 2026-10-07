-- Drop existing views first
DROP VIEW IF EXISTS portfolio_summary;
DROP VIEW IF EXISTS order_book;
DROP VIEW IF EXISTS stock_trading_volume;

-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS trades CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS price_history CASCADE;
DROP TABLE IF EXISTS holdings CASCADE;
DROP TABLE IF EXISTS stocks CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS investors CASCADE;

CREATE TABLE investors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    investor_id INT NOT NULL REFERENCES investors(id) ON DELETE CASCADE,
    account_number VARCHAR(50) UNIQUE NOT NULL,
    balance NUMERIC(15, 2) NOT NULL DEFAULT 0.00 CHECK (balance >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stocks (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) UNIQUE NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    sector VARCHAR(100) NOT NULL,
    current_price NUMERIC(10, 2) NOT NULL CHECK (current_price >= 0),
    market_cap NUMERIC(20, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE holdings (
    id SERIAL PRIMARY KEY,
    investor_id INT NOT NULL REFERENCES investors(id) ON DELETE CASCADE,
    account_id INT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    stock_id INT NOT NULL REFERENCES stocks(id) ON DELETE CASCADE,
    shares INT NOT NULL DEFAULT 0 CHECK (shares >= 0),
    average_buy_price NUMERIC(10, 2) NOT NULL CHECK (average_buy_price >= 0),
    UNIQUE (account_id, stock_id)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    investor_id INT NOT NULL REFERENCES investors(id) ON DELETE CASCADE,
    account_id INT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    stock_id INT NOT NULL REFERENCES stocks(id) ON DELETE CASCADE,
    order_type VARCHAR(10) NOT NULL CHECK (order_type IN ('BUY', 'SELL')),
    quantity INT NOT NULL CHECK (quantity > 0),
    target_price NUMERIC(10, 2) NOT NULL CHECK (target_price > 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('PENDING', 'FILLED', 'CANCELLED')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trades (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    stock_id INT NOT NULL REFERENCES stocks(id) ON DELETE CASCADE,
    execution_price NUMERIC(10, 2) NOT NULL CHECK (execution_price > 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    executed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE price_history (
    id SERIAL PRIMARY KEY,
    stock_id INT NOT NULL REFERENCES stocks(id) ON DELETE CASCADE,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    recorded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_accounts_investor_id ON accounts(investor_id);
CREATE INDEX idx_holdings_investor_id ON holdings(investor_id);
CREATE INDEX idx_holdings_account_id ON holdings(account_id);
CREATE INDEX idx_holdings_stock_id ON holdings(stock_id);
CREATE INDEX idx_orders_investor_id ON orders(investor_id);
CREATE INDEX idx_orders_account_id ON orders(account_id);
CREATE INDEX idx_orders_stock_id ON orders(stock_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_type ON orders(order_type);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_trades_order_id ON trades(order_id);
CREATE INDEX idx_trades_stock_id ON trades(stock_id);
CREATE INDEX idx_trades_executed_at ON trades(executed_at);
CREATE INDEX idx_price_history_stock_id ON price_history(stock_id);
CREATE INDEX idx_price_history_recorded_at ON price_history(recorded_at);
CREATE INDEX idx_stocks_symbol ON stocks(symbol);
CREATE INDEX idx_stocks_sector ON stocks(sector);
