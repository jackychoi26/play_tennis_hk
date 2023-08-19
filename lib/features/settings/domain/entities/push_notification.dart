class PushNotification {
  final bool badWeatherPush;
  final String? fcmToken;

  const PushNotification({
    required this.badWeatherPush,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'badWeatherPush': badWeatherPush,
      'fcmToken': fcmToken,
    };
  }

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      badWeatherPush: json['badWeatherPush'],
      fcmToken: json['fcmToken'],
    );
  }
}
