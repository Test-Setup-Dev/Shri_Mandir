class Banner {
  final int? id;
  final String? name;
  final String? topic;
  final String? createdAt;
  final String? updatedAt;
  final String? image;

  Banner({
    this.id,
    this.name,
    this.topic,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'] as int?,
      name: json['name'] as String?,
      topic: json['topic'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image,
    };
  }
}

/// Helper function to parse list
List<Banner> categoryListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => Banner.fromJson(json)).toList();
}

// final List<dynamic> response = jsonDecode(apiResponseBody);
// final categories = categoryListFromJson(response);
//
// print(categories.first.name); // dashbord
// print(categories.first.image); // http://192.168.1.7:8000/images/1758047503_68c9ad0f54f42.jpeg

