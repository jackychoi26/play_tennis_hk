import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/filter/domain/filter_options.dart';

class FilterOptionsNotifier extends StateNotifier<FilterOptions?> {
  FilterOptionsNotifier() : super(null);

  FilterOptions? getStoredFilterOptions() {
    return null;
  }

  void storeFilterOptions() {}
}

final matchesProvider =
    StateNotifierProvider<FilterOptionsNotifier, FilterOptions?>((ref) {
  return FilterOptionsNotifier();
});
