import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';

abstract class TennisMatchesFilterOptionsRepository {
  Future<TennisMatchesFilterOptions?> getTennisMatchesFilterOptions();
  Future<void> storeTennisMatchesFilterOptions(
    TennisMatchesFilterOptions tennisMatchesFilterOptions,
  );
}
