import 'package:flutter/foundation.dart';

class MarkAttendanceRouteArguments {
  final int iteration;
  final String apiURL;

  MarkAttendanceRouteArguments({@required this.iteration, @required this.apiURL})
      : assert(iteration != null),
        assert(apiURL != null);
}
