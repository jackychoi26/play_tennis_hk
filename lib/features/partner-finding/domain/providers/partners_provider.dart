import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/features/partner-finding/data/repositories/partner_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

final partnersRepositoryProvider = Provider((ref) => PartnersRepositoryImpl());

class PartnersNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  PartnersNotifier(this.repository) : super(const AsyncLoading()) {
    getPublicProfiles(offset: 0);
  }

  PartnersRepositoryImpl repository;

  Future<void> clearPartners() async {
    state = const AsyncData([]);
    state = const AsyncLoading();
  }

  Future<void> getPublicProfiles({required int offset}) async {
    try {
      final partners = await repository.getPublicProfiles(offset);

      final currentProfiles = state.maybeWhen(
        data: (profiles) => profiles,
        orElse: () => [],
      );

      state = AsyncData([...currentProfiles, ...partners]);
    } catch (err) {
      if (ErrorResolver().notTimeoutException(err)) rethrow;

      state = AsyncError(err, StackTrace.current);
    }
  }
}

final partnersProvider =
    StateNotifierProvider<PartnersNotifier, AsyncValue<List<UserProfile>>>(
        (ref) {
  final repository = ref.watch(partnersRepositoryProvider);
  return PartnersNotifier(repository);
});
