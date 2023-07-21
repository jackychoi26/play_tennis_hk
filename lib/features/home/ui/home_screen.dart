import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/matchmaking_screen.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(tokenProvider.notifier).getAccessToken();
    ref.read(userProfileProvider.notifier).loadUserProfile();

    return const MatchmakingScreen();
  }
}
