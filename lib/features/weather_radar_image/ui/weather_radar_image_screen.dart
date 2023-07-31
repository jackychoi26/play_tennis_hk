import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WeatherRadarImageScreen extends ConsumerStatefulWidget {
  const WeatherRadarImageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WeatherRadarImageScreenState();
  }
}

class WeatherRadarImageScreenState
    extends ConsumerState<WeatherRadarImageScreen> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );

  String _getLocalizedRadarImagePath(BuildContext context) {
    // TODO: move the locale mapping logic to enum
    final localeName = AppLocalizations.of(context)?.localeName;
    return "https://www.hko.gov.hk/${localeName == "zh" ? "tc" : "en"}/wxinfo/radars/radar_range1.htm";
  }

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(_getLocalizedRadarImagePath(context)));

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.weatherRadarImage,
          textType: CustomTextType.subtitle,
        ),
      ),
      drawer: const CustomDrawer(),
      body: WebViewWidget(controller: controller),
    );
  }
}
