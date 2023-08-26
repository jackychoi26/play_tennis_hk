import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/components/custom_snack_bar.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';
import 'package:play_tennis_hk/features/settings/domain/providers/fcm_token_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool notifyBadWeatherState;

  @override
  void initState() {
    super.initState();
    notifyBadWeatherState =
        ref.read(userProfileProvider)?.notifyBadWeather == true;
  }

  void requestPermission(bool value) async {
    setState(() {
      notifyBadWeatherState = value;
    });
  }

  Future<void> save(BuildContext context) async {
    final isLogin = ref.watch(tokenProvider) != null;
    if (!isLogin) {
      CustomSnackBar(
        message: AppLocalizations.of(context)?.loginToReceivePush,
        type: SnackBarType.info,
      ).display(context);
    }

    try {
      final hasToken =
          await ref.read(fcmTokenProvider.notifier).canGetFcmToken();

      if (hasToken) {
        ref.read(fcmTokenProvider.notifier).saveTokenIfNeeded();

        ref.read(userProfileProvider.notifier).editProfile(
              notifyBadWeather: notifyBadWeatherState,
            );

        if (context.mounted) {
          CustomSnackBar(
            message: AppLocalizations.of(context)?.updateSettingsSuccess,
            type: SnackBarType.info,
          ).display(context);
        }
      } else {
        setState(() {
          notifyBadWeatherState = false;
        });
      }
    } catch (e) {
      ErrorResolver().resolveError(e, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.settings,
          textType: CustomTextType.subtitle,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              save(context);
            },
            child: CustomText(
              AppLocalizations.of(context)?.save,
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    AppLocalizations.of(context)
                        ?.receivePushNotificationForBadWeather,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Switch(
                  value: notifyBadWeatherState,
                  activeColor: Colors.red,
                  onChanged: (bool value) {
                    requestPermission(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
