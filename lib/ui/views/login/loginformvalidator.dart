class LoginFormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email value can't be empty";
    } else {
      return null;
    }
  }

  static String? passwordValidator(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "Password value can't be empty";
    }
    return null;
  }
}
