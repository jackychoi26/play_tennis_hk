import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match.dart';

class MatchesNotifier extends StateNotifier<List<Match>> {
  MatchesNotifier(this.repository) : super([]) {
    _getMatches();
  }

  MatchesRepositoryImpl repository;

  void updateMatches() async {
    state = await repository.getMatches();
  }

  void _getMatches() async {
    state = await repository.getMatches();
  }
}

final matchesProvider =
    StateNotifierProvider<MatchesNotifier, List<Match>>((ref) {
  return MatchesNotifier(MatchesRepositoryImpl());
});
