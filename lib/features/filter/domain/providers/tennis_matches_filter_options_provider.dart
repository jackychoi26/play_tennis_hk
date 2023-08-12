import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';

class TennisMatchesFilterOptionsNotifier
    extends StateNotifier<TennisMatchesFilterOptions?> {
  TennisMatchesFilterOptionsNotifier() : super(null);

  TennisMatchesFilterOptions? getStoredFilterOptions() {
    return null;
  }

  void storeFilterOptions(TennisMatchesFilterOptions filterOption) {}
}

final filterOptionsProvider = StateNotifierProvider<
    TennisMatchesFilterOptionsNotifier, TennisMatchesFilterOptions?>((ref) {
  return TennisMatchesFilterOptionsNotifier();
});
