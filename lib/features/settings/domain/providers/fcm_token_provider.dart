import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/settings/data/repositories/fcm_token_repository.dart';
import 'package:play_tennis_hk/features/settings/domain/repositories/fcm_token_repository.dart';

class FcmTokenNotifier extends StateNotifier<String?> {
  final FcmTokenRepository repository;

  FcmTokenNotifier(
    this.repository,
  ) : super(null);

  Future<bool> canGetFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token != null;
  }

  Future<void> saveTokenIfNeeded() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      repository.saveTokenIfNeeded(token);
    }
  }
}

final fcmTokenProvider =
    StateNotifierProvider<FcmTokenNotifier, String?>((ref) {
  return FcmTokenNotifier(FcmTokenRepositoryImpl());
});
