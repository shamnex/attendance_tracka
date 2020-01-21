// GENERATED CODE - DO NOT MODIFY BY HAND

part of sign_up_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrganizerSignupState> _$organizerSignupStateSerializer =
    new _$OrganizerSignupStateSerializer();

class _$OrganizerSignupStateSerializer
    implements StructuredSerializer<OrganizerSignupState> {
  @override
  final Iterable<Type> types = const [
    OrganizerSignupState,
    _$OrganizerSignupState
  ];
  @override
  final String wireName = 'OrganizerSignupState';

  @override
  Iterable<Object> serialize(
      Serializers serializers, OrganizerSignupState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'organization',
      serializers.serialize(object.organization,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
      'apiURL',
      serializers.serialize(object.apiURL,
          specifiedType: const FullType(String)),
      'organizationUserName',
      serializers.serialize(object.organizationUserName,
          specifiedType: const FullType(String)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }
    return result;
  }

  @override
  OrganizerSignupState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrganizerSignupStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'organization':
          result.organization = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'apiURL':
          result.apiURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'organizationUserName':
          result.organizationUserName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
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

class _$OrganizerSignupState extends OrganizerSignupState {
  @override
  final String organization;
  @override
  final String password;
  @override
  final String email;
  @override
  final String errorMessage;
  @override
  final String apiURL;
  @override
  final String organizationUserName;
  @override
  final User user;
  @override
  final bool loading;

  factory _$OrganizerSignupState(
          [void Function(OrganizerSignupStateBuilder) updates]) =>
      (new OrganizerSignupStateBuilder()..update(updates)).build();

  _$OrganizerSignupState._(
      {this.organization,
      this.password,
      this.email,
      this.errorMessage,
      this.apiURL,
      this.organizationUserName,
      this.user,
      this.loading})
      : super._() {
    if (organization == null) {
      throw new BuiltValueNullFieldError(
          'OrganizerSignupState', 'organization');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('OrganizerSignupState', 'password');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('OrganizerSignupState', 'email');
    }
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError(
          'OrganizerSignupState', 'errorMessage');
    }
    if (apiURL == null) {
      throw new BuiltValueNullFieldError('OrganizerSignupState', 'apiURL');
    }
    if (organizationUserName == null) {
      throw new BuiltValueNullFieldError(
          'OrganizerSignupState', 'organizationUserName');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('OrganizerSignupState', 'loading');
    }
  }

  @override
  OrganizerSignupState rebuild(
          void Function(OrganizerSignupStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizerSignupStateBuilder toBuilder() =>
      new OrganizerSignupStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizerSignupState &&
        organization == other.organization &&
        password == other.password &&
        email == other.email &&
        errorMessage == other.errorMessage &&
        apiURL == other.apiURL &&
        organizationUserName == other.organizationUserName &&
        user == other.user &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, organization.hashCode),
                                password.hashCode),
                            email.hashCode),
                        errorMessage.hashCode),
                    apiURL.hashCode),
                organizationUserName.hashCode),
            user.hashCode),
        loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrganizerSignupState')
          ..add('organization', organization)
          ..add('password', password)
          ..add('email', email)
          ..add('errorMessage', errorMessage)
          ..add('apiURL', apiURL)
          ..add('organizationUserName', organizationUserName)
          ..add('user', user)
          ..add('loading', loading))
        .toString();
  }
}

class OrganizerSignupStateBuilder
    implements Builder<OrganizerSignupState, OrganizerSignupStateBuilder> {
  _$OrganizerSignupState _$v;

  String _organization;
  String get organization => _$this._organization;
  set organization(String organization) => _$this._organization = organization;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  String _apiURL;
  String get apiURL => _$this._apiURL;
  set apiURL(String apiURL) => _$this._apiURL = apiURL;

  String _organizationUserName;
  String get organizationUserName => _$this._organizationUserName;
  set organizationUserName(String organizationUserName) =>
      _$this._organizationUserName = organizationUserName;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  OrganizerSignupStateBuilder();

  OrganizerSignupStateBuilder get _$this {
    if (_$v != null) {
      _organization = _$v.organization;
      _password = _$v.password;
      _email = _$v.email;
      _errorMessage = _$v.errorMessage;
      _apiURL = _$v.apiURL;
      _organizationUserName = _$v.organizationUserName;
      _user = _$v.user?.toBuilder();
      _loading = _$v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizerSignupState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrganizerSignupState;
  }

  @override
  void update(void Function(OrganizerSignupStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrganizerSignupState build() {
    _$OrganizerSignupState _$result;
    try {
      _$result = _$v ??
          new _$OrganizerSignupState._(
              organization: organization,
              password: password,
              email: email,
              errorMessage: errorMessage,
              apiURL: apiURL,
              organizationUserName: organizationUserName,
              user: _user?.build(),
              loading: loading);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrganizerSignupState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
