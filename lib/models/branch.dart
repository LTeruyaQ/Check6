class Branch {
  final String name;
  final String sha;

  Branch({
    required this.name,
    required this.sha,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'] ?? '',
      sha: json['commit']['sha'] ?? '',
    );
  }
}
