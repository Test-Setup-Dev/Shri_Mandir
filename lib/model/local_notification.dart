class LocalNotification {
  final int? id;
  final String title;
  final String body;
  final String data;
  final String timestamp;
  final bool read;

  LocalNotification({
    this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.timestamp,
    this.read = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'data': data,
      'timestamp': timestamp,
      'read': read ? 1 : 0,
    };
  }

  factory LocalNotification.fromMap(Map<String, dynamic> map) {
    return LocalNotification(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      data: map['data'],
      timestamp: map['timestamp'],
      read: map['read'] == 1,
    );
  }
}
