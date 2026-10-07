-- Insert investors
INSERT INTO investors (id, first_name, last_name, email) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com'),
(3, 'Charlie', 'Williams', 'charlie.williams@example.com'),
(4, 'Diana', 'Brown', 'diana.brown@example.com'),
(5, 'Ethan', 'Jones', 'ethan.jones@example.com'),
(6, 'Fiona', 'Garcia', 'fiona.garcia@example.com'),
(7, 'George', 'Miller', 'george.miller@example.com'),
(8, 'Hannah', 'Davis', 'hannah.davis@example.com');

-- Insert accounts
INSERT INTO accounts (id, investor_id, account_number, balance) VALUES
(1, 1, 'ACC-1001', 50000.00),
(2, 2, 'ACC-1002', 150000.00),
(3, 3, 'ACC-1003', 25000.00),
(4, 4, 'ACC-1004', 300000.00),
(5, 5, 'ACC-1005', 75000.00),
(6, 6, 'ACC-1006', 10000.00),
(7, 7, 'ACC-1007', 85000.00),
(8, 8, 'ACC-1008', 120000.00);

-- Insert stocks
INSERT INTO stocks (id, symbol, company_name, sector, current_price, market_cap) VALUES
(1, 'AAPL', 'Apple Inc.', 'Technology', 175.50, 2800000000000),
(2, 'MSFT', 'Microsoft Corporation', 'Technology', 330.20, 2400000000000),
(3, 'GOOGL', 'Alphabet Inc.', 'Technology', 135.40, 1700000000000),
(4, 'JPM', 'JPMorgan Chase & Co.', 'Finance', 145.80, 420000000000),
(5, 'V', 'Visa Inc.', 'Finance', 230.15, 480000000000),
(6, 'JNJ', 'Johnson & Johnson', 'Healthcare', 160.75, 410000000000),
(7, 'UNH', 'UnitedHealth Group', 'Healthcare', 490.30, 450000000000),
(8, 'TSLA', 'Tesla Inc.', 'Automobile', 250.60, 790000000000),
(9, 'TM', 'Toyota Motor Corp.', 'Automobile', 165.20, 220000000000),
(10, 'XOM', 'Exxon Mobil Corp.', 'Energy', 110.45, 440000000000),
(11, 'CVX', 'Chevron Corporation', 'Energy', 160.10, 300000000000),
(12, 'AMZN', 'Amazon.com Inc.', 'Consumer', 130.80, 1300000000000),
(13, 'WMT', 'Walmart Inc.', 'Consumer', 155.90, 420000000000),
(14, 'T', 'AT&T Inc.', 'Telecommunications', 14.50, 100000000000),
(15, 'VZ', 'Verizon Communications', 'Telecommunications', 32.80, 130000000000);

-- Insert holdings
INSERT INTO holdings (id, investor_id, account_id, stock_id, shares, average_buy_price) VALUES
(1, 1, 1, 1, 50, 150.00),
(2, 1, 1, 2, 20, 300.00),
(3, 2, 2, 3, 100, 120.00),
(4, 2, 2, 8, 200, 200.00),
(5, 3, 3, 12, 15, 125.00),
(6, 4, 4, 1, 500, 160.00),
(7, 4, 4, 2, 300, 310.00),
(8, 4, 4, 4, 150, 130.00),
(9, 5, 5, 10, 250, 100.00),
(10, 5, 5, 11, 100, 150.00),
(11, 6, 6, 14, 500, 12.00),
(12, 7, 7, 5, 80, 210.00),
(13, 7, 7, 6, 40, 155.00),
(14, 8, 8, 9, 300, 150.00),
(15, 8, 8, 13, 120, 140.00),
(16, 1, 1, 15, 100, 35.00),
(17, 2, 2, 1, 150, 165.00),
(18, 3, 3, 7, 10, 480.00),
(19, 4, 4, 3, 400, 130.00),
(20, 5, 5, 12, 80, 128.00);

