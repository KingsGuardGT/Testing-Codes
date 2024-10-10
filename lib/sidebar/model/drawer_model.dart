// lib/sidebar/model/drawer_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawer_model.freezed.dart';
part 'drawer_model.g.dart';

@freezed
class DrawerImages with _$DrawerImages {
  const factory DrawerImages({
    required String title,
    String? imagePath,
  }) = _DrawerImages;

  factory DrawerImages.fromJson(Map<String, dynamic> json) => _$DrawerImagesFromJson(json);
}