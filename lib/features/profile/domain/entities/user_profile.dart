class UserProfile {
  final String username;
  final String email;
  final String imageUrl;
  final double ustaLevel;
  final String? telegram;
  final String? singal;
  final String? description;

  const UserProfile(
    this.telegram,
    this.singal,
    this.description, {
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.ustaLevel,
  });
}
