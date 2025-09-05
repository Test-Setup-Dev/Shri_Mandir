class SpecialEvent {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime date;
  final String location;
  final bool isFeatured;

  SpecialEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.location,
    this.isFeatured = false,
  });

  factory SpecialEvent.fromJson(Map<String, dynamic> json) {
    return SpecialEvent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      location: json['location'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}