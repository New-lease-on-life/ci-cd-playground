package com.demo.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthCheckController {

  @Value("${spring.profiles.active:default}")
  private String activeProfile;

  @GetMapping("/health")
  public Map<String, String> healthCheck() {
    return Map.of(
        "status", "UP",
        "message", "CI/CD Deployment Success!",
        "profile", activeProfile
    );
  }
}