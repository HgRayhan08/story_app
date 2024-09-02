// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListStoryModel _$ListStoryModelFromJson(Map<String, dynamic> json) {
  return _ListStoryModel.fromJson(json);
}

/// @nodoc
mixin _$ListStoryModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<StoryModel?>? get listStory => throw _privateConstructorUsedError;

  /// Serializes this ListStoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListStoryModelCopyWith<ListStoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListStoryModelCopyWith<$Res> {
  factory $ListStoryModelCopyWith(
          ListStoryModel value, $Res Function(ListStoryModel) then) =
      _$ListStoryModelCopyWithImpl<$Res, ListStoryModel>;
  @useResult
  $Res call({bool error, String message, List<StoryModel?>? listStory});
}

/// @nodoc
class _$ListStoryModelCopyWithImpl<$Res, $Val extends ListStoryModel>
    implements $ListStoryModelCopyWith<$Res> {
  _$ListStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = freezed,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: freezed == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListStoryModelImplCopyWith<$Res>
    implements $ListStoryModelCopyWith<$Res> {
  factory _$$ListStoryModelImplCopyWith(_$ListStoryModelImpl value,
          $Res Function(_$ListStoryModelImpl) then) =
      __$$ListStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, List<StoryModel?>? listStory});
}

/// @nodoc
class __$$ListStoryModelImplCopyWithImpl<$Res>
    extends _$ListStoryModelCopyWithImpl<$Res, _$ListStoryModelImpl>
    implements _$$ListStoryModelImplCopyWith<$Res> {
  __$$ListStoryModelImplCopyWithImpl(
      _$ListStoryModelImpl _value, $Res Function(_$ListStoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = freezed,
  }) {
    return _then(_$ListStoryModelImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: freezed == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListStoryModelImpl
    with DiagnosticableTreeMixin
    implements _ListStoryModel {
  _$ListStoryModelImpl(
      {required this.error,
      required this.message,
      final List<StoryModel?>? listStory})
      : _listStory = listStory;

  factory _$ListStoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListStoryModelImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<StoryModel?>? _listStory;
  @override
  List<StoryModel?>? get listStory {
    final value = _listStory;
    if (value == null) return null;
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListStoryModel(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ListStoryModel'))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('listStory', listStory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStoryModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  /// Create a copy of ListStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStoryModelImplCopyWith<_$ListStoryModelImpl> get copyWith =>
      __$$ListStoryModelImplCopyWithImpl<_$ListStoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListStoryModelImplToJson(
      this,
    );
  }
}

abstract class _ListStoryModel implements ListStoryModel {
  factory _ListStoryModel(
      {required final bool error,
      required final String message,
      final List<StoryModel?>? listStory}) = _$ListStoryModelImpl;

  factory _ListStoryModel.fromJson(Map<String, dynamic> json) =
      _$ListStoryModelImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  List<StoryModel?>? get listStory;

  /// Create a copy of ListStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListStoryModelImplCopyWith<_$ListStoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
