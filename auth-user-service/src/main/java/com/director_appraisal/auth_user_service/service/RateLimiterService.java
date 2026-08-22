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

        public boolean isAllowed() {
            return allowed;
        }

        public long getRetryAfterSeconds() {
            return retryAfter;
        }
    }

    private final java.util.Map<String, AttemptTracker> attemptsMap = new java.util.concurrent.ConcurrentHashMap<>();

    private static class AttemptTracker {
        private final java.util.concurrent.atomic.AtomicInteger count = new java.util.concurrent.atomic.AtomicInteger(0);
        private volatile long resetTime = System.currentTimeMillis() + 60_000L;

        public synchronized boolean incrementAndCheck(int maxLimit) {
            long now = System.currentTimeMillis();
            if (now > resetTime) {
                count.set(0);
                resetTime = now + 60_000L;
            }
            return count.incrementAndGet() <= maxLimit;
        }

        public long getRetryAfter() {
            long diff = resetTime - System.currentTimeMillis();
            return Math.max(0, diff / 1000L);
        }

        public int getCurrentCount() {
            return count.get();
        }
    }

    public RateLimitResult checkLimit(String ipKey, String userKey, String type) {
        String key = (ipKey != null ? ipKey : "unknown") + ":" + (userKey != null ? userKey : "anonymous") + ":" + type;
        AttemptTracker tracker = attemptsMap.computeIfAbsent(key, k -> new AttemptTracker());
        int maxAttempts = 5;
        boolean allowed = tracker.incrementAndCheck(maxAttempts);
        long remaining = Math.max(0, maxAttempts - tracker.getCurrentCount());
        long retryAfter = allowed ? 0 : tracker.getRetryAfter();
        return new RateLimitResult(allowed, remaining, maxAttempts, retryAfter);
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
