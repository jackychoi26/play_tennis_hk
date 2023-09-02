import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/scrollable_error_text.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_offset_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TennisMatchList extends ConsumerWidget {
  const TennisMatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future refresh() async {
      ref.read(tennisMatchesProvider.notifier).clearMatches();
      ref.read(tennisMatchesOffsetProvider.notifier).resetOffset();
      final offset = ref.read(tennisMatchesOffsetProvider);
      ref.read(tennisMatchesProvider.notifier).getTennisMatches(offset: offset);
    }

    void loadMore() {
      ref.read(tennisMatchesOffsetProvider.notifier).incrementOffset();
      final offset = ref.read(tennisMatchesOffsetProvider);
      ref.read(tennisMatchesProvider.notifier).getTennisMatches(offset: offset);
    }

    final tennisMatches = ref.watch(tennisMatchesProvider);

    return RefreshIndicator(
      onRefresh: refresh,
      child: tennisMatches.when(
        loading: () => const Center(child: CupertinoActivityIndicator()),
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
              itemCount: value.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == value.length) {
                  if (value.length % 10 != 0) {
                    return const SizedBox();
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    loadMore();
                  });
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                }
                return TennisMatchInfoCell(tennisMatch: value[index]);
              },
            );
          }
        },
        error: (err, st) => const ScrollableErrorText(),
      ),
    );
  }
}
