class PujaService {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double rating;
  final String duration;
  final bool isSpecial;
  final String category;

  PujaService({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.duration,
    this.isSpecial = false,
    required this.category,
  });

  factory PujaService.fromJson(Map<String, dynamic> json) {
    return PujaService(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? '',
      isSpecial: json['isSpecial'] ?? false,
      category: json['category'] ?? '',
    );
  }
}