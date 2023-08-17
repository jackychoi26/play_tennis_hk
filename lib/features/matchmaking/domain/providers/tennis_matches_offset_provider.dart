import 'package:flutter_riverpod/flutter_riverpod.dart';

class TennisMatchesOffsetNotifier extends StateNotifier<int> {
  TennisMatchesOffsetNotifier() : super(0);

  void incrementOffset() {
    state += 10;
  }

  void resetOffset() {
    state = 0;
  }
}

final tennisMatchesOffsetProvider =
    StateNotifierProvider<TennisMatchesOffsetNotifier, int>(
  (ref) => TennisMatchesOffsetNotifier(),
);
