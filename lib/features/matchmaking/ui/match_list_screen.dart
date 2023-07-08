import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/matches_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/match_info_cell.dart';

class MatchListScreen extends ConsumerWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(matchesProvider);

    return ListView(padding: const EdgeInsets.all(8), children: [
      for (var match in matches)
        MatchInfoCell(
          startDateTime: match.startDateTime,
          endDateTime: match.endDateTime,
          ustaLevelRange: match.ustaLevelRange,
          district: match.district,
          court: match.court,
          remarks: match.remarks,
        )
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
