class RegisterParam {
  final String username;
  final String email;
  final String imageUrl;
  final String password;
  final double ustaLevel;
  final String? telegram;
  final String? whatsapp;
  final String? signal;
  final String? description;

  RegisterParam(
    this.telegram,
    this.whatsapp,
    this.signal,
    this.description, {
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.password,
    required this.ustaLevel,
  });
}
