package com.tradesphere.controller;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/health/db")
public class HealthController {

    private final JdbcTemplate jdbcTemplate;

    public HealthController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping
    public Map<String, String> getDbHealth() {
        Map<String, String> response = new HashMap<>();
        try {
            jdbcTemplate.queryForObject("SELECT 1", Integer.class);
            response.put("status", "UP");
            response.put("database", "Supabase PostgreSQL");
            response.put("message", "Database connection successful");
        } catch (Exception e) {
            response.put("status", "DOWN");
            response.put("message", "Database connection failed");
        }
        return response;
    }

    @GetMapping("/tables")
    public Map<String, Object> getDbTables() {
        Map<String, Object> response = new HashMap<>();
        try {
            String query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'";
            List<String> tables = jdbcTemplate.queryForList(query, String.class);
            response.put("status", "UP");
            response.put("tables", tables);
        } catch (Exception e) {
            response.put("status", "DOWN");
            response.put("message", "Database connection failed");
        }
        return response;
    }

}
