import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/home/ui/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // generic simplified Chinese 'zh_Hans'
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // generic traditional Chinese 'zh_Hant'
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans',
            countryCode: 'CN'), // 'zh_Hans_CN'
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant',
            countryCode: 'TW'), // 'zh_Hant_TW'
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant',
            countryCode: 'HK'), // 'zh_Hant_HK'
      ],
      home: HomeScreen(),
    ),
  );
}
