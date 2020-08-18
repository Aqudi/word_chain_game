class Validator {
  static String validateEmail(String value) {
    if (!value.contains("@")) {
      return "올바른 이메일을 입력해주세요.";
    }
    if (value.contains(" ")) {
      return "이메일에 공백이 포함되어 있습니다.";
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.length < 6) {
      return "비밀번호는 6자 이상만 가능합니다";
    }
    if (value.contains(" ")) {
      return "비밀번호에 공백이 포함되어 있습니다";
    }
    return null;
  }

  static String validateConfirmPassword(String password, String passwordConfirm) {
    if (password != passwordConfirm) {
      return "입력하신 비밀번호와 같지 않습니다";
    }
    return null;
  }
}
