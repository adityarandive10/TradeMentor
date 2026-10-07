package com.tradesphere.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QueryExecutionService {

    private final JdbcTemplate jdbcTemplate;

    public QueryExecutionService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Map<String, Object>> executeQuery(String sql) {
        // Enforce a sensible timeout to prevent abusive queries, e.g., 5 seconds
        jdbcTemplate.setQueryTimeout(5);
        
        // Execute dynamic query
        return jdbcTemplate.queryForList(sql);
    }
}
