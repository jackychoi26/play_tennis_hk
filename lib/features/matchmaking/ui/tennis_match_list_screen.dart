import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_info_cell.dart';

class TennisMatchListScreen extends ConsumerWidget {
  const TennisMatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tennisMatches = ref.watch(matchesProvider);

    return ListView(padding: const EdgeInsets.all(8), children: [
      for (var tennisMatch in tennisMatches)
        TennisMatchInfoCell(tennisMatch: tennisMatch)
    ]);
  }
}

// class _MatchListScreenState extends State<MatchListScreen> {
//   List<Match> matches = List.empty();
//   @override
//   void initState() {
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: [
//         MatchInfoCell(
//             dateTime: DateTime.now(),
//             location: "asjidoas",
//             ustaLevelRange: const [1, 1.5])
//         // for (var match in matches)
//         //   MatchInfoCell(
//         //       dateTime: match.startDateTime,

//         //       ustaLevelRange: match.ustaLevelRange,
//         //       description: "sajdiaoj")
//       ],
//     );
//   }
// }
