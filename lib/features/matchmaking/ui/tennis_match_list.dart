import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';

class TennisMatchList extends ConsumerWidget {
  const TennisMatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tennisMatches = ref.watch(matchesProvider);

    return ListView(padding: const EdgeInsets.all(8), children: [
      for (var tennisMatch in tennisMatches)
        TennisMatchInfoCell(tennisMatch: tennisMatch),
      const SizedBox(
        height: 80,
      )
    ]);
  }
}
