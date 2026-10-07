package com.tradesphere.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GeminiService {

    @Value("${GEMINI_API_KEY}")
    private String apiKey;

    @Value("${GEMINI_MODEL:gemini-1.5-pro}")
    private String model;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String SCHEMA = """
            1. investors (id, first_name, last_name, email, created_at)
            2. accounts (id, investor_id, account_number, balance, created_at)
            3. stocks (id, symbol, company_name, sector, current_price, market_cap, created_at)
            4. holdings (id, investor_id, account_id, stock_id, shares, average_buy_price)
            5. orders (id, investor_id, account_id, stock_id, order_type, quantity, target_price, status, created_at)
            6. trades (id, order_id, stock_id, execution_price, quantity, executed_at)
            7. price_history (id, stock_id, price, recorded_at)

            Views:
            - portfolio_summary
            - order_book
            - stock_trading_volume
            """;

    public String generateSql(String question) {
        String prompt = "You are a read-only PostgreSQL expert. Translate the natural language question to SQL.\n"
                + "Schema:\n" + SCHEMA + "\n"
                + "Return strictly a JSON object with 'sql' and 'explanation' fields. Do not include markdown code blocks around the JSON.\n"
                + "Only use SELECT queries. Do not use DML/DDL. Use only the provided tables and columns.\n"
                + "Question: " + question;

        return callGemini(prompt);
    }

    public String callGemini(String prompt) {
        String url = "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent?key="
                + apiKey;

        Map<String, Object> requestBody = new HashMap<>();
        Map<String, Object> part = new HashMap<>();
        part.put("text", prompt);
        Map<String, Object> content = new HashMap<>();
        content.put("parts", List.of(part));
        requestBody.put("contents", List.of(content));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        int maxRetries = 3;
        int backoffMs = 1000;

        for (int attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                String response = restTemplate.postForObject(url, entity, String.class);
                JsonNode root = objectMapper.readTree(response);
                String textResponse = root.path("candidates").get(0).path("content").path("parts").get(0).path("text")
                        .asText();

                // Clean up possible markdown wrappers
                if (textResponse.startsWith("```json")) {
                    textResponse = textResponse.substring(7);
                } else if (textResponse.startsWith("```")) {
                    textResponse = textResponse.substring(3);
                }
                if (textResponse.endsWith("```")) {
                    textResponse = textResponse.substring(0, textResponse.length() - 3);
                }

                return textResponse.trim();
            } catch (HttpStatusCodeException e) {
                int statusCode = e.getStatusCode().value();
                if (statusCode == 429 || statusCode == 503) {
                    if (attempt == maxRetries) {
                        throw new RuntimeException("AI Analyst is currently experiencing high demand or quota limits. Please try again later.");
                    }
                    try {
                        Thread.sleep(backoffMs);
                        backoffMs *= 2; // Exponential backoff
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        throw new RuntimeException("Request interrupted.", ie);
                    }
                } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
                    throw new RuntimeException("AI Analyst configuration error. Please contact support.");
                } else {
                    throw new RuntimeException("An unexpected error occurred while communicating with the AI Analyst.");
                }
            } catch (Exception e) {
                if (e instanceof RuntimeException && e.getMessage() != null && e.getMessage().contains("AI Analyst")) {
                    throw (RuntimeException) e;
                }
                throw new RuntimeException("An internal error occurred while processing the AI response.");
            }
        }
        throw new RuntimeException("Failed to call AI Analyst.");
    }
}
