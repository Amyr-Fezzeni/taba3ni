String? Function(dynamic) phoneNumberValidator = (value) {
  return value.toString().length == 8
      ? null
      : value.toString().isEmpty
          ? "Phone number is required"
          : "Phone number invalid";
};

String? Function(dynamic) nameValidator = (value) {
  bool nameValid = RegExp(r"^[a-zA-Z]").hasMatch(value ?? " ") ||
      !RegExp("^[\u0000-\u007F]+\$").hasMatch(value ?? " ");

  return value.toString().isEmpty
      ? "Please enter your name"
      : value.toString().length < 3
          ? 'Too short'
          : !nameValid
              ? "Wrong name format"
              : null;
};

String? Function(dynamic) emailValidator = (value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value ?? " ");
  return !emailValid ? '' : null;
};

String? Function(dynamic) passwordValidator = (value) {
  String msg = "Password must include:\n";

  msg += !RegExp(r'^(?=.*?[A-Z])').hasMatch(value ?? "")
      ? "An uppercase character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[a-z])').hasMatch(value ?? "")
      ? "A lowercase character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[0-9])').hasMatch(value ?? "")
      ? "A numeric character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value ?? "")
      ? r"A special character (!@#\$&*~)" "\n"
      : "";
  msg += value.toString().length < 8 ? "A minimum of 8 character" : "";

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  var result = RegExp(pattern).hasMatch(value ?? "");

  return !result ? msg : null;
};
