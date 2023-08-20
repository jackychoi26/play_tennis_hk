import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/features/filter/ui/tennis_matches_filter_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/create_tennis_match_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_list.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';

class MatchmakingScreen extends ConsumerStatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MatchmakingScreenState();
}

class _MatchmakingScreenState extends ConsumerState<MatchmakingScreen> {
  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(tokenProvider) != null;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.matchmaking,
          textType: CustomTextType.subtitle,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TennisMatchesFilterScreen(),
                ),
              );
            },
            child: CustomText(
              AppLocalizations.of(context)?.filter,
            ),
          ),
        ],
      ),
      body: const TennisMatchList(),
      drawer: const CustomDrawer(),
      floatingActionButton: Visibility(
        visible: isLogin,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateTennisMatchScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
