// GENERATED CODE - DO NOT MODIFY BY HAND

part of login_up_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LoginState> _$loginStateSerializer = new _$LoginStateSerializer();

class _$LoginStateSerializer implements StructuredSerializer<LoginState> {
  @override
  final Iterable<Type> types = const [LoginState, _$LoginState];
  @override
  final String wireName = 'LoginState';

  @override
  Iterable<Object> serialize(Serializers serializers, LoginState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'apiURL',
      serializers.serialize(object.apiURL,
          specifiedType: const FullType(String)),
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
    ];
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }
    return result;
  }

  @override
  LoginState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'apiURL':
          result.apiURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
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

class _$LoginState extends LoginState {
  @override
  final String password;
  @override
  final String email;
  @override
  final String username;
  @override
  final String apiURL;
  @override
  final User user;
  @override
  final String errorMessage;
  @override
  final bool loading;

  factory _$LoginState([void Function(LoginStateBuilder) updates]) =>
      (new LoginStateBuilder()..update(updates)).build();

  _$LoginState._(
      {this.password,
      this.email,
      this.username,
      this.apiURL,
      this.user,
      this.errorMessage,
      this.loading})
      : super._() {
    if (password == null) {
      throw new BuiltValueNullFieldError('LoginState', 'password');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('LoginState', 'email');
    }
    if (apiURL == null) {
      throw new BuiltValueNullFieldError('LoginState', 'apiURL');
    }
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('LoginState', 'errorMessage');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('LoginState', 'loading');
    }
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState &&
        password == other.password &&
        email == other.email &&
        username == other.username &&
        apiURL == other.apiURL &&
        user == other.user &&
        errorMessage == other.errorMessage &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, password.hashCode), email.hashCode),
                        username.hashCode),
                    apiURL.hashCode),
                user.hashCode),
            errorMessage.hashCode),
        loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginState')
          ..add('password', password)
          ..add('email', email)
          ..add('username', username)
          ..add('apiURL', apiURL)
          ..add('user', user)
          ..add('errorMessage', errorMessage)
          ..add('loading', loading))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState _$v;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _apiURL;
  String get apiURL => _$this._apiURL;
  set apiURL(String apiURL) => _$this._apiURL = apiURL;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    if (_$v != null) {
      _password = _$v.password;
      _email = _$v.email;
      _username = _$v.username;
      _apiURL = _$v.apiURL;
      _user = _$v.user?.toBuilder();
      _errorMessage = _$v.errorMessage;
      _loading = _$v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginState build() {
    _$LoginState _$result;
    try {
      _$result = _$v ??
          new _$LoginState._(
              password: password,
              email: email,
              username: username,
              apiURL: apiURL,
              user: _user?.build(),
              errorMessage: errorMessage,
              loading: loading);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
