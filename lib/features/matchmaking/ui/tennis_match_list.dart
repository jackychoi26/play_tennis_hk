import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_alert_dialog.dart';
import 'package:play_tennis_hk/components/custom_error_text.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/features/system/data/system_config_webservice.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TennisMatchList extends ConsumerWidget {
  const TennisMatchList({super.key});

  void _showSystemDialog(BuildContext context, bool dismissable) {
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: AppLocalizations.of(context)?.warning,
          content: AppLocalizations.of(context)?.deleteMatchConfirm,
          onConfirm: () async {},
        );
      },
    );
  }

  Future<void> _showAlertIfNeeded(BuildContext context) async {
    final systemConfig = await SystemConfigWebservice().performRequest();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final localAppVersion = packageInfo.version;
    final latestAppVersion = systemConfig.appVersion;

    if (systemConfig.isInMaintenance) {
      // TODO: show an alert that cannot be dismissed
    } else if (systemConfig.forcedUpdate &&
        _isVersionGreater(latestAppVersion, localAppVersion)) {
      // TODO: show an alert that cannot be dismissed
    } else if (systemConfig.softUpdate &&
        _isVersionGreater(latestAppVersion, localAppVersion)) {
      // TODO: show an alert that can be dismissed
    }
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      return await _showAlertIfNeeded(context);
    });

    Future refresh() async {
      ref.read(matchesProvider.notifier).getMatches();
    }

    final tennisMatches = ref.watch(matchesProvider);

    return RefreshIndicator(
      onRefresh: refresh,
      child: tennisMatches.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (value) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              return TennisMatchInfoCell(tennisMatch: value[index]);
            },
          );
        },
        error: (err, st) => const CustomErrorText(),
      ),
    );
  }
}
