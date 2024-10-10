// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidebar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SidebarState {
  int get selectedIndex => throw _privateConstructorUsedError;
  bool get isCollapsed => throw _privateConstructorUsedError;

  /// Create a copy of SidebarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SidebarStateCopyWith<SidebarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidebarStateCopyWith<$Res> {
  factory $SidebarStateCopyWith(
          SidebarState value, $Res Function(SidebarState) then) =
      _$SidebarStateCopyWithImpl<$Res, SidebarState>;
  @useResult
  $Res call({int selectedIndex, bool isCollapsed});
}

/// @nodoc
class _$SidebarStateCopyWithImpl<$Res, $Val extends SidebarState>
    implements $SidebarStateCopyWith<$Res> {
  _$SidebarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SidebarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
    Object? isCollapsed = null,
  }) {
    return _then(_value.copyWith(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCollapsed: null == isCollapsed
          ? _value.isCollapsed
          : isCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SidebarStateImplCopyWith<$Res>
    implements $SidebarStateCopyWith<$Res> {
  factory _$$SidebarStateImplCopyWith(
          _$SidebarStateImpl value, $Res Function(_$SidebarStateImpl) then) =
      __$$SidebarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedIndex, bool isCollapsed});
}

/// @nodoc
class __$$SidebarStateImplCopyWithImpl<$Res>
    extends _$SidebarStateCopyWithImpl<$Res, _$SidebarStateImpl>
    implements _$$SidebarStateImplCopyWith<$Res> {
  __$$SidebarStateImplCopyWithImpl(
      _$SidebarStateImpl _value, $Res Function(_$SidebarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SidebarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
    Object? isCollapsed = null,
  }) {
    return _then(_$SidebarStateImpl(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCollapsed: null == isCollapsed
          ? _value.isCollapsed
          : isCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SidebarStateImpl implements _SidebarState {
  const _$SidebarStateImpl({this.selectedIndex = 0, this.isCollapsed = true});

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  @JsonKey()
  final bool isCollapsed;

  @override
  String toString() {
    return 'SidebarState(selectedIndex: $selectedIndex, isCollapsed: $isCollapsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SidebarStateImpl &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.isCollapsed, isCollapsed) ||
                other.isCollapsed == isCollapsed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndex, isCollapsed);

  /// Create a copy of SidebarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SidebarStateImplCopyWith<_$SidebarStateImpl> get copyWith =>
      __$$SidebarStateImplCopyWithImpl<_$SidebarStateImpl>(this, _$identity);
}

abstract class _SidebarState implements SidebarState {
  const factory _SidebarState(
      {final int selectedIndex, final bool isCollapsed}) = _$SidebarStateImpl;

  @override
  int get selectedIndex;
  @override
  bool get isCollapsed;

  /// Create a copy of SidebarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SidebarStateImplCopyWith<_$SidebarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
