import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:equatable/equatable.dart';

class BaseBlocState<T extends BaseModel> extends Equatable {
  final bool loading;
  final bool isDummy;
  final String errorMessage;
  final T value;

  const BaseBlocState({
    this.loading = false,
    this.isDummy = false,
    this.errorMessage = '',
    this.value,
  });

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasValue => value != null && (value?.id != null ?? false || value?.createdAt != null);

  BaseBlocState<T> copyWith({
    bool loading,
    bool isDummy,
    T value,
    String errorMessage,
  }) {
    return BaseBlocState<T>(
      loading: loading ?? this.loading,
      isDummy: isDummy ?? this.isDummy,
      errorMessage: errorMessage ?? this.errorMessage,
      value: value ?? this.value,
    );
  }

  BaseBlocState<T> clear() {
    return BaseBlocState<T>(
      loading: false,
      isDummy: false,
      errorMessage: '',
      value: null,
    );
  }

  @override
  List<Object> get props => [
        loading,
        ...?value.toJson().values.toList()..removeWhere((value) => value == null),
        hasError,
        isDummy,
        errorMessage,
        hasError,
      ];

  @override
  String toString() => '''
  loading: $loading ,
  error: $errorMessage , 
  value: $value,
  isDummy: $isDummy   }''';
}
