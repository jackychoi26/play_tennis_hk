import 'package:play_tennis_hk/features/settings/domain/entities/push_notification.dart';

class Setting {
  final PushNotification pushNotification;

  const Setting({
    required this.pushNotification,
  });

  Map<String, dynamic> toJson() {
    return {
      'pushNotification': pushNotification.toJson(),
    };
  }

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      pushNotification: PushNotification.fromJson(json['pushNotification']),
    );
  }
}
