import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/matchmaking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const MatchmakingScreen();
  }
}
