// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserType _$organizer = const UserType._('organizer');
const UserType _$volunteer = const UserType._('volunteer');

UserType _$valueOf(String name) {
  switch (name) {
    case 'organizer':
      return _$organizer;
    case 'volunteer':
      return _$volunteer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserType> _$values = new BuiltSet<UserType>(const <UserType>[
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
      'ORGANISATIONN_ABB',
      serializers.serialize(object.userName,
          specifiedType: const FullType(String)),
      'API_URL',
      serializers.serialize(object.apiURL,
          specifiedType: const FullType(String)),
    ];
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.organisation != null) {
      result
        ..add('ORGANISATION_NAME')
        ..add(serializers.serialize(object.organisation,
            specifiedType: const FullType(String)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(UserType)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
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
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ORGANISATION_NAME':
          result.organisation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ORGANISATIONN_ABB':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'API_URL':
          result.apiURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(UserType)) as UserType;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final String email;
  @override
  final String organisation;
  @override
  final String userName;
  @override
  final String apiURL;
  @override
  final UserType type;
  @override
  final String id;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.email,
      this.organisation,
      this.userName,
      this.apiURL,
      this.type,
      this.id})
      : super._() {
    if (userName == null) {
      throw new BuiltValueNullFieldError('User', 'userName');
    }
    if (apiURL == null) {
      throw new BuiltValueNullFieldError('User', 'apiURL');
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
        email == other.email &&
        organisation == other.organisation &&
        userName == other.userName &&
        apiURL == other.apiURL &&
        type == other.type &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, email.hashCode), organisation.hashCode),
                    userName.hashCode),
                apiURL.hashCode),
            type.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('email', email)
          ..add('organisation', organisation)
          ..add('userName', userName)
          ..add('apiURL', apiURL)
          ..add('type', type)
          ..add('id', id))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _organisation;
  String get organisation => _$this._organisation;
  set organisation(String organisation) => _$this._organisation = organisation;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _apiURL;
  String get apiURL => _$this._apiURL;
  set apiURL(String apiURL) => _$this._apiURL = apiURL;

  UserType _type;
  UserType get type => _$this._type;
  set type(UserType type) => _$this._type = type;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _organisation = _$v.organisation;
      _userName = _$v.userName;
      _apiURL = _$v.apiURL;
      _type = _$v.type;
      _id = _$v.id;
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
            email: email,
            organisation: organisation,
            userName: userName,
            apiURL: apiURL,
            type: type,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
