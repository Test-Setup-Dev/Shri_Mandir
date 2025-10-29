/// Category model
class Category {
  final int id;
  final String name;
  final String icon;
  final String description;
  final String createdAt;
  final String updatedAt;
  final List<MediaItem> mediaItems;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaItems,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      mediaItems:
          (json['media_items'] as List<dynamic>? ?? [])
              .map((e) => MediaItem.fromJson(e, categoryId: json['id']))
              .toList(),
    );
  }
}

/// Media item model
class MediaItem {
  final String id;
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String mediaUrl;
  final MediaType type;
  final String duration;
  final String categoryId;
  final double averageRating;
  final bool isFeatured;
  final List<String>? content;

  Category? category;

  MediaItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.mediaUrl,
    required this.type,
    required this.duration,
    required this.categoryId,
    required this.averageRating,
    required this.isFeatured,
    this.content,
    this.category,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json, {int? categoryId}) {
    return MediaItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      type: _mediaTypeFromString(json['type']),
      duration: json['duration'] ?? '',
      categoryId:
          categoryId?.toString() ?? json['categorie_id']?.toString() ?? '',
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      isFeatured: (json['isFeatured'] == 1),
      content:
          json['content'] != null ? List<String>.from(json['content']) : null,
    );
  }

  static MediaType _mediaTypeFromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'video':
        return MediaType.video;
      case 'audio':
        return MediaType.audio;
      case 'text':
        return MediaType.text;
      default:
        return MediaType.audio;
    }
  }
}

enum MediaType { audio, video, text }

