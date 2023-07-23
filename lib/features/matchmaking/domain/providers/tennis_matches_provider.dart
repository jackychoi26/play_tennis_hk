import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/tennis_matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesNotifier
    extends StateNotifier<AsyncValue<List<TennisMatch>>> {
  TennisMatchesNotifier(this.repository) : super(const AsyncLoading()) {
    _getMatches();
  }

  TennisMatchesRepositoryImpl repository;

  void updateMatches() async {
    state = const AsyncLoading();

    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }

  void _getMatches() async {
    state = const AsyncLoading();

    final matches = await repository.getTennisMatches();

    state = AsyncData(matches);
  }

  void createMatch(TennisMatch tennisMatch) async {
    state = const AsyncLoading();
    try {
      await repository.createTennisMatch(tennisMatch);

      final matches = await repository.getTennisMatches();

      state = AsyncData(matches);
    } catch (err) {
      log("Error creating match: $err");
      state = AsyncValue.error(err, StackTrace.current);

      log("state: $state");
    }
  }

  void deleteMatch(int matchId) async {
    state = const AsyncLoading();
    
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
