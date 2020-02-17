import 'dart:async';

import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../mark_attendance_repository.dart';

part 'mark_attendance_event.dart';
part 'mark_attendance_state.dart';

class MarkAttendanceBloc extends Bloc<MarkAttendanceEvent, MarkAttendanceState> with DioErrorHelper {
  MarkAttendanceBloc(this.repo);
  final MarkAttendanceRepository repo;
  @override
  MarkAttendanceState get initialState => MarkAttendanceInitial();

  @override
  Stream<MarkAttendanceState> mapEventToState(
    MarkAttendanceEvent event,
  ) async* {
    if (event is AttendanceMarked) {
      try {
        yield MarkAttendanceLoading();
        await repo.markAttendance(
          apiURL: event.apiURL,
          email: event.email.trim(),
          iteration: event.interation,
        );
        yield MarkAttendanceSuccess();
      } on DioError catch (e) {
        yield MarkAttendanceError(handleDioError(e));
      } catch (s) {
        yield MarkAttendanceError('Something went wrong :(');
      }
    }
  }
}
