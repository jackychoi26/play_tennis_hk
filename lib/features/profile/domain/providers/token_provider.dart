import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier(this.repository) : super(null) {
    getAccessToken();
  }

  TokenRepository repository;

  void getAccessToken() async {
    state = await repository.getAccessToken();
  }

  void setAccessToken(String token) async {
    await repository.setAccessToken(token);
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