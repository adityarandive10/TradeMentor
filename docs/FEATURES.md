# TradeSphere Features

## MUST HAVE
1. Natural language input: Text area for users to ask market questions.
2. Gemini SQL generation: Backend uses Gemini to convert questions to SQL.
3. SQL validation: Backend enforces read-only (SELECT/WITH) rules.
4. Supabase execution: Backend executes safe SQL against Supabase.
5. Generated SQL display: UI shows the raw SQL generated.
6. Results table: UI displays the dataset returned from the DB.
7. AI explanation: UI displays Gemini's text explanation of the query/results.
8. Loading state: Polished loading indicators during AI and DB calls.
9. Error state: Clear error messages for unsafe SQL or DB errors.

## SHOULD HAVE
10. Example query buttons: Quick chips to populate the input.
11. Copy SQL: Button to copy the generated SQL to clipboard.
12. Query execution status: Checklist showing validation and execution success.

## OPTIONAL (Do not implement until MUST HAVE is complete)
13. Query history: List of past queries in the current session.
14. Charts: Basic data visualization for aggregated results.
