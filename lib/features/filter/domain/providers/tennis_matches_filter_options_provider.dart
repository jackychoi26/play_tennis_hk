import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/filter/data/tennis_matches_filter_options_repository_impl.dart';
import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';
import 'package:play_tennis_hk/features/filter/domain/repositories/tennis_matches_filter_options_repository.dart';

class TennisMatchesFilterOptionsNotifier
    extends StateNotifier<AsyncValue<TennisMatchesFilterOptions?>> {
  TennisMatchesFilterOptionsNotifier(this.repository)
      : super(const AsyncLoading()) {
    getTennisMatchesFilterOptions();
  }

  final TennisMatchesFilterOptionsRepository repository;

  Future<void> getTennisMatchesFilterOptions() async {
    final filterOptions = await repository.getTennisMatchesFilterOptions();
    state = AsyncData(filterOptions);
  }

  Future<void> storeTennisMatchesFilterOptions(
    TennisMatchesFilterOptions tennisMatchesFilterOptions,
  ) async {
    await repository.storeTennisMatchesFilterOptions(
      tennisMatchesFilterOptions,
    );
    state = AsyncData(tennisMatchesFilterOptions);
  }
}

final tennisMatchesFilterOptionsProvider = StateNotifierProvider<
    TennisMatchesFilterOptionsNotifier,
    AsyncValue<TennisMatchesFilterOptions?>>(
  (ref) {
    return TennisMatchesFilterOptionsNotifier(
      TennisMatchesFilterOptionsRepositoryImpl(),
    );
  },
);
