import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';

class TennisMatchList extends ConsumerWidget {
  const TennisMatchList({super.key});

  Future refresh() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tennisMatches = ref.watch(matchesProvider);

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tennisMatches.length,
        itemBuilder: (BuildContext context, int index) {
          return TennisMatchInfoCell(tennisMatch: tennisMatches[index]);
        },
      ),
    );
  }
}
