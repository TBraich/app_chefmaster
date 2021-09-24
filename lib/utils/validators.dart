String validateEmail(String value) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Your email is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid emal address";
  }
  return _msg;
}

String validatePhoneNumber(String value) {
  String _msg = "";
  RegExp regex = new RegExp(r'[0-9]\b');
  if (value.isEmpty) {
    _msg = "Your phone number is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid phone number";
  }
  return _msg;
}

String validatePassword(String value) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!.%#^*?&])[A-Za-z\d@$!.#%^*?&]{8,}$');
  if (value.isEmpty) {
    _msg = "Your password is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid password";
  }
  return _msg;
}

String validateName(String value) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^[a-zA-Z]+$');
  if (value.isEmpty) {
    _msg = "Your username is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid emal address";
  }
  return _msg;
}

String validateBirthday(DateTime value) {
  String _msg = "";
  DateTime beforeYear = DateTime(1940);
  DateTime afterYear = DateTime(2021);
  if (value.isBefore(beforeYear) || value.isAfter(afterYear)) {
    _msg = "Please provide a valid datetime";
  }
  return _msg;
}

String validateConfirmPassword(String confirm) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!.%#^*?&])[A-Za-z\d@$!.#%^*?&]{8,}$');
  if (confirm.isEmpty) {
    _msg = "Your password is required";
  } else if (!regex.hasMatch(confirm)) {
    _msg = "Please provide a valid password";
  }
  return _msg;
}
