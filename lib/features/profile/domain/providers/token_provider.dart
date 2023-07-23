import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier(this.repository) : super(null) {
    getAccessToken();
  }

  TokenRepository repository;

  Future<void> getAccessToken() async {
    final token = await repository.getAccessToken();
    state = token;
  }

  void storeAccessToken(String token) async {
    await repository.storeAccessToken(token);
    state = token;
  }

  void removeAccessToken() async {
    await repository.removeAccessToken();
    state = null;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  return TokenNotifier(TokenRepositoryImpl());
});
