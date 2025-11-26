class AppValidators {
  // --- 1. General Validators ---

  /// Checks if the field is empty
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Checks for valid email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty)
      return null; // Allow empty (use required() if needed)

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // --- 2. Number Validators ---

  /// Strictly allows ONLY digits (0-9). No decimals, no spaces.
  static String? onlyNumbers(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final numberRegex = RegExp(r'^[0-9]+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter valid numbers only';
    }
    return null;
  }

  /// Validates a standard 10-digit Indian Mobile Number
  static String? mobileNumber(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    // Removes any +91 or 0 prefix before checking
    String cleanNumber = value.replaceAll(RegExp(r'^(\+91|0)'), '').trim();

    if (cleanNumber.length != 10) {
      return 'Mobile number must be 10 digits';
    }

    // Checks if it contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanNumber)) {
      return 'Mobile number must contain only digits';
    }

    return null;
  }

  // --- 3. UPI Validator ---

  /// Validates UPI ID (e.g., user@upi, name.123@oksbi)
  static String? upiAddress(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    // Regex Explanation:
    // ^                 : Start
    // [a-zA-Z0-9.\-_]   : User part (Letters, Numbers, Dot, Hyphen, Underscore)
    // {2,256}           : User part length (2 to 256 chars)
    // @                 : Separator
    // [a-zA-Z]{2,64}    : Bank handle (Letters only, e.g., sbi, hdfc, ybl)
    // $                 : End
    final upiRegex = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');

    if (!upiRegex.hasMatch(value)) {
      return 'Invalid UPI ID format (e.g. name@bank)';
    }
    return null;
  }
}
