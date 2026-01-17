package util;

import java.util.regex.Pattern;

public class Validator {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    // Check empty or null
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // Validate email format
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    // Password strength (min 8 chars)
    public static boolean isStrongPassword(String password) {
        return password != null && password.length() >= 8;
    }

    public static boolean isValidRole(String role) {
        return role != null && (role.equals("ADMIN") || role.equals("VISITOR"));
    }
}
