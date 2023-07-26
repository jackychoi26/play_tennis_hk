// Data example
// {
//     "message": "GET_SYSTEM_SETTING_SUCCESS",
//     "softUpdate": false,
//     "forcedUpdate": false,
//     "shouldClearAllData": false,
//     "isInMaintenance": false,
//     "appVersion": 1.0
// }

class SystemConfig {
  final bool softUpdate;
  final bool forcedUpdate;
  final bool shouldClearAllData;
  final bool isInMaintenance;
  final String appVersion;

  SystemConfig({
    required this.softUpdate,
    required this.forcedUpdate,
    required this.shouldClearAllData,
    required this.isInMaintenance,
    required this.appVersion,
  });

  @override
  factory SystemConfig.fromJson(Map<String, dynamic> json) {
    return SystemConfig(
      softUpdate: json['softUpdate'],
      forcedUpdate: json['forcedUpdate'],
      shouldClearAllData: json['shouldClearAllData'],
      isInMaintenance: json['isInMaintenance'],
      appVersion: json['appVersion'],
    );
  }
}
