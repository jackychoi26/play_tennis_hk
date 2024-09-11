import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/scrollable_error_text.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/chat/domain/entities/conversation.dart';
import 'package:play_tennis_hk/features/chat/ui/screens/conversation_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_offset_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_detail_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TennisMatchListScreen extends ConsumerStatefulWidget {
  const TennisMatchListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TennisMatchListScreenState();
}

class TennisMatchListScreenState extends ConsumerState<TennisMatchListScreen> {
  num currentValueLength = 0;

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

  @override
  Widget build(BuildContext context) {
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
                      child: CustomText(AppLocalizations.of(context)?.noTennisMatchesNow),
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
                  if (value.length == currentValueLength) {
                    return const SizedBox();
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      currentValueLength = value.length;
                    });
                    loadMore();
                  });

                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConversationScreen(conversationId: "conversationId"),
                      ),
                    );
                  },
                  child: TennisMatchDetailCard(
                    tennisMatch: value[index],
                    shouldShowAllRemarks: false,
                  ),
                );
              },
            );
          }
        },
        error: (err, st) => const ScrollableErrorText(),
      ),
    );
  }
}
