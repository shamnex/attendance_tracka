import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc.dart';
import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_event.dart';
import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'base_bloc_state.dart';

class BaseBlocHydrated<T extends BaseModel> extends HydratedBloc<BaseBlocEvent<T>, BaseBlocState<T>>
    with DioErrorHelper
    implements BaseBloc<T> {
  final T _value;
  final ItemCreator _builder;
  BaseBlocHydrated(T value, ItemCreator<T> builder)
      : _value = value,
        _builder = builder;

  @override
  get builder => _builder;

  @override
  @mustCallSuper
  get initialState =>
      super.initialState ??
      BaseBlocState<T>((b) => b
        ..loading = true
        ..isDummy = false
        ..value = _value
        ..errorMessage = '');

  @override
  @mustCallSuper
  Stream<BaseBlocState<T>> mapEventToState(BaseBlocEvent<T> event) async* {
    if (event is UpdateBaseBlocEvent<T>) {
      yield state.rebuild((b) => b
        ..loading = event.loading ?? false
        ..errorMessage = event.error ?? state.errorMessage
        ..isDummy = event.isDummy ?? state.isDummy
        ..value = event.value ?? state.value);
    }
  }

  void update({
    bool loading,
    bool isDummy,
    String error,
    T value,
  }) {
    add(UpdateBaseBlocEvent<T>(
        loading: loading ?? false,
        error: error ?? state.errorMessage,
        isDummy: isDummy ?? state.isDummy,
        value: value ?? state.value));
  }

  @override
  String get id => _value?.id ?? '';
  T get value => state?.value;

  @override
  BaseBlocState<T> fromJson(Map<String, dynamic> json) {
    try {
      return BaseBlocState<T>(
        (b) => b
          ..errorMessage = json['errorMessage']
          ..loading = json['loading']
          ..isDummy = json['isDummy']
          ..value = _builder(json),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(BaseBlocState<T> state) {
    try {
      return {
        'errorMessage': state.errorMessage,
        'loading': state.loading,
        'isDummy': false,
        'value': state.value.toJson(),
      };
    } catch (_) {
      return null;
    }
  }
}
