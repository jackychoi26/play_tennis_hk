import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_drawer.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/partner_list.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matchmaking")),
      body: const Center(
        child: PartnerList(),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
