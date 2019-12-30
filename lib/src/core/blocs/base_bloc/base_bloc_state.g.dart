// GENERATED CODE - DO NOT MODIFY BY HAND

part of base_bloc_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BaseBlocState> _$baseBlocStateSerializer =
    new _$BaseBlocStateSerializer();

class _$BaseBlocStateSerializer implements StructuredSerializer<BaseBlocState> {
  @override
  final Iterable<Type> types = const [BaseBlocState, _$BaseBlocState];
  @override
  final String wireName = 'BaseBlocState';

  @override
  Iterable<Object> serialize(Serializers serializers, BaseBlocState object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = <Object>[
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
      'isDummy',
      serializers.serialize(object.isDummy,
          specifiedType: const FullType(bool)),
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
    ];
    if (object.value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(object.value, specifiedType: parameterT));
    }
    return result;
  }

  @override
  BaseBlocState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = isUnderspecified
        ? new BaseBlocStateBuilder<BaseModel>()
        : serializers.newBuilder(specifiedType) as BaseBlocStateBuilder;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'loading':
          result.loading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isDummy':
          result.isDummy = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: parameterT) as BaseModel;
          break;
      }
    }

    return result.build();
  }
}

class _$BaseBlocState<T extends BaseModel> extends BaseBlocState<T> {
  @override
  final bool loading;
  @override
  final bool isDummy;
  @override
  final String errorMessage;
  @override
  final T value;

  factory _$BaseBlocState([void Function(BaseBlocStateBuilder<T>) updates]) =>
      (new BaseBlocStateBuilder<T>()..update(updates)).build();

  _$BaseBlocState._({this.loading, this.isDummy, this.errorMessage, this.value})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('BaseBlocState', 'loading');
    }
    if (isDummy == null) {
      throw new BuiltValueNullFieldError('BaseBlocState', 'isDummy');
    }
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('BaseBlocState', 'errorMessage');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('BaseBlocState', 'T');
    }
  }

  @override
  BaseBlocState<T> rebuild(void Function(BaseBlocStateBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseBlocStateBuilder<T> toBuilder() =>
      new BaseBlocStateBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseBlocState &&
        loading == other.loading &&
        isDummy == other.isDummy &&
        errorMessage == other.errorMessage &&
        value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, loading.hashCode), isDummy.hashCode),
            errorMessage.hashCode),
        value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseBlocState')
          ..add('loading', loading)
          ..add('isDummy', isDummy)
          ..add('errorMessage', errorMessage)
          ..add('value', value))
        .toString();
  }
}

class BaseBlocStateBuilder<T extends BaseModel>
    implements Builder<BaseBlocState<T>, BaseBlocStateBuilder<T>> {
  _$BaseBlocState<T> _$v;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  bool _isDummy;
  bool get isDummy => _$this._isDummy;
  set isDummy(bool isDummy) => _$this._isDummy = isDummy;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  T _value;
  T get value => _$this._value;
  set value(T value) => _$this._value = value;

  BaseBlocStateBuilder();

  BaseBlocStateBuilder<T> get _$this {
    if (_$v != null) {
      _loading = _$v.loading;
      _isDummy = _$v.isDummy;
      _errorMessage = _$v.errorMessage;
      _value = _$v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseBlocState<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BaseBlocState<T>;
  }

  @override
  void update(void Function(BaseBlocStateBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseBlocState<T> build() {
    final _$result = _$v ??
        new _$BaseBlocState<T>._(
            loading: loading,
            isDummy: isDummy,
            errorMessage: errorMessage,
            value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
