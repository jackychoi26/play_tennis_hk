import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/features/profile/ui/profile_landing_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 116, 73, 185)),
            accountName: const Text(
              "JackyChoi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              "jackychoi@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            onDetailsPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileLandingScreen(),
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
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
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
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: [
                CustomText("${AppLocalizations.of(context)?.systemSetting}  "),
                const Icon(Icons.settings),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
