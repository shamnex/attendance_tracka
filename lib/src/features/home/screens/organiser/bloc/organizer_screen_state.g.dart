// GENERATED CODE - DO NOT MODIFY BY HAND

part of organizer_screen_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrganizerScreenState> _$organizerScreenStateSerializer =
    new _$OrganizerScreenStateSerializer();

class _$OrganizerScreenStateSerializer
    implements StructuredSerializer<OrganizerScreenState> {
  @override
  final Iterable<Type> types = const [
    OrganizerScreenState,
    _$OrganizerScreenState
  ];
  @override
  final String wireName = 'OrganizerScreenState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, OrganizerScreenState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
    ];
    if (object.participants != null) {
      result
        ..add('participants')
        ..add(serializers.serialize(object.participants,
            specifiedType:
                const FullType(BuiltList, const [const FullType(User)])));
    }
    if (object.organizers != null) {
      result
        ..add('organizers')
        ..add(serializers.serialize(object.organizers,
            specifiedType:
                const FullType(BuiltList, const [const FullType(User)])));
    }
    return result;
  }

  @override
  OrganizerScreenState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrganizerScreenStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'participants':
          result.participants.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(User)]))
              as BuiltList<dynamic>);
          break;
        case 'organizers':
          result.organizers.replace(serializers.deserialize(value,
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

class _$OrganizerScreenState extends OrganizerScreenState {
  @override
  final BuiltList<User> participants;
  @override
  final BuiltList<User> organizers;
  @override
  final String errorMessage;
  @override
  final bool loading;

  factory _$OrganizerScreenState(
          [void Function(OrganizerScreenStateBuilder) updates]) =>
      (new OrganizerScreenStateBuilder()..update(updates)).build();

  _$OrganizerScreenState._(
      {this.participants, this.organizers, this.errorMessage, this.loading})
      : super._() {
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError(
          'OrganizerScreenState', 'errorMessage');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('OrganizerScreenState', 'loading');
    }
  }

  @override
  OrganizerScreenState rebuild(
          void Function(OrganizerScreenStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizerScreenStateBuilder toBuilder() =>
      new OrganizerScreenStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizerScreenState &&
        participants == other.participants &&
        organizers == other.organizers &&
        errorMessage == other.errorMessage &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, participants.hashCode), organizers.hashCode),
            errorMessage.hashCode),
        loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrganizerScreenState')
          ..add('participants', participants)
          ..add('organizers', organizers)
          ..add('errorMessage', errorMessage)
          ..add('loading', loading))
        .toString();
  }
}

class OrganizerScreenStateBuilder
    implements Builder<OrganizerScreenState, OrganizerScreenStateBuilder> {
  _$OrganizerScreenState _$v;

  ListBuilder<User> _participants;
  ListBuilder<User> get participants =>
      _$this._participants ??= new ListBuilder<User>();
  set participants(ListBuilder<User> participants) =>
      _$this._participants = participants;

  ListBuilder<User> _organizers;
  ListBuilder<User> get organizers =>
      _$this._organizers ??= new ListBuilder<User>();
  set organizers(ListBuilder<User> organizers) =>
      _$this._organizers = organizers;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  OrganizerScreenStateBuilder();

  OrganizerScreenStateBuilder get _$this {
    if (_$v != null) {
      _participants = _$v.participants?.toBuilder();
      _organizers = _$v.organizers?.toBuilder();
      _errorMessage = _$v.errorMessage;
      _loading = _$v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizerScreenState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrganizerScreenState;
  }

  @override
  void update(void Function(OrganizerScreenStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrganizerScreenState build() {
    _$OrganizerScreenState _$result;
    try {
      _$result = _$v ??
          new _$OrganizerScreenState._(
              participants: _participants?.build(),
              organizers: _organizers?.build(),
              errorMessage: errorMessage,
              loading: loading);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'participants';
        _participants?.build();
        _$failedField = 'organizers';
        _organizers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrganizerScreenState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
