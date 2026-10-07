# TradeSphere Architecture

## Diagram

```text
       [ React Frontend ]
              │
      POST /api/ai/query
              ↓
    [ Spring Boot Backend ]
              │
         (Schema + Prompt)
              ↓
        [ Gemini API ]
              │
        (Generated SQL)
              ↓
    [ Spring Boot Backend ]
              │
    (SQL Validation Logic)
              ↓
(If Safe) -> [ Supabase PostgreSQL ]
              │
        (Query Results)
              ↓
    [ Spring Boot Backend ]
              │
       JSON Response
              ↓
       [ React Frontend ]
```

## Layers
1. **React Frontend**: A single-page application built with Vite and Tailwind. Captures user natural language input and displays generated SQL, results, and AI explanations.
2. **Spring Boot Backend**: The orchestrator. Receives queries, constructs schema-aware prompts for Gemini, validates the generated SQL, executes safe queries via JDBC, and returns formatted results.
3. **Gemini API**: Translates natural language into PostgreSQL queries based on the provided schema context. Also provides a brief explanation of the results.
4. **Supabase PostgreSQL**: The cloud database hosting the relational schema and seed data.
