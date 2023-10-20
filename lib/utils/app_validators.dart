class AppValidators {
  static var email = (String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!value.contains("@")) {
      return "Invalid Email Address. Please enter a valid email address";
    }
    return null;
  };
}
