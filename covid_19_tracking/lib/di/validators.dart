class Validators {
  static bool isValidEmail(String email) {
    final regularExpression = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return regularExpression.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // final passwordExpression = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    // return passwordExpression.hasMatch(password);
    return password.length >= 6;
  }
}
