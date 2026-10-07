package com.tradesphere.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ExplanationService {

    private final GeminiService geminiService;
    private final ObjectMapper objectMapper;

    public ExplanationService(GeminiService geminiService) {
        this.geminiService = geminiService;
        this.objectMapper = new ObjectMapper();
    }

    public String generateExplanation(String question, List<Map<String, Object>> results) {
        try {
            String resultsJson = objectMapper.writeValueAsString(results);
            
            // In case result set is too huge for the prompt, let's limit it
            if (resultsJson.length() > 5000) {
                resultsJson = resultsJson.substring(0, 5000) + "... (truncated)";
            }

            String prompt = "You are a financial data analyst. You were asked: '" + question + "'.\n"
                    + "The database returned the following JSON data:\n" + resultsJson + "\n"
                    + "Provide a concise, direct, human-readable summary of this data answering the user's question. "
                    + "Do not use JSON or code blocks. Just plain text.";

            String explanationResponse = geminiService.callGemini(prompt);
            return explanationResponse.trim();
        } catch (Exception e) {
            return "Explanation generation failed: " + e.getMessage();
        }
    }
}
