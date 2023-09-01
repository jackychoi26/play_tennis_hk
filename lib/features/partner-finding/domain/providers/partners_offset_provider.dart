import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnersOffsetNotifier extends StateNotifier<int> {
  PartnersOffsetNotifier() : super(0);

  void incrementOffset() {
    state += 10;
  }

  void resetOffset() {
    state = 0;
  }
}

final partnersOffsetProvider =
    StateNotifierProvider<PartnersOffsetNotifier, int>(
  (ref) => PartnersOffsetNotifier(),
);
