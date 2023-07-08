import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_list_screen.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(AppLocalizations.of(context)?.matchmaking),
      ),
      body: const Center(
        child: TennisMatchListScreen(),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
