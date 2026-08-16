package com.director_appraisal.auth_user_service.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class RateLimiterService {

    public static class RateLimitResult {
        public final boolean allowed;
        public final long remaining;
        public final long limit;
        public final long retryAfter;

        public RateLimitResult(boolean allowed, long remaining, long limit, long retryAfter) {
            this.allowed = allowed;
            this.remaining = remaining;
            this.limit = limit;
            this.retryAfter = retryAfter;
        }
    }

    public RateLimitResult checkLimit(String ipKey, String userKey, String type) {
        return new RateLimitResult(true, 5, 5, 0);
    }

    public String getClientIp(jakarta.servlet.http.HttpServletRequest request) {
        if (request == null) return "127.0.0.1";
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isBlank()) {
            String[] ips = xForwardedFor.split(",");
            for (String ip : ips) {
                String trimmed = ip.trim();
                if (isValidIp(trimmed)) {
                    return trimmed;
                }
            }
        }
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isBlank()) {
            String trimmed = xRealIp.trim();
            if (isValidIp(trimmed)) {
                return trimmed;
            }
        }
        return request.getRemoteAddr();
    }

    private boolean isValidIp(String ip) {
        if (ip == null || ip.isBlank()) {
            return false;
        }
        if ("unknown".equalsIgnoreCase(ip)) {
            return false;
        }
        return ip.contains(".") || ip.contains(":");
    }
}
