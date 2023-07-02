import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match_list.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/usecases/get_match_list.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  final _getMatchList = GetMatchList();

  MatchList? matchList;

  void init() async {
    // matchList = await _getMatchList.execute();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    init();
    print(matchList);
    return Container();
  }
}
