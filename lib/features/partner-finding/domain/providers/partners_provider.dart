import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/partner-finding/data/repositories/partner_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

final partnersRepositoryProvider = Provider((ref) => PartnersRepositoryImpl());

final partnersProvider = FutureProvider<List<UserProfile>>((ref) async {
  final repository = ref.read(partnersRepositoryProvider);
  return await repository.getPublicProfiles();
});
