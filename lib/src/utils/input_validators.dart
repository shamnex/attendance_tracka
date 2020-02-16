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

    if (!validator.isLength(value, length)) {
      return 'Should be at least $length character${length > 1 ? 's' : ''}';
    }
    return null;
  }

  static String isURL(String value, {bool required = true, length = 4}) {
    if (value.isEmpty) {
      return 'Field is Required';
    }

    if (!validator.isURL(value)) {
      return 'Invalid URL';
    }
    return null;
  }
}
