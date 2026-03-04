class Validations {
  static String? validateUsername(String account) {
    if (account.isEmpty) return "Username không được để trống";
    if (account.length < 4) return "Username tối thiểu 4 ký tự";
    return null;
  }

  static String? validatePassword(String password, {bool isNewPass = false, String? oldPass, String? username}) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\s]).{8,}$');
    if (oldPass != null && password == oldPass) {
      return 'password_error_same_old';
    }
    if (username != null && username.isNotEmpty && password.toLowerCase() == username.toLowerCase()) {
      return 'password_error_same_username';
    }
    if (!passwordRegex.hasMatch(password)) {
      return isNewPass ? 'password_error_format' : 'password_error';
    }

    return null;
    // if (passwordRegex.hasMatch(value)) {
    //   return null;
    // } else {
    //   if (isNewPass) {
    //     return 'password_error_format'.tr;
    //   }
    //   return 'password_error'.tr;
    // }
  }

  static String? isValidConfirmPW(String? password, String? confirmPW) {
    if ((confirmPW ?? '').isNotEmpty && (confirmPW == password)) {
      return null;
    } else {
      return 'password_error';
    }
  }

  static String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) return 'email_error';
    final emailRegex = RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$');
    final check = emailRegex.hasMatch(email);
    if (check) {
      return null;
    } else {
      return 'email_error';
    }
  }
}
