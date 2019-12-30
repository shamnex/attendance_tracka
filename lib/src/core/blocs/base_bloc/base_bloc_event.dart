import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:equatable/equatable.dart';

abstract class BaseBlocEvent<T extends BaseModel> extends Equatable {}

class UpdateBaseBlocEvent<T extends BaseModel> extends BaseBlocEvent<T> {
  final bool loading;
  final bool isDummy;
  final String error;
  final T value;
  UpdateBaseBlocEvent({this.loading = false, this.isDummy = false, this.error = '', this.value}) : super();
  @override
  String toString() => '''UPDATING $T  !!======> {
      loading: $loading
   isDummy: $isDummy
   error: $error
   value: $value
  } }''';

  @override
  List<Object> get props => [
        isDummy,
        loading,
        error,
        ...?value.toJson().values,
      ];
}
