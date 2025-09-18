// class User {
//   String? id;
//   String? name;
//   String? collegeId;
//   String? mode;
//   String? createdBy;
//   String? mobile;
//   String? email;
//   String? dob;
//   String? gender;
//   String? course;
//   String? image;
//   String? state;
//   String? city;
//   String? district;
//   String? block;
//   String? address;
//   String? status;
//   String? emailVerifiedAt;
//   String? apiToken;
//   String? createdAt;
//   String? updatedAt;
//
//   User({
//     this.id,
//     this.name,
//     this.collegeId,
//     this.mode,
//     this.createdBy,
//     this.mobile,
//     this.email,
//     this.dob,
//     this.gender,
//     this.course,
//     this.image,
//     this.state,
//     this.city,
//     this.district,
//     this.block,
//     this.address,
//     this.status,
//     this.emailVerifiedAt,
//     this.apiToken,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id']?.toString(),
//       name: json['name']?.toString(),
//       collegeId: json['college_id']?.toString(),
//       mode: json['mode']?.toString(),
//       createdBy: json['created_by']?.toString(),
//       mobile: json['mobile']?.toString(),
//       email: json['email']?.toString(),
//       dob: json['dob']?.toString(),
//       gender: json['gender']?.toString(),
//       course: json['course']?.toString(),
//       image: json['image']?.toString(),
//       state: json['state']?.toString(),
//       city: json['city']?.toString(),
//       block: json['block']?.toString(),
//       district: json['district']?.toString(),
//       address: json['address']?.toString(),
//       status: json['status']?.toString(),
//       emailVerifiedAt: json['email_verified_at']?.toString(),
//       apiToken: json['api_token']?.toString(),
//       createdAt: json['created_at']?.toString(),
//       updatedAt: json['updated_at']?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'college_id': collegeId,
//     'mode': mode,
//     'created_by': createdBy,
//     'mobile': mobile,
//     'email': email,
//     'dob': dob,
//     'gender': gender,
//     'course': course,
//     'image': image,
//     'state': state,
//     'city': city,
//     'district': district,
//     'block': block,
//     'address': address,
//     'status': status,
//     'email_verified_at': emailVerifiedAt,
//     'api_token': apiToken,
//     'created_at': createdAt,
//     'updated_at': updatedAt,
//   };
// }



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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
