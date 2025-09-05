class ServiceCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
    );
  }
}