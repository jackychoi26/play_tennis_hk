import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/filter/domain/providers/tennis_matches_filter_options_provider.dart';
import 'package:play_tennis_hk/features/matchmaking/data/repositories/tennis_matches_repository_impl.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesNotifier
    extends StateNotifier<AsyncValue<List<TennisMatch>>> {
  TennisMatchesNotifier(
    this.repository,
  ) : super(const AsyncLoading()) {
    getTennisMatches(offset: 0);
  }

  TennisMatchesRepositoryImpl repository;

  Future<void> clearMatches() async {
    state = const AsyncData([]);
    state = const AsyncLoading();
  }

  Future<void> getTennisMatches({required int offset}) async {
    try {
      final newMatches = await repository.getTennisMatches(offset);

      final currentMatches = state.maybeWhen(
        data: (matches) => matches,
        orElse: () => [],
      );
      state = AsyncData([...currentMatches, ...newMatches]);
    } catch (err) {
      state = AsyncError(err, StackTrace.current);
    }
  }

  Future<void> createTennisMatch(TennisMatch tennisMatch) async {
    await repository.createTennisMatch(tennisMatch);

    final matches = await repository.getTennisMatches(0);

    state = AsyncData(matches);
  }

  Future<void> deleteTennisMatch(int matchId) async {
    await repository.deleteTennisMatch(matchId);

    final matches = await repository.getTennisMatches(0);

    state = AsyncData(matches);
  }
}

final tennisMatchesProvider =
    StateNotifierProvider<TennisMatchesNotifier, AsyncValue<List<TennisMatch>>>(
        (ref) {
  final tennisMatchesFilterOptions =
      ref.watch(tennisMatchesFilterOptionsProvider);
  return TennisMatchesNotifier(
      TennisMatchesRepositoryImpl(tennisMatchesFilterOptions));
});
