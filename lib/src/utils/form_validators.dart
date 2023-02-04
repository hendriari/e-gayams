class FormValidators {
  /// validate username
  static String? usernameValidate({
    String? value,
  }) {
    if (value!.isEmpty) {
      return 'Username tidak boleh kosong !';
    } else if (value.length < 8) {
      return 'Username harus lebih dari 8 karakter !';
    } else if (!RegExp('.*[A-Z].*').hasMatch(value)) {
      return 'Username harus memiliki 1 huruf uppercase !';
    }
    return null;
  }

  /// common validate
  static String? commonValidate({
    String? value,
    String? values,
  }) {
    if (value!.isEmpty) {
      return '$values tidak boleh kosong !';
    }
    return null;
  }

  /// rt rw validate
  static String? rtrwValidate({
    String? rukun,
    String? value,
    String? values,
  }) {
    if (rukun!.isEmpty) {
      return '$values tidak boleh kosong !';
    } else if (rukun.length > 2 || rukun.length > 2) {
      return '$values tidak boleh lebih dari 2 karakter !';
    }
    return null;
  }

  /// validate password
  static String? passwordValidate({
    String? password,
    String? confirmPassword,
    String? value,
  }) {
    if (password!.isEmpty || confirmPassword!.isEmpty) {
      return '$value tidak boleh kosong !';
    } else if (password.length < 8 || confirmPassword.length < 8) {
      return '$value harus lebih dari 8 karakter !';
    } else if (!RegExp('.*[A-Z].*').hasMatch(password)) {
      return '$value harus memiliki 1 huruf uppercase !';
    } else if (!RegExp('.*[0-9].*').hasMatch(password)) {
      return '$value harus mengandung angka !';
    } else if (password != confirmPassword) {
      return '$value harus sama !';
    }
    return null;
  }
}
