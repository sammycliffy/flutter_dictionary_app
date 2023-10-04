String? emailValidation(String? email) {
  bool validateEmail = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email!.trim().toLowerCase());
  if (!validateEmail) {
    return 'Email is not valid';
  }
  return null;
}

String? passwordValidation(String? string) =>
    string!.length < 6 ? 'Atleast 6 characters is expected' : null;
