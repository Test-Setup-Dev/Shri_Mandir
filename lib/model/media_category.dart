class MediaCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  MediaCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory MediaCategory.fromJson(Map<String, dynamic> json) {
    return MediaCategory(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
    );
  }
}