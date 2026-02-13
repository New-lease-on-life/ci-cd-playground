package com.demo.demo.controller;

import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api") // 모든 API 앞에 /api를 붙이는 것이 관례입니다.
public class ApiController {

  @GetMapping("/test")
  public Map<String, Object> testConnection() {
    Map<String, Object> response = new HashMap<>();
    response.put("success", true);
    response.put("message", "백엔드 연결 성공!");
    response.put("data", Map.of("id", 1, "name", "데모 데이터"));
    return response;
  }
}