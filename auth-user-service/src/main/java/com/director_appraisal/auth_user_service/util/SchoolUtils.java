package com.director_appraisal.auth_user_service.util;

import java.util.Locale;

public class SchoolUtils {

    public static boolean isValidSchool(String school) {
        return school != null && !school.trim().isBlank();
    }

    public static String canonicalizeSchool(String school) {
        if (school == null || school.isBlank()) {
            return null;
        }
        String s = school.trim();
        if (s.matches("^[A-Za-z0-9_-]{2,15}$")) {
            return s.toUpperCase(Locale.ROOT);
        }
        return s;
    }

    public static String schoolGroup(String school) {
        if (school == null || school.isBlank()) {
            return "general";
        }
        String s = school.trim().toLowerCase(Locale.ROOT);
        if (s.contains("engg") || s.contains("engine") || s.contains("tech") || s.contains("computer") || s.contains("bio")) {
            return "engineering";
        }
        if (s.contains("mgmt") || s.contains("manage") || s.contains("commerce") || s.contains("design") || s.contains("arts") || s.contains("humanities") || s.contains("media")) {
            return "nonEngineering";
        }
        return "general";
    }
}
