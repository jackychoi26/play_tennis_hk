import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesNotifier extends StateNotifier<List<TennisMatch>> {
  TennisMatchesNotifier(this.repository) : super([]) {
    _getMatches();
  }

  TennisMatchesRepositoryImpl repository;

  void updateMatches() async {
    state = await repository.getTennisMatches();
  }

  void _getMatches() async {
    state = await repository.getTennisMatches();
  }
}

final matchesProvider =
    StateNotifierProvider<TennisMatchesNotifier, List<TennisMatch>>((ref) {
  return TennisMatchesNotifier(TennisMatchesRepositoryImpl());
});
