package com.tradesphere.service;

import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.util.TablesNamesFinder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SQLValidationService {

    private static final Set<String> ALLOWED_TABLES = Set.of(
            "investors", "accounts", "stocks", "holdings", "orders", "trades", "price_history",
            "portfolio_summary", "order_book", "stock_trading_volume"
    );

    public void validateQuery(String sql) throws Exception {
        if (sql == null || sql.trim().isEmpty()) {
            throw new IllegalArgumentException("SQL query cannot be empty");
        }

        // Prevent multiple statements manually just in case, though JSqlParser throws an exception for extra statements
        // if we use CCJSqlParserUtil.parse(). Wait, parse() parses the first statement.
        // We should parse multiple and ensure there is exactly one.
        net.sf.jsqlparser.statement.Statements statements = CCJSqlParserUtil.parseStatements(sql);
        if (statements.getStatements().size() != 1) {
            throw new IllegalArgumentException("Only single statement queries are allowed.");
        }

        Statement statement = statements.getStatements().get(0);

        // Must be a SELECT or WITH statement
        if (!(statement instanceof Select)) {
            throw new IllegalArgumentException("Only SELECT queries are allowed.");
        }

        Select selectStatement = (Select) statement;

        // Check tables
        TablesNamesFinder tablesNamesFinder = new TablesNamesFinder();
        List<String> tableList = tablesNamesFinder.getTableList(statement);

        for (String table : tableList) {
            String cleanTableName = table.replace("`", "").replace("\"", "").toLowerCase();
            if (!ALLOWED_TABLES.contains(cleanTableName)) {
                throw new IllegalArgumentException("Access to table/view '" + cleanTableName + "' is not allowed.");
            }
        }
    }
}
