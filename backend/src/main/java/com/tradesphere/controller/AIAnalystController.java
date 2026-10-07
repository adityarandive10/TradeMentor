package com.tradesphere.controller;

import com.tradesphere.dto.AnalyzeRequest;
import com.tradesphere.dto.AnalyzeResponse;
import com.tradesphere.service.AIAnalystService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ai")
public class AIAnalystController {

    private final AIAnalystService aiAnalystService;

    public AIAnalystController(AIAnalystService aiAnalystService) {
        this.aiAnalystService = aiAnalystService;
    }

    @PostMapping("/analyze")
    public ResponseEntity<AnalyzeResponse> analyze(@RequestBody AnalyzeRequest request) {
        AnalyzeResponse response = aiAnalystService.analyze(request);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
}
