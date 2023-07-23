import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/partner-finding/data/repositories/partner_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

final partnersRepositoryProvider = Provider((ref) => PartnersRepositoryImpl());

class PartnersNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  PartnersNotifier(this.repository) : super(const AsyncLoading()) {
    getPublicProfiles();
  }

  PartnersRepositoryImpl repository;

  void getPublicProfiles() async {
    state = const AsyncLoading();

    final partners = await repository.getPublicProfiles();

    state = AsyncData(partners);
  }

}

final partnersProvider =
    StateNotifierProvider<PartnersNotifier, AsyncValue<List<UserProfile>>>(
        (ref) {
  final repository = ref.watch(partnersRepositoryProvider);
  return PartnersNotifier(repository);
});