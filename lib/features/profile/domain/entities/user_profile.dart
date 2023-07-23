import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_district.dart';

class UserProfile {
  final int? id;
  final String username;
  final String? password;
  final String? email;
  final String? imageUrl;
  final num ntrpLevel;
  final int? age;
  final String? description;
  final List<District>? districts;
  final String? telegram;
  final String? signal;
  final String? whatsapp;
  final bool? isProfilePublic;

  const UserProfile({
    required this.username,
    required this.ntrpLevel,
    this.email,
    this.password,
    this.id,
    this.imageUrl,
    this.age,
    this.districts,
    this.description,
    this.telegram,
    this.signal,
    this.whatsapp,
    this.isProfilePublic,
  });

  Map<String, dynamic> toJson() {
    final districtsList = districts?.map((e) => e.toJson()).toList();

    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'imageUrl': imageUrl,
      'ntrpLevel': ntrpLevel,
      'age': age,
      'districts': districtsList,
      'description': description,
      'telegram': telegram,
      'signal': signal,
      'whatsapp': whatsapp,
      'isProfilePublic': isProfilePublic,
    };
  }

  @override
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final districtsList = (json['districts'] as List<dynamic>).cast<String>();
    final districts = districtsList.map((e) => e.toDistrict()).toList();

    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      ntrpLevel: json['ntrpLevel'],
      age: json['age'],
      districts: districts,
      description: json['description'],
      telegram: json['telegram'],
      signal: json['signal'],
      whatsapp: json['whatsapp'],
      isProfilePublic: json['isProfilePublic'],
    );
  }
}
