class Owner {
  final String login;
  final int id;
  final String avatarUrl;

  Owner({
    required this.login,
    required this.id,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
    );
  }
}
