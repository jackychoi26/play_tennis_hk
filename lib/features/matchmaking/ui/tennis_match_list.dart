import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/create_tennis_match_screen.dart';
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

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: tennisMatches.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (value) {
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
              },
              error: (err, st) => Center(
                child: CustomText(
                    AppLocalizations.of(context)?.somethingWentWrong),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 150),
                          reverseTransitionDuration:
                              Duration(milliseconds: 150),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CreateTennisMatchScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // 淡入效果
                            var fadeIn = FadeTransition(
                              opacity: animation,
                              child: child,
                            );

                            // 向上滑動效果
                            var slideUp = SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, 0.5), // 起始位置
                                end: Offset(0, 0), // 結束位置
                              ).animate(animation),
                              child: fadeIn,
                            );

                            return slideUp;
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
