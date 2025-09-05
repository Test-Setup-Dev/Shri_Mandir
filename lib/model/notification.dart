class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type;
  final bool isRead;
  final String? imageUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
    this.imageUrl,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? time,
    String? type,
    bool? isRead,
    String? imageUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

