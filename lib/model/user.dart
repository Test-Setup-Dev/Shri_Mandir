class User {
  final String? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? phone;
  final String? image;
  final String? dob;
  final String? city;
  final String? address;
  final String? pinCode;
  final String? state;
  final String? country;
  final String? gender;
  final String? token;
  final String? fcmToken;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.image,
    this.dob,
    this.city,
    this.address,
    this.pinCode,
    this.state,
    this.country,
    this.gender,
    this.token,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      dob: json['date_of_birth'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      pinCode: json['pincode'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      token: json['token'] as String?,
      fcmToken: json['fcm_token'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'image': image,
      'date_of_birth': dob,
      'city': city,
      'address': address,
      'pincode': pinCode,
      'state': state,
      'country': country,
      'gender': gender,
      'token': token,
      'fcm_token': fcmToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
