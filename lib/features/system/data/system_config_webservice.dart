import 'dart:async';

import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/system/domain/system_config.dart';

class SystemConfigWebservice extends Webservice {
  Future<SystemConfig> performRequest() async {
    final response = await dio.get(
      "https://playtennishk.s3.ap-southeast-1.amazonaws.com/system-config.json",
    );

    try {
      final systemConfig = SystemConfig.fromJson(response.data);

      return systemConfig;
    } catch (err) {
      rethrow;
    }
  }
}
