import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/filter/domain/filters.dart';

class FilterNotifier extends StateNotifier<Filters?> {
  FilterNotifier() : super(null);

  Filters? getStoredFilters() {
    return null;
  }

  void storeFilters() {}
}

final matchesProvider = StateNotifierProvider<FilterNotifier, Filters?>((ref) {
  return FilterNotifier();
});
