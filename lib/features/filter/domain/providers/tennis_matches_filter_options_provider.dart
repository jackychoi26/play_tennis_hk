import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/filter/data/tennis_matches_filter_options_repository_impl.dart';
import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';
import 'package:play_tennis_hk/features/filter/domain/repositories/tennis_matches_filter_options_repository.dart';

class TennisMatchesFilterOptionsNotifier
    extends StateNotifier<TennisMatchesFilterOptions> {
  TennisMatchesFilterOptionsNotifier(this.repository)
      : super(
          const TennisMatchesFilterOptions(
              lowerNtrpLevel: 1.0, upperNtrpLevel: 7.0, selectedDistricts: []),
        ) {
    getTennisMatchesFilterOptions();
  }

  final TennisMatchesFilterOptionsRepository repository;

  Future<void> getTennisMatchesFilterOptions() async {
    final filterOptions = await repository.getTennisMatchesFilterOptions();
    if (filterOptions != null) {
      state = filterOptions;
    }
  }

  Future<void> storeTennisMatchesFilterOptions(
    TennisMatchesFilterOptions tennisMatchesFilterOptions,
  ) async {
    await repository.storeTennisMatchesFilterOptions(
      tennisMatchesFilterOptions,
    );
    state = tennisMatchesFilterOptions;
  }
}

final tennisMatchesFilterOptionsProvider = StateNotifierProvider<
    TennisMatchesFilterOptionsNotifier, TennisMatchesFilterOptions>(
  (ref) {
    return TennisMatchesFilterOptionsNotifier(
      TennisMatchesFilterOptionsRepositoryImpl(),
    );
  },
);
