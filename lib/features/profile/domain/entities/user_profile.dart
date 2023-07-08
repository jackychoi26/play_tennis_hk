import 'package:play_tennis_hk/domain/district.dart';

class UserProfile {
  final String username;
  final String email;
  final String imageUrl;
  final double ustaLevel;
  final int? age;
  final List<District>? districts;
  final String? telegram;
  final String? singal;
  final String? description;

  const UserProfile({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.ustaLevel,
    this.telegram,
    this.singal,
    this.age,
    this.districts,
    this.description,
  });
}
