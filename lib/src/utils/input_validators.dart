import 'package:validators/validators.dart' as validator;

class InputValidators {
  static String email(String value, {bool required = true}) {
    if (required) {
      if (value.isEmpty) {
        return 'Field is Required';
      }
      if (validator.isMultibyte(value)) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  static String minLength(String value, {bool required = true, min = 4}) {
    if (value.isEmpty) {
      return 'Field is Required';
    }
    if (validator.isMultibyte(value)) {
      return 'Invalid Username or Email';
    }
    if (!validator.isLength(value, min)) {
      return 'Should be at least min character${min > 1 ? 's' : ''}';
    }
    return null;
  }
}
