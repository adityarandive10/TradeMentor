CREATE OR REPLACE VIEW portfolio_summary AS
SELECT 
    i.id AS investor_id,
    i.first_name || ' ' || i.last_name AS investor_name,
    a.account_number,
    s.symbol,
    s.company_name,
    h.shares AS quantity,
    s.current_price,
    (h.shares * s.current_price) AS portfolio_value
FROM 
    holdings h
JOIN 
    investors i ON h.investor_id = i.id
JOIN 
    accounts a ON h.account_id = a.id
JOIN 
    stocks s ON h.stock_id = s.id;


CREATE OR REPLACE VIEW order_book AS
SELECT 
    o.id AS order_id,
    i.first_name || ' ' || i.last_name AS investor_name,
    a.account_number,
    s.symbol AS stock_symbol,
    o.order_type,
    o.quantity,
    o.target_price AS price,
    o.status,
    o.created_at AS timestamp
FROM 
    orders o
JOIN 
    investors i ON o.investor_id = i.id
JOIN 
    accounts a ON o.account_id = a.id
JOIN 
    stocks s ON o.stock_id = s.id;


CREATE OR REPLACE VIEW stock_trading_volume AS
SELECT 
    s.symbol AS stock_symbol,
    s.company_name,
    s.sector,
    COUNT(t.id) AS number_of_trades,
    SUM(t.quantity) AS total_trading_volume,
    SUM(t.quantity * t.execution_price) AS total_trading_value
FROM 
    trades t
JOIN 
    stocks s ON t.stock_id = s.id
GROUP BY 
    s.id, s.symbol, s.company_name, s.sector;
