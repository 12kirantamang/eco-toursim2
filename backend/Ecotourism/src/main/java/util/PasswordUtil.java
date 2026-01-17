package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Generate hashed password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // Verify password
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null || hashedPassword.isEmpty()) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
