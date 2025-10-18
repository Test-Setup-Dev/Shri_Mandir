class Banners {
  final int? id;
  final String? title;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Banners({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
