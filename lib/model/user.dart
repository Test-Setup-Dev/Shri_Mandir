class User {
  String? id;
  String? name;
  String? collegeId;
  String? mode;
  String? createdBy;
  String? mobile;
  String? email;
  String? dob;
  String? gender;
  String? course;
  String? image;
  String? state;
  String? city;
  String? district;
  String? block;
  String? address;
  String? status;
  String? emailVerifiedAt;
  String? apiToken;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.collegeId,
    this.mode,
    this.createdBy,
    this.mobile,
    this.email,
    this.dob,
    this.gender,
    this.course,
    this.image,
    this.state,
    this.city,
    this.district,
    this.block,
    this.address,
    this.status,
    this.emailVerifiedAt,
    this.apiToken,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      collegeId: json['college_id']?.toString(),
      mode: json['mode']?.toString(),
      createdBy: json['created_by']?.toString(),
      mobile: json['mobile']?.toString(),
      email: json['email']?.toString(),
      dob: json['dob']?.toString(),
      gender: json['gender']?.toString(),
      course: json['course']?.toString(),
      image: json['image']?.toString(),
      state: json['state']?.toString(),
      city: json['city']?.toString(),
      block: json['block']?.toString(),
      district: json['district']?.toString(),
      address: json['address']?.toString(),
      status: json['status']?.toString(),
      emailVerifiedAt: json['email_verified_at']?.toString(),
      apiToken: json['api_token']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'college_id': collegeId,
    'mode': mode,
    'created_by': createdBy,
    'mobile': mobile,
    'email': email,
    'dob': dob,
    'gender': gender,
    'course': course,
    'image': image,
    'state': state,
    'city': city,
    'district': district,
    'block': block,
    'address': address,
    'status': status,
    'email_verified_at': emailVerifiedAt,
    'api_token': apiToken,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
