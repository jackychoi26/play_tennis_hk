import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool receivePushForBadWeather = false;
  String? fcmToken;

  void requestPermission(bool swtichValue) async {
    if (swtichValue) {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        fcmToken = token;
        setState(() {
          receivePushForBadWeather = swtichValue;
        });
      }
    } else {
      setState(() {
        receivePushForBadWeather = swtichValue;
      });
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
            onPressed: () {},
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
                  value: receivePushForBadWeather,
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
