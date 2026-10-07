# TradeSphere API Documentation

## AI Query Endpoint

**POST** `/api/ai/query`

**Description**: Accepts a natural language question, processes it via Gemini, validates and executes the resulting SQL, and returns the data and explanation.

**Request Example**:
```json
{
  "question": "Show the top 5 stocks by trading volume"
}
```

**Response Example**:
```json
{
  "success": true,
  "question": "Show the top 5 stocks by trading volume",
  "sql": "SELECT s.symbol, SUM(t.quantity) as volume FROM Stock s JOIN Trade t ON ... GROUP BY s.symbol ORDER BY volume DESC LIMIT 5;",
  "results": [
    {"symbol": "AAPL", "volume": 15000},
    {"symbol": "TSLA", "volume": 12000}
  ],
  "explanation": "Calculated the total traded quantity for each stock and ordered them to find the top 5."
}
```

## Database Health Endpoint

**GET** `/api/health/db`

**Description**: Verifies the connection to the Supabase PostgreSQL database.

**Response Example**:
```json
{
  "status": "UP",
  "database": "Supabase PostgreSQL",
  "message": "Database connection successful"
}
```

## Database Tables Endpoint

**GET** `/api/health/db/tables`

**Description**: Retrieves the list of public tables from the connected Supabase PostgreSQL database.

**Response Example**:
```json
{
  "status": "UP",
  "tables": [
    "investors",
    "accounts",
    "stocks",
    "holdings",
    "orders",
    "trades",
    "price_history",
    "portfolio_summary",
    "order_book",
    "stock_trading_volume"
  ]
}
```
