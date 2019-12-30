import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'base_bloc_event.dart';
import 'base_bloc_state.dart';

typedef S ItemCreator<S extends BaseModel>(Map json);

abstract class BaseBloc<T extends BaseModel> extends Bloc<BaseBlocEvent<T>, BaseBlocState<T>> with DioErrorHelper {
  @mustCallSuper
  BaseBlocState<T> get initialState;

  @override
  Stream<BaseBlocState<T>> transformEvents(
    Stream<BaseBlocEvent<T>> events,
    Stream<BaseBlocState<T>> Function(BaseBlocEvent<T> event) next,
  );

  @override
  Stream<BaseBlocState<T>> transformStates(Stream<BaseBlocState<T>> states);

  @override
  @mustCallSuper
  Stream<BaseBlocState<T>> mapEventToState(BaseBlocEvent<T> event);

  String get id;

  T get value;
  ItemCreator get builder;

  BaseBlocState<T> fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(BaseBlocState<T> state);

  update({
    bool loading,
    bool isDummy,
    String error,
    T value,
  });
}
