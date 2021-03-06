// GENERATED CODE - DO NOT MODIFY BY HAND

part of participants_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ParticipantsState> _$participantsStateSerializer =
    new _$ParticipantsStateSerializer();

class _$ParticipantsStateSerializer
    implements StructuredSerializer<ParticipantsState> {
  @override
  final Iterable<Type> types = const [ParticipantsState, _$ParticipantsState];
  @override
  final String wireName = 'ParticipantsState';

  @override
  Iterable<Object> serialize(Serializers serializers, ParticipantsState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
    ];
    if (object.meetup != null) {
      result
        ..add('meetup')
        ..add(serializers.serialize(object.meetup,
            specifiedType:
                const FullType(BuiltList, const [const FullType(MeetUp)])));
    }
    return result;
  }

  @override
  ParticipantsState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ParticipantsStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'meetup':
          result.meetup.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(MeetUp)]))
              as BuiltList<dynamic>);
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

class _$ParticipantsState extends ParticipantsState {
  @override
  final String errorMessage;
  @override
  final BuiltList<MeetUp> meetup;
  @override
  final bool loading;

  factory _$ParticipantsState(
          [void Function(ParticipantsStateBuilder) updates]) =>
      (new ParticipantsStateBuilder()..update(updates)).build();

  _$ParticipantsState._({this.errorMessage, this.meetup, this.loading})
      : super._() {
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('ParticipantsState', 'errorMessage');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('ParticipantsState', 'loading');
    }
  }

  @override
  ParticipantsState rebuild(void Function(ParticipantsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParticipantsStateBuilder toBuilder() =>
      new ParticipantsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParticipantsState &&
        errorMessage == other.errorMessage &&
        meetup == other.meetup &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, errorMessage.hashCode), meetup.hashCode), loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ParticipantsState')
          ..add('errorMessage', errorMessage)
          ..add('meetup', meetup)
          ..add('loading', loading))
        .toString();
  }
}

class ParticipantsStateBuilder
    implements Builder<ParticipantsState, ParticipantsStateBuilder> {
  _$ParticipantsState _$v;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  ListBuilder<MeetUp> _meetup;
  ListBuilder<MeetUp> get meetup =>
      _$this._meetup ??= new ListBuilder<MeetUp>();
  set meetup(ListBuilder<MeetUp> meetup) => _$this._meetup = meetup;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  ParticipantsStateBuilder();

  ParticipantsStateBuilder get _$this {
    if (_$v != null) {
      _errorMessage = _$v.errorMessage;
      _meetup = _$v.meetup?.toBuilder();
      _loading = _$v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParticipantsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ParticipantsState;
  }

  @override
  void update(void Function(ParticipantsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ParticipantsState build() {
    _$ParticipantsState _$result;
    try {
      _$result = _$v ??
          new _$ParticipantsState._(
              errorMessage: errorMessage,
              meetup: _meetup?.build(),
              loading: loading);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'meetup';
        _meetup?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ParticipantsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
