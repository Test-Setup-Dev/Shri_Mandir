
class MediaItem {
  final String id;
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String mediaUrl;
  final MediaType type;
  final String duration;
  final String category;
  final double rating;
  final bool isFeatured;

  MediaItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.mediaUrl,
    required this.type,
    required this.duration,
    required this.category,
    required this.rating,
    this.isFeatured = false,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      type: _mediaTypeFromString(json['type']),
      duration: json['duration'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  /// Helper to safely map string to enum
  static MediaType _mediaTypeFromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'audio':
        return MediaType.audio;
      case 'video':
        return MediaType.video;
      default:
        return MediaType.audio;
    }
  }

}

enum MediaType { audio, video }