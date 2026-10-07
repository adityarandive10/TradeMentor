package com.tradesphere.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tradesphere.dto.AnalyzeRequest;
import com.tradesphere.dto.AnalyzeResponse;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AIAnalystService {

    private final GeminiService geminiService;
    private final SQLValidationService sqlValidationService;
    private final QueryExecutionService queryExecutionService;
    private final ExplanationService explanationService;
    private final ObjectMapper objectMapper;

    public AIAnalystService(GeminiService geminiService,
                            SQLValidationService sqlValidationService,
                            QueryExecutionService queryExecutionService,
                            ExplanationService explanationService) {
        this.geminiService = geminiService;
        this.sqlValidationService = sqlValidationService;
        this.queryExecutionService = queryExecutionService;
        this.explanationService = explanationService;
        this.objectMapper = new ObjectMapper();
    }

    public AnalyzeResponse analyze(AnalyzeRequest request) {
        AnalyzeResponse response = new AnalyzeResponse();
        response.setQuestion(request.getQuestion());
        response.setReadOnly(true);

        long startTime = System.currentTimeMillis();

        if (request.getQuestion() == null || request.getQuestion().trim().isEmpty()) {
            response.setSuccess(false);
            response.setError("Question cannot be empty.");
            return response;
        }

        String sql = null;
        try {
            // 1. Generate SQL via Gemini
            String geminiJsonResult = geminiService.generateSql(request.getQuestion());

            // Parse JSON response from Gemini
            JsonNode root = objectMapper.readTree(geminiJsonResult);
            sql = root.path("sql").asText();
            String fallbackExplanation = root.path("explanation").asText();

            response.setSql(sql);
            
            if (sql == null || sql.trim().isEmpty()) {
                throw new IllegalStateException("Gemini did not return a valid SQL query.");
            }

            // 2. Validate SQL
            sqlValidationService.validateQuery(sql);

            // 3. Execute SQL
            List<Map<String, Object>> results = queryExecutionService.executeQuery(sql);
            response.setResults(results);
            response.setRowCount(results.size());

            // 4. Generate Explanation
            String finalExplanation = explanationService.generateExplanation(request.getQuestion(), results);
            if (finalExplanation.startsWith("Explanation generation failed") && fallbackExplanation != null && !fallbackExplanation.isEmpty()) {
                response.setExplanation(fallbackExplanation);
            } else {
                response.setExplanation(finalExplanation);
            }

            response.setSuccess(true);
        } catch (Exception e) {
            response.setSuccess(false);
            response.setError(e.getMessage());
        }

        response.setExecutionTimeMs(System.currentTimeMillis() - startTime);
        return response;
    }
}
