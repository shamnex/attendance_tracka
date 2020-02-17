// GENERATED CODE - DO NOT MODIFY BY HAND

part of meetup_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MeetUp> _$meetUpSerializer = new _$MeetUpSerializer();

class _$MeetUpSerializer implements StructuredSerializer<MeetUp> {
  @override
  final Iterable<Type> types = const [MeetUp, _$MeetUp];
  @override
  final String wireName = 'MeetUp';

  @override
  Iterable<Object> serialize(Serializers serializers, MeetUp object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'attendance',
      serializers.serialize(object.attendance,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  MeetUp deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MeetUpBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'attendance':
          result.attendance.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$MeetUp extends MeetUp {
  @override
  final BuiltList<String> attendance;

  factory _$MeetUp([void Function(MeetUpBuilder) updates]) =>
      (new MeetUpBuilder()..update(updates)).build();

  _$MeetUp._({this.attendance}) : super._() {
    if (attendance == null) {
      throw new BuiltValueNullFieldError('MeetUp', 'attendance');
    }
  }

  @override
  MeetUp rebuild(void Function(MeetUpBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MeetUpBuilder toBuilder() => new MeetUpBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MeetUp && attendance == other.attendance;
  }

  @override
  int get hashCode {
    return $jf($jc(0, attendance.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MeetUp')
          ..add('attendance', attendance))
        .toString();
  }
}

class MeetUpBuilder implements Builder<MeetUp, MeetUpBuilder> {
  _$MeetUp _$v;

  ListBuilder<String> _attendance;
  ListBuilder<String> get attendance =>
      _$this._attendance ??= new ListBuilder<String>();
  set attendance(ListBuilder<String> attendance) =>
      _$this._attendance = attendance;

  MeetUpBuilder();

  MeetUpBuilder get _$this {
    if (_$v != null) {
      _attendance = _$v.attendance?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MeetUp other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MeetUp;
  }

  @override
  void update(void Function(MeetUpBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MeetUp build() {
    _$MeetUp _$result;
    try {
      _$result = _$v ?? new _$MeetUp._(attendance: attendance.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'attendance';
        attendance.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MeetUp', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
