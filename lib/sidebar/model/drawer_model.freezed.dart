// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DrawerImages _$DrawerImagesFromJson(Map<String, dynamic> json) {
  return _DrawerImages.fromJson(json);
}

/// @nodoc
mixin _$DrawerImages {
  String get title => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;

  /// Serializes this DrawerImages to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrawerImages
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawerImagesCopyWith<DrawerImages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawerImagesCopyWith<$Res> {
  factory $DrawerImagesCopyWith(
          DrawerImages value, $Res Function(DrawerImages) then) =
      _$DrawerImagesCopyWithImpl<$Res, DrawerImages>;
  @useResult
  $Res call({String title, String? imagePath});
}

/// @nodoc
class _$DrawerImagesCopyWithImpl<$Res, $Val extends DrawerImages>
    implements $DrawerImagesCopyWith<$Res> {
  _$DrawerImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawerImages
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrawerImagesImplCopyWith<$Res>
    implements $DrawerImagesCopyWith<$Res> {
  factory _$$DrawerImagesImplCopyWith(
          _$DrawerImagesImpl value, $Res Function(_$DrawerImagesImpl) then) =
      __$$DrawerImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? imagePath});
}

/// @nodoc
class __$$DrawerImagesImplCopyWithImpl<$Res>
    extends _$DrawerImagesCopyWithImpl<$Res, _$DrawerImagesImpl>
    implements _$$DrawerImagesImplCopyWith<$Res> {
  __$$DrawerImagesImplCopyWithImpl(
      _$DrawerImagesImpl _value, $Res Function(_$DrawerImagesImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawerImages
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? imagePath = freezed,
  }) {
    return _then(_$DrawerImagesImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawerImagesImpl implements _DrawerImages {
  const _$DrawerImagesImpl({required this.title, this.imagePath});

  factory _$DrawerImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawerImagesImplFromJson(json);

  @override
  final String title;
  @override
  final String? imagePath;

  @override
  String toString() {
    return 'DrawerImages(title: $title, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawerImagesImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, imagePath);

  /// Create a copy of DrawerImages
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawerImagesImplCopyWith<_$DrawerImagesImpl> get copyWith =>
      __$$DrawerImagesImplCopyWithImpl<_$DrawerImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawerImagesImplToJson(
      this,
    );
  }
}

abstract class _DrawerImages implements DrawerImages {
  const factory _DrawerImages(
      {required final String title,
      final String? imagePath}) = _$DrawerImagesImpl;

  factory _DrawerImages.fromJson(Map<String, dynamic> json) =
      _$DrawerImagesImpl.fromJson;

  @override
  String get title;
  @override
  String? get imagePath;

  /// Create a copy of DrawerImages
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawerImagesImplCopyWith<_$DrawerImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
