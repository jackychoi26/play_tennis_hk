import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/tennis_matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesNotifier
    extends StateNotifier<AsyncValue<List<TennisMatch>>> {
  TennisMatchesNotifier(this.repository) : super(const AsyncLoading()) {
    _getMatches();
  }

  TennisMatchesRepositoryImpl repository;

  Future<void> updateMatches() async {
    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }

  Future<void> _getMatches() async {
    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }

  Future<void> createMatch(TennisMatch tennisMatch) async {
    await repository.createTennisMatch(tennisMatch);

    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }

  Future<void> deleteMatch(int matchId) async {
    await repository.deleteTennisMatch(matchId);

    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }
}

final matchesProvider =
    StateNotifierProvider<TennisMatchesNotifier, AsyncValue<List<TennisMatch>>>(
        (ref) {
  return TennisMatchesNotifier(TennisMatchesRepositoryImpl());
});
