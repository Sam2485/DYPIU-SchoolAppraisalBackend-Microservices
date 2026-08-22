package com.director_appraisal.auth_user_service.util;

import java.util.regex.Pattern;

public final class LoggingSanitizer {

    private LoggingSanitizer() {}

    private static final Pattern SENSITIVE_JSON_PATTERN = Pattern.compile(
            "\"(password|confirmPassword|currentPassword|newPassword|token|accessToken|refreshToken|jwt|secret|apiKey|clientSecret|authorization)\"\\s*:\\s*\"[^\"]*\"",
            Pattern.CASE_INSENSITIVE
    );

    private static final int MAX_LOG_STRING_LENGTH = 4096;

    public static String sanitize(String input) {
        if (input == null) return null;
        String sanitized = SENSITIVE_JSON_PATTERN.matcher(input).replaceAll("\"$1\":\"[REDACTED]\"");
        if (sanitized.length() > MAX_LOG_STRING_LENGTH) {
            return sanitized.substring(0, MAX_LOG_STRING_LENGTH) + "... [TRUNCATED originalLength=" + input.length() + "]";
        }
        return sanitized;
    }
}
