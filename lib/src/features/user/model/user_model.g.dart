// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserType _$participant = const UserType._('participant');
const UserType _$organizer = const UserType._('organizer');
const UserType _$volunteer = const UserType._('volunteers');

UserType _$valueOf(String name) {
  switch (name) {
    case 'participant':
      return _$participant;
    case 'organizer':
      return _$organizer;
    case 'volunteers':
      return _$volunteer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserType> _$values = new BuiltSet<UserType>(const <UserType>[
  _$participant,
  _$organizer,
  _$volunteer,
]);

Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<UserType> _$userTypeSerializer = new _$UserTypeSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'firstName',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'lastName',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(UserType)),
    ];

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(UserType)) as UserType;
          break;
      }
    }

    return result.build();
  }
}

class _$UserTypeSerializer implements PrimitiveSerializer<UserType> {
  @override
  final Iterable<Type> types = const <Type>[UserType];
  @override
  final String wireName = 'UserType';

  @override
  Object serialize(Serializers serializers, UserType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  UserType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserType.valueOf(serialized as String);
}

class _$User extends User {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final UserType type;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.firstName, this.lastName, this.id, this.createdAt, this.type})
      : super._() {
    if (firstName == null) {
      throw new BuiltValueNullFieldError('User', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('User', 'lastName');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('User', 'createdAt');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('User', 'type');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        id == other.id &&
        createdAt == other.createdAt &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, firstName.hashCode), lastName.hashCode),
                id.hashCode),
            createdAt.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('type', type))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  UserType _type;
  UserType get type => _$this._type;
  set type(UserType type) => _$this._type = type;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _id = _$v.id;
      _createdAt = _$v.createdAt;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            firstName: firstName,
            lastName: lastName,
            id: id,
            createdAt: createdAt,
            type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
