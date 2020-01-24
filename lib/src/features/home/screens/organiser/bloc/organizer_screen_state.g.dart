// GENERATED CODE - DO NOT MODIFY BY HAND

part of organizer_screen_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrganizerState> _$organizerStateSerializer =
    new _$OrganizerStateSerializer();

class _$OrganizerStateSerializer
    implements StructuredSerializer<OrganizerState> {
  @override
  final Iterable<Type> types = const [OrganizerState, _$OrganizerState];
  @override
  final String wireName = 'OrganizerState';

  @override
  Iterable<Object> serialize(Serializers serializers, OrganizerState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
    ];
    if (object.volunteers != null) {
      result
        ..add('volunteers')
        ..add(serializers.serialize(object.volunteers,
            specifiedType:
                const FullType(BuiltList, const [const FullType(User)])));
    }
    return result;
  }

  @override
  OrganizerState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrganizerStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'volunteers':
          result.volunteers.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(User)]))
              as BuiltList<dynamic>);
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'loading':
          result.loading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$OrganizerState extends OrganizerState {
  @override
  final BuiltList<User> volunteers;
  @override
  final String errorMessage;
  @override
  final bool loading;

  factory _$OrganizerState([void Function(OrganizerStateBuilder) updates]) =>
      (new OrganizerStateBuilder()..update(updates)).build();

  _$OrganizerState._({this.volunteers, this.errorMessage, this.loading})
      : super._() {
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('OrganizerState', 'errorMessage');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('OrganizerState', 'loading');
    }
  }

  @override
  OrganizerState rebuild(void Function(OrganizerStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizerStateBuilder toBuilder() =>
      new OrganizerStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizerState &&
        volunteers == other.volunteers &&
        errorMessage == other.errorMessage &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, volunteers.hashCode), errorMessage.hashCode),
        loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrganizerState')
          ..add('volunteers', volunteers)
          ..add('errorMessage', errorMessage)
          ..add('loading', loading))
        .toString();
  }
}

class OrganizerStateBuilder
    implements Builder<OrganizerState, OrganizerStateBuilder> {
  _$OrganizerState _$v;

  ListBuilder<User> _volunteers;
  ListBuilder<User> get volunteers =>
      _$this._volunteers ??= new ListBuilder<User>();
  set volunteers(ListBuilder<User> volunteers) =>
      _$this._volunteers = volunteers;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  OrganizerStateBuilder();

  OrganizerStateBuilder get _$this {
    if (_$v != null) {
      _volunteers = _$v.volunteers?.toBuilder();
      _errorMessage = _$v.errorMessage;
      _loading = _$v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizerState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrganizerState;
  }

  @override
  void update(void Function(OrganizerStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrganizerState build() {
    _$OrganizerState _$result;
    try {
      _$result = _$v ??
          new _$OrganizerState._(
              volunteers: _volunteers?.build(),
              errorMessage: errorMessage,
              loading: loading);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'volunteers';
        _volunteers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrganizerState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
