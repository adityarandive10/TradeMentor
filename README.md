# TradeSphere — AI Database Analyst

A one-page AI Analyst MVP demonstrating the translation of natural language to PostgreSQL using the Gemini API, secure execution against a Supabase database via Spring Boot, and modern React presentation.

## Architecture
- **Frontend**: React + Vite + Tailwind CSS
- **Backend**: Java + Spring Boot + Maven
- **AI**: Gemini API
- **Database**: PostgreSQL (Supabase)

## Features
- Natural language query conversion to SQL.
- Secure backend SQL validation (read-only execution).
- Beautiful, highly polished dark-mode single-page UI.
- Direct execution of safe queries against Supabase PostgreSQL.

## Setup Instructions
1. Clone the repository.
2. Copy `.env.example` to `.env` and fill in your secrets.
3. Setup the Supabase database using `database/schema.sql` and `database/seed.sql` (to be created).
4. Run the Spring Boot backend (`mvn spring-boot:run`).
5. Run the Vite frontend (`npm run dev`).

## Security
- Gemini output is never blindly trusted.
- The backend strictly enforces read-only operations (`SELECT`, `WITH`).
- Secrets are securely managed in the backend and never exposed to the frontend.
