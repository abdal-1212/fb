
push the code










public class StringUtils {

    // Check if a string is empty or null
    public static boolean isEmpty(String str) {
        return str == null || str.isEmpty();
    }

    // Check if a string is not empty or null
    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    // Reverse a string
    public static String reverse(String str) {
        if (isEmpty(str)) {
            return str;
        }
        return new StringBuilder(str).reverse().toString();
    }

    // Capitalize the first letter of a string
    public static String capitalize(String str) {
        if (isEmpty(str)) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
    }

    // Check if a string contains only digits
    public static boolean isNumeric(String str) {
        if (isEmpty(str)) {
            return false;
        }
        for (char c : str.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    // Repeat a string 'n' times
    public static String repeat(String str, int n) {
        if (isEmpty(str) || n <= 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder(str.length() * n);
        for (int i = 0; i < n; i++) {
            sb.append(str);
        }
        return sb.toString();
    }

    // Left pad a string with a given character
    public static String leftPad(String str, int size, char padChar) {
        if (str == null) {
            return null;
        }
        int pads = size - str.length();
        if (pads <= 0) {
            return str; // No padding needed
        }
        return repeat(String.valueOf(padChar), pads) + str;
    }

    // Right pad a string with a given character
    public static String rightPad(String str, int size, char padChar) {
        if (str == null) {
            return null;
        }
        int pads = size - str.length();
        if (pads <= 0) {
            return str; // No padding needed
        }
        return str + repeat(String.valueOf(padChar), pads);
    }

    // Check if two strings are equal, handling nulls safely
    public static boolean equals(String str1, String str2) {
        return str1 == null ? str2 == null : str1.equals(str2);
    }

    // Trim whitespace from both ends of a string
    public static String trim(String str) {
        return str == null ? null : str.trim();
    }

    // Remove all spaces from a string
    public static String removeWhitespace(String str) {
        if (isEmpty(str)) {
            return str;
        }
        return str.replaceAll("\\s+", "");
    }

    // Abbreviate a string to a specific length, adding ellipsis if necessary
    public static String abbreviate(String str, int maxWidth) {
        if (isEmpty(str) || maxWidth < 3) {
            return str;
        }
        return (str.length() <= maxWidth) ? str : str.substring(0, maxWidth - 3) + "...";
    }
}

