import 'dart:convert';

/// Top-level model
class HomeResponse {
  final String status;
  final String message;
  final List<CategoryData> data;

  HomeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CategoryData.fromJson(e))
          .toList(),
    );
  }

  static HomeResponse fromRawJson(String str) =>
      HomeResponse.fromJson(json.decode(str));
}

/// Category model
class CategoryData {
  final int id;
  final String name;
  final String icon;
  final String description;
  final String createdAt;
  final String updatedAt;
  final List<MediaItem> mediaItems;

  CategoryData({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaItems,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      mediaItems: (json['media_items'] as List<dynamic>? ?? [])
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

  /// Optional reference to Category
  CategoryData? category;

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
      categoryId: categoryId?.toString() ?? json['categorie_id']?.toString() ?? '',
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      isFeatured: (json['isFeatured'] == 1),
    );
  }

  static MediaType _mediaTypeFromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'video':
        return MediaType.video;
      case 'audio':
        return MediaType.audio;
      default:
        return MediaType.audio;
    }
  }
}

enum MediaType { audio, video }


//
// class MediaItem {
//   final String id;
//   final String title;
//   final String artist;
//   final String thumbnailUrl;
//   final String mediaUrl;
//   final MediaType type;
//   final String duration;
//   final String category;
//   final double rating;
//   final bool isFeatured;
//
//   MediaItem({
//     required this.id,
//     required this.title,
//     required this.artist,
//     required this.thumbnailUrl,
//     required this.mediaUrl,
//     required this.type,
//     required this.duration,
//     required this.category,
//     required this.rating,
//     this.isFeatured = false,
//   });
//
//   factory MediaItem.fromJson(Map<String, dynamic> json) {
//     return MediaItem(
//       id: json['id'].toString(),
//       title: json['title'] ?? '',
//       artist: json['artist'] ?? '',
//       thumbnailUrl: json['thumbnailUrl'] ?? '',
//       mediaUrl: json['mediaUrl'] ?? '',
//       type: _mediaTypeFromString(json['type']),
//       duration: json['duration'] ?? '',
//       category: json['category'] ?? '',
//       rating: (json['rating'] ?? 0).toDouble(),
//       isFeatured: json['isFeatured'] ?? false,
//     );
//   }
//
//   /// Helper to safely map string to enum
//   static MediaType _mediaTypeFromString(String? type) {
//     switch (type?.toLowerCase()) {
//       case 'audio':
//         return MediaType.audio;
//       case 'video':
//         return MediaType.video;
//       default:
//         return MediaType.audio;
//     }
//   }
//
// }
//
// enum MediaType { audio, video }