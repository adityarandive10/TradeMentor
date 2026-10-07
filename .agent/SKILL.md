# TradeSphere AI Analyst - Development Rules

## Project Purpose
A ONE-PAGE AI Analyst MVP that translates natural language to PostgreSQL queries using Gemini, validates them, executes them against Supabase, and presents the results and AI explanation. It is NOT a full trading app.

## Architecture & Tech Stack
- **Frontend**: React, Vite, JS, Tailwind CSS (One-page only)
- **Backend**: Java, Spring Boot, Maven (JDBC / JdbcTemplate)
- **AI**: Gemini API
- **Database**: PostgreSQL on Supabase

## Coding Conventions
- WORKING MVP > EXTRA FEATURES > COMPLEX ARCHITECTURE
- No unnecessary technologies. Do NOT use Python, Node.js, Firebase, MongoDB, or MySQL.

## Frontend Rules
- Single highly polished page. No routing.
- Visuals: Dark premium interface, subtle blue/cyan accents, glass/soft layered surfaces, clean typography.
- Never expose secrets (API keys, DB credentials) to React.

## Backend Rules
- Spring Boot must handle all AI interaction, SQL validation, and DB execution.
- Validate every SQL query from Gemini before execution.

## Database Rules
- Schema-aware prompting. Gemini only uses the 7 defined tables.
- Proper relational PostgreSQL design (PKs, FKs, NOT NULL, UNIQUE, CHECK).

## Security Rules
- Only `SELECT` and `WITH` are allowed.
- Reject: `INSERT`, `UPDATE`, `DELETE`, `DROP`, `ALTER`, `TRUNCATE`, `CREATE`, `GRANT`, `REVOKE`.
- Gemini output is NEVER trusted. Gemini never connects to the database directly.

## Development Workflow
1. Core MVP features first.
2. Optional features only after core works.
