abstract class TokenRepository {
  Future<String?> getAccessToken();
  Future<void> storeAccessToken(String token);
  Future<void> removeAccessToken();
}
