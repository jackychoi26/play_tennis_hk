import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/matchmaking_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_alert_dialog.dart';
import 'package:play_tennis_hk/features/system/data/system_config_webservice.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  void _showSystemDialog(
    BuildContext context,
    bool dismissable,
    String? title,
    String? content,
    bool isCancellable,
  ) {
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          icon: Icons.info,
          title: title,
          content: content,
          onConfirm: () async {
            Navigator.of(context).pop();
          },
          isCancellable: isCancellable,
        );
      },
    );
  }

  bool _isVersionGreater(String version1, String version2) {
    List<String> v1 = version1.split('.');
    List<String> v2 = version2.split('.');

    for (int i = 0; i < v1.length; i++) {
      int v1Part = int.parse(v1[i]);
      int v2Part = int.parse(v2[i]);

      if (v1Part > v2Part) {
        return true;
      } else if (v1Part < v2Part) {
        return false;
      }
    }

    // If loop ends without returning, versions are equal
    return false;
  }

  Future<void> _showAlertIfNeeded(BuildContext context) async {
    final systemConfig = await SystemConfigWebservice().performRequest();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final localAppVersion = packageInfo.version;
    final latestAppVersion = systemConfig.appVersion;

    if (context.mounted) {
      if (systemConfig.isInMaintenance) {
        _showSystemDialog(
          context,
          false,
          AppLocalizations.of(context)?.reminder,
          AppLocalizations.of(context)?.inMaintenance,
          false,
        );
      } else if (systemConfig.forcedUpdate &&
          _isVersionGreater(latestAppVersion, localAppVersion)) {
        _showSystemDialog(
          context,
          false,
          AppLocalizations.of(context)?.reminder,
          AppLocalizations.of(context)?.updateNeeded,
          false,
        );
      } else if (systemConfig.softUpdate &&
          _isVersionGreater(latestAppVersion, localAppVersion)) {
        _showSystemDialog(
          context,
          false,
          AppLocalizations.of(context)?.reminder,
          AppLocalizations.of(context)?.updateNeeded,
          false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      return await _showAlertIfNeeded(context);
    });

    return const MatchmakingScreen();
  }
}
