class AppValidators {
  static var email = (String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!value.contains("@")) {
      return "Invalid Email Address. Please enter a valid email address";
    }
    return null;
  };

  static var password = (String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  };
  static var reEnterPassword = (String? value, String old) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value != old) {
      return "Password does not match";
    }
  };
}
