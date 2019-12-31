// GENERATED CODE - DO NOT MODIFY BY HAND

part of sign_up_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SignupState> _$signupStateSerializer = new _$SignupStateSerializer();

class _$SignupStateSerializer implements StructuredSerializer<SignupState> {
  @override
  final Iterable<Type> types = const [SignupState, _$SignupState];
  @override
  final String wireName = 'SignupState';

  @override
  Iterable<Object> serialize(Serializers serializers, SignupState object,
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
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
      'signedUp',
      serializers.serialize(object.signedUp,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  SignupState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignupStateBuilder();

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
        case 'loading':
          result.loading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'signedUp':
          result.signedUp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SignupState extends SignupState {
  @override
  final String organization;
  @override
  final String password;
  @override
  final String email;
  @override
  final String errorMessage;
  @override
  final bool loading;
  @override
  final bool signedUp;

  factory _$SignupState([void Function(SignupStateBuilder) updates]) =>
      (new SignupStateBuilder()..update(updates)).build();

  _$SignupState._(
      {this.organization,
      this.password,
      this.email,
      this.errorMessage,
      this.loading,
      this.signedUp})
      : super._() {
    if (organization == null) {
      throw new BuiltValueNullFieldError('SignupState', 'organization');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('SignupState', 'password');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('SignupState', 'email');
    }
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('SignupState', 'errorMessage');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('SignupState', 'loading');
    }
    if (signedUp == null) {
      throw new BuiltValueNullFieldError('SignupState', 'signedUp');
    }
  }

  @override
  SignupState rebuild(void Function(SignupStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignupStateBuilder toBuilder() => new SignupStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignupState &&
        organization == other.organization &&
        password == other.password &&
        email == other.email &&
        errorMessage == other.errorMessage &&
        loading == other.loading &&
        signedUp == other.signedUp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, organization.hashCode), password.hashCode),
                    email.hashCode),
                errorMessage.hashCode),
            loading.hashCode),
        signedUp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignupState')
          ..add('organization', organization)
          ..add('password', password)
          ..add('email', email)
          ..add('errorMessage', errorMessage)
          ..add('loading', loading)
          ..add('signedUp', signedUp))
        .toString();
  }
}

class SignupStateBuilder implements Builder<SignupState, SignupStateBuilder> {
  _$SignupState _$v;

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

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  bool _signedUp;
  bool get signedUp => _$this._signedUp;
  set signedUp(bool signedUp) => _$this._signedUp = signedUp;

  SignupStateBuilder();

  SignupStateBuilder get _$this {
    if (_$v != null) {
      _organization = _$v.organization;
      _password = _$v.password;
      _email = _$v.email;
      _errorMessage = _$v.errorMessage;
      _loading = _$v.loading;
      _signedUp = _$v.signedUp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignupState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SignupState;
  }

  @override
  void update(void Function(SignupStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignupState build() {
    final _$result = _$v ??
        new _$SignupState._(
            organization: organization,
            password: password,
            email: email,
            errorMessage: errorMessage,
            loading: loading,
            signedUp: signedUp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new