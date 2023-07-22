import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TennisMatchList extends ConsumerWidget {
  const TennisMatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future refresh() async {
      ref.read(matchesProvider.notifier).updateMatches();
    }

    final tennisMatches = ref.watch(matchesProvider);

    return RefreshIndicator(
      onRefresh: refresh,
      child: tennisMatches.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (value) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              return TennisMatchInfoCell(tennisMatch: value[index]);
            },
          );
        },
        error: (err, st) => Center(
          child: CustomText(AppLocalizations.of(context)?.somethingWentWrong),
        ),
      ),
    );
  }
}
