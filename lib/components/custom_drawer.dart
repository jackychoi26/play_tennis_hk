import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/features/about_us/ui/about_us_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/matchmaking_screen.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_list_screen.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';
import 'package:play_tennis_hk/features/profile/ui/login_screen.dart';
import 'package:play_tennis_hk/features/profile/ui/profile_screen.dart';
import 'package:play_tennis_hk/features/weather_radar_image/ui/weather_radar_image_screen.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(tokenProvider) != null;
    final userProfile = ref.watch(userProfileProvider);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 0.0),
        children: [
          isLoggedIn && userProfile != null
              ? UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 116, 73, 185)),
                  accountName: CustomText(
                    userProfile.username,
                    textColor: Colors.white,
                  ),
                  accountEmail: CustomText(
                    userProfile.email,
                    textColor: Colors.white,
                  ),
                  onDetailsPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                )
              : UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 128, 112, 153),
                  ),
                  accountName: const CustomText(""),
                  accountEmail: CustomText(
                    AppLocalizations.of(context)?.loginAccount,
                    textColor: Colors.white,
                  ),
                  onDetailsPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
          ListTile(
            title: Row(
              children: [
                CustomText("${AppLocalizations.of(context)?.matchmaking}  "),
                const Icon(Icons.sports_tennis),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MatchmakingScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    }),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                CustomText("${AppLocalizations.of(context)?.findPartner}  "),
                const Icon(Icons.people)
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const PartnerListScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    }),
              );
            },
            // MaterialPageRoute(
            //   builder: (context) {
            //     return const PartnerListScreen();
            //   },
            // ),
          ),
          ListTile(
            title: Row(
              children: [
                CustomText(
                    "${AppLocalizations.of(context)?.weatherRadarImage}  "),
                const Icon(Icons.sunny),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const WeatherRadarImageScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    }),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                CustomText("${AppLocalizations.of(context)?.aboutUs}  "),
                const Icon(Icons.info),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AboutUsScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
