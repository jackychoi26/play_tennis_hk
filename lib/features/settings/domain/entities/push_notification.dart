class PushNotification {
  final bool notifyBadWeather;

  const PushNotification({
    required this.notifyBadWeather,
  });

  Map<String, dynamic> toJson() {
    return {
      'notifyBadWeather': notifyBadWeather,
    };
  }

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      notifyBadWeather: json['notifyBadWeather'],
    );
  }
}
