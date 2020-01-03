import 'package:validators/validators.dart' as validator;

class InputValidators {
  static String email(String value, {bool required = true}) {
    if (required) {
      if (value.isEmpty) {
        return 'Field is Required';
      }
      if (!validator.isEmail(value)) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  static String minLength(String value, {bool required = true, length = 4}) {
    if (value.isEmpty) {
      return 'Field is Required';
    }
    if (validator.isMultibyte(value)) {
      return 'Invalid Username or Email';
    }
    if (!validator.isLength(value, length)) {
      return 'Should be at least $length character${length > 1 ? 's' : ''}';
    }
    return null;
  }
}
