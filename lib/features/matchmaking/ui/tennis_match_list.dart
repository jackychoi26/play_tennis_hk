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
      ref.read(tennisMatchesProvider.notifier).getTennisMatches();
    }

    final tennisMatches = ref.watch(tennisMatchesProvider);

    return RefreshIndicator(
      onRefresh: refresh,
      child: tennisMatches.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (value) {
          if (value.isEmpty) {
            return Center(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 250),
                      child: CustomText(
                          AppLocalizations.of(context)?.noTennisMatchesNow),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 8,
                bottom: 100,
              ),
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return TennisMatchInfoCell(tennisMatch: value[index]);
              },
            );
          }
        },
        error: (err, st) => Center(
          child: CustomText(AppLocalizations.of(context)?.somethingWentWrong),
        ),
      ),
    );
  }
}
