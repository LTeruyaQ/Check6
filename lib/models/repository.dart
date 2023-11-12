import 'package:github_api_demo/models/user.dart';

class Repository {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final bool isPrivate;
  final String htmlUrl;
  final String language;
  final int stars;
  final int forks;
  final User owner;

  Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.isPrivate,
    required this.htmlUrl,
    required this.language,
    required this.stars,
    required this.forks,
    required this.owner,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      description: json['description'] ?? '',
      isPrivate: json['private'] ?? false,
      htmlUrl: json['html_url'] ?? '',
      language: json['language'] ?? 'Desconhecido',
      stars: json['stargazers_count'] ?? 0,
      forks: json['forks_count'] ?? 0,
      owner: User.fromJson(json['owner'] ?? {}),
    );
  }
}
