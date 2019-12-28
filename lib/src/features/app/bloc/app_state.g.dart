// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'hasOnboarded',
      serializers.serialize(object.hasOnboarded,
          specifiedType: const FullType(bool)),
      'loading',
      serializers.serialize(object.loading,
          specifiedType: const FullType(bool)),
      'flavor',
      serializers.serialize(object.flavor,
          specifiedType: const FullType(Flavor)),
      'mode',
      serializers.serialize(object.mode,
          specifiedType: const FullType(AppMode)),
      'theme',
      serializers.serialize(object.theme,
          specifiedType: const FullType(AppTheme)),
      'hasCompletedWalkThrough',
      serializers.serialize(object.hasCompletedWalkThrough,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'hasOnboarded':
          result.hasOnboarded = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'loading':
          result.loading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'flavor':
          result.flavor = serializers.deserialize(value,
              specifiedType: const FullType(Flavor)) as Flavor;
          break;
        case 'mode':
          result.mode = serializers.deserialize(value,
              specifiedType: const FullType(AppMode)) as AppMode;
          break;
        case 'theme':
          result.theme = serializers.deserialize(value,
              specifiedType: const FullType(AppTheme)) as AppTheme;
          break;
        case 'hasCompletedWalkThrough':
          result.hasCompletedWalkThrough = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final bool hasOnboarded;
  @override
  final bool loading;
  @override
  final Flavor flavor;
  @override
  final AppMode mode;
  @override
  final AppTheme theme;
  @override
  final bool hasCompletedWalkThrough;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.hasOnboarded,
      this.loading,
      this.flavor,
      this.mode,
      this.theme,
      this.hasCompletedWalkThrough})
      : super._() {
    if (hasOnboarded == null) {
      throw new BuiltValueNullFieldError('AppState', 'hasOnboarded');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('AppState', 'loading');
    }
    if (flavor == null) {
      throw new BuiltValueNullFieldError('AppState', 'flavor');
    }
    if (mode == null) {
      throw new BuiltValueNullFieldError('AppState', 'mode');
    }
    if (theme == null) {
      throw new BuiltValueNullFieldError('AppState', 'theme');
    }
    if (hasCompletedWalkThrough == null) {
      throw new BuiltValueNullFieldError('AppState', 'hasCompletedWalkThrough');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        hasOnboarded == other.hasOnboarded &&
        loading == other.loading &&
        flavor == other.flavor &&
        mode == other.mode &&
        theme == other.theme &&
        hasCompletedWalkThrough == other.hasCompletedWalkThrough;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, hasOnboarded.hashCode), loading.hashCode),
                    flavor.hashCode),
                mode.hashCode),
            theme.hashCode),
        hasCompletedWalkThrough.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('hasOnboarded', hasOnboarded)
          ..add('loading', loading)
          ..add('flavor', flavor)
          ..add('mode', mode)
          ..add('theme', theme)
          ..add('hasCompletedWalkThrough', hasCompletedWalkThrough))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _hasOnboarded;
  bool get hasOnboarded => _$this._hasOnboarded;
  set hasOnboarded(bool hasOnboarded) => _$this._hasOnboarded = hasOnboarded;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  Flavor _flavor;
  Flavor get flavor => _$this._flavor;
  set flavor(Flavor flavor) => _$this._flavor = flavor;

  AppMode _mode;
  AppMode get mode => _$this._mode;
  set mode(AppMode mode) => _$this._mode = mode;

  AppTheme _theme;
  AppTheme get theme => _$this._theme;
  set theme(AppTheme theme) => _$this._theme = theme;

  bool _hasCompletedWalkThrough;
  bool get hasCompletedWalkThrough => _$this._hasCompletedWalkThrough;
  set hasCompletedWalkThrough(bool hasCompletedWalkThrough) =>
      _$this._hasCompletedWalkThrough = hasCompletedWalkThrough;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _hasOnboarded = _$v.hasOnboarded;
      _loading = _$v.loading;
      _flavor = _$v.flavor;
      _mode = _$v.mode;
      _theme = _$v.theme;
      _hasCompletedWalkThrough = _$v.hasCompletedWalkThrough;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    final _$result = _$v ??
        new _$AppState._(
            hasOnboarded: hasOnboarded,
            loading: loading,
            flavor: flavor,
            mode: mode,
            theme: theme,
            hasCompletedWalkThrough: hasCompletedWalkThrough);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
