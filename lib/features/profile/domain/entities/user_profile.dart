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
  final bool? notifyBadWeather;

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
    this.notifyBadWeather,
  });

  Map<String, dynamic> toJson() {
    final districtsList = districts?.map((e) => e.toKey()).toList();

    Map<String, dynamic> jsonMap = {};

    if (id != null) {
      jsonMap['id'] = id;
    }

    jsonMap['username'] = username;

    if (email != null) {
      jsonMap['email'] = email;
    }

    if (password != null) {
      jsonMap['password'] = password;
    }

    if (imageUrl != null) {
      jsonMap['imageUrl'] = imageUrl;
    }

    jsonMap['ntrpLevel'] = ntrpLevel;

    if (age != null) {
      jsonMap['age'] = age;
    }

    if (districtsList != null) {
      jsonMap['districts'] = districtsList;
    }

    if (description != null) {
      jsonMap['description'] = description;
    }

    if (telegram != null) {
      jsonMap['telegram'] = telegram;
    }

    if (signal != null) {
      jsonMap['signal'] = signal;
    }

    if (whatsapp != null) {
      jsonMap['whatsapp'] = whatsapp;
    }

    if (isProfilePublic != null) {
      jsonMap['isProfilePublic'] = isProfilePublic;
    }

    if (notifyBadWeather != null) {
      jsonMap['notifyBadWeather'] = notifyBadWeather;
    }

    return jsonMap;
  }

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
      notifyBadWeather: json['notifyBadWeather'],
    );
  }
}
