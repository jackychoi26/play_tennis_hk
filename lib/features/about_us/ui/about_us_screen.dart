import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.aboutUs,
          textType: CustomTextType.subtitle,
        ),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage('assets/app_icon/app-icon.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  CustomText(
                    AppLocalizations.of(context)?.playTennisHk,
                    textType: CustomTextType.title,
                  ),
                  CustomText(
                    "${AppLocalizations.of(context)?.appVersion}: 1.0",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context)?.joinUs}  ",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: 'https://t.me/playtennishk',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = "https://t.me/playtennishk";
                              if (!await launchUrl(Uri.parse(url))) {
                                throw Exception("Could not launch $url");
                              }
                            }),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