-- Insert orders
-- PENDING
INSERT INTO orders (id, investor_id, account_id, stock_id, order_type, quantity, target_price, status) VALUES
(1, 1, 1, 1, 'BUY', 10, 170.00, 'PENDING'),
(2, 2, 2, 8, 'SELL', 50, 260.00, 'PENDING'),
(3, 3, 3, 4, 'BUY', 20, 140.00, 'PENDING'),
(4, 4, 4, 2, 'BUY', 100, 320.00, 'PENDING'),
(5, 5, 5, 10, 'SELL', 50, 115.00, 'PENDING'),
(6, 6, 6, 14, 'BUY', 200, 14.00, 'PENDING'),
(7, 7, 7, 5, 'SELL', 20, 240.00, 'PENDING'),
(8, 8, 8, 13, 'BUY', 50, 150.00, 'PENDING'),
(9, 1, 1, 3, 'BUY', 30, 130.00, 'PENDING'),
(10, 2, 2, 1, 'SELL', 100, 180.00, 'PENDING');
-- FILLED
INSERT INTO orders (id, investor_id, account_id, stock_id, order_type, quantity, target_price, status) VALUES
(11, 1, 1, 1, 'BUY', 50, 150.00, 'FILLED'),
(12, 1, 1, 2, 'BUY', 20, 300.00, 'FILLED'),
(13, 2, 2, 3, 'BUY', 100, 120.00, 'FILLED'),
(14, 2, 2, 8, 'BUY', 200, 200.00, 'FILLED'),
(15, 3, 3, 12, 'BUY', 15, 125.00, 'FILLED'),
(16, 4, 4, 1, 'BUY', 500, 160.00, 'FILLED'),
(17, 4, 4, 2, 'BUY', 300, 310.00, 'FILLED'),
(18, 4, 4, 4, 'BUY', 150, 130.00, 'FILLED'),
(19, 5, 5, 10, 'BUY', 250, 100.00, 'FILLED'),
(20, 5, 5, 11, 'BUY', 100, 150.00, 'FILLED'),
(21, 6, 6, 14, 'BUY', 500, 12.00, 'FILLED'),
(22, 7, 7, 5, 'BUY', 80, 210.00, 'FILLED'),
(23, 7, 7, 6, 'BUY', 40, 155.00, 'FILLED'),
(24, 8, 8, 9, 'BUY', 300, 150.00, 'FILLED'),
(25, 8, 8, 13, 'BUY', 120, 140.00, 'FILLED'),
(26, 1, 1, 15, 'BUY', 100, 35.00, 'FILLED'),
(27, 2, 2, 1, 'BUY', 150, 165.00, 'FILLED'),
(28, 3, 3, 7, 'BUY', 10, 480.00, 'FILLED'),
(29, 4, 4, 3, 'BUY', 400, 130.00, 'FILLED'),
(30, 5, 5, 12, 'BUY', 80, 128.00, 'FILLED');
-- CANCELLED
INSERT INTO orders (id, investor_id, account_id, stock_id, order_type, quantity, target_price, status) VALUES
(31, 1, 1, 8, 'BUY', 50, 200.00, 'CANCELLED'),
(32, 2, 2, 2, 'SELL', 10, 350.00, 'CANCELLED'),
(33, 3, 3, 1, 'BUY', 100, 100.00, 'CANCELLED'),
(34, 4, 4, 10, 'BUY', 200, 90.00, 'CANCELLED'),
(35, 5, 5, 5, 'SELL', 20, 250.00, 'CANCELLED');

-- Insert trades (corresponding to FILLED orders)
INSERT INTO trades (id, order_id, stock_id, execution_price, quantity, executed_at) VALUES
(1, 11, 1, 150.00, 50, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(2, 12, 2, 300.00, 20, CURRENT_TIMESTAMP - INTERVAL '29 days'),
(3, 13, 3, 120.00, 100, CURRENT_TIMESTAMP - INTERVAL '28 days'),
(4, 14, 8, 200.00, 200, CURRENT_TIMESTAMP - INTERVAL '27 days'),
(5, 15, 12, 125.00, 15, CURRENT_TIMESTAMP - INTERVAL '26 days'),
(6, 16, 1, 160.00, 500, CURRENT_TIMESTAMP - INTERVAL '25 days'),
(7, 17, 2, 310.00, 300, CURRENT_TIMESTAMP - INTERVAL '24 days'),
(8, 18, 4, 130.00, 150, CURRENT_TIMESTAMP - INTERVAL '23 days'),
(9, 19, 10, 100.00, 250, CURRENT_TIMESTAMP - INTERVAL '22 days'),
(10, 20, 11, 150.00, 100, CURRENT_TIMESTAMP - INTERVAL '21 days'),
(11, 21, 14, 12.00, 500, CURRENT_TIMESTAMP - INTERVAL '20 days'),
(12, 22, 5, 210.00, 80, CURRENT_TIMESTAMP - INTERVAL '19 days'),
(13, 23, 6, 155.00, 40, CURRENT_TIMESTAMP - INTERVAL '18 days'),
(14, 24, 9, 150.00, 300, CURRENT_TIMESTAMP - INTERVAL '17 days'),
(15, 25, 13, 140.00, 120, CURRENT_TIMESTAMP - INTERVAL '16 days'),
(16, 26, 15, 35.00, 100, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(17, 27, 1, 165.00, 150, CURRENT_TIMESTAMP - INTERVAL '14 days'),
(18, 28, 7, 480.00, 10, CURRENT_TIMESTAMP - INTERVAL '13 days'),
(19, 29, 3, 130.00, 400, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(20, 30, 12, 128.00, 80, CURRENT_TIMESTAMP),
(21, 11, 1, 152.00, 10, CURRENT_TIMESTAMP),
(22, 12, 2, 305.00, 5, CURRENT_TIMESTAMP),
(23, 13, 3, 122.00, 20, CURRENT_TIMESTAMP),
(24, 14, 8, 205.00, 50, CURRENT_TIMESTAMP),
(25, 16, 1, 162.00, 100, CURRENT_TIMESTAMP);

-- Update sequences
SELECT setval('investors_id_seq', (SELECT MAX(id) FROM investors));
SELECT setval('accounts_id_seq', (SELECT MAX(id) FROM accounts));
SELECT setval('stocks_id_seq', (SELECT MAX(id) FROM stocks));
SELECT setval('holdings_id_seq', (SELECT MAX(id) FROM holdings));
SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));
SELECT setval('trades_id_seq', (SELECT MAX(id) FROM trades));
SELECT setval('price_history_id_seq', (SELECT MAX(id) FROM price_history));

-- Insert price history
INSERT INTO price_history (stock_id, price, recorded_at) VALUES
(1, 150.00, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1, 160.00, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(1, 175.50, CURRENT_TIMESTAMP),
(2, 300.00, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(2, 315.00, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(2, 330.20, CURRENT_TIMESTAMP),
(3, 120.00, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(3, 125.00, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(3, 135.40, CURRENT_TIMESTAMP),
(8, 200.00, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(8, 225.00, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(8, 250.60, CURRENT_TIMESTAMP);
