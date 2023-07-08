abstract class TokenRepository {
  Future<String?> getAccessToken();
  Future<void> setAccessToken(String token);
}
