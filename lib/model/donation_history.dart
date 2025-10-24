class DonationHistory {
  final bool status;
  final String message;
  final List<Donation> donations;

  DonationHistory({
    required this.status,
    required this.message,
    required this.donations,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      donations: (json['donations'] as List<dynamic>?)
          ?.map((e) => Donation.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'donations': donations.map((e) => e.toJson()).toList(),
  };
}

class Donation {
  final int id;
  final int userId;
  final String amount;
  final String currency;
  final DateTime createdAt;

  Donation({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.createdAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      amount: json['amount'] ?? '',
      currency: json['currency'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'amount': amount,
    'currency': currency,
    'created_at': createdAt.toIso8601String(),
  };
}
