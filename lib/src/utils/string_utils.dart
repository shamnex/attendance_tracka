import 'dart:convert';
import 'dart:math';

class StringUtils {
  static String getEnumValue(enuum) {
    return enuum.toString().split('.').last;
  }

  static final Random _random = Random.secure();

  static String generateRandom([int length = 16]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  static bool isNullOrEmpty(String s, [bool ignoreTrailingSpace = false]) {
    if (s == null) {
      return true;
    }

    if (!ignoreTrailingSpace && s.trim().isEmpty) {
      return true;
    }
    return s.isEmpty;
  }
}
