import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/tennis_matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesNotifier
    extends StateNotifier<AsyncValue<List<TennisMatch>>> {
  TennisMatchesNotifier(this.repository) : super(const AsyncLoading()) {
    getMatches();
  }

  TennisMatchesRepositoryImpl repository;

  Future<void> updateMatches() async {
    //TODO: implement updateMatches
  }

  Future<void> getMatches() async {
    try {
      final matches = await repository.getTennisMatches();

      state = AsyncData(matches);
    } catch (err) {
      if (ErrorResolver().notTimeoutException(err)) rethrow;

      state = AsyncError(err, StackTrace.current);
    }
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
