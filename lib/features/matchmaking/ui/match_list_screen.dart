import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/usecases/get_match_list.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match_list.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/match_info_cell.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  final _getMatchList = GetMatchList();

  List<Match> matches = List.empty();
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    try {
      print("Hello");
      MatchList matchList = await _getMatchList.execute();
      print(matchList.runtimeType);
      setState(() {
        matches = matchList.matchList;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        for (var match in matches)
          MatchInfoCell(
              dateTime: match.startDateTime,
              location: match.location,
              ustaLevelRange: match.ustaLevelRange,
              description: "sajdiaoj")
      ],
    );
  }
}
