import 'package:get/get.dart';

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.address,
  });
}


class ProfileController extends GetxController {
  final Rx<ProfileModel> user = ProfileModel(
    id: '1',
    name: 'Ajay Rawat',
    email: 'ajay@example.com',
    phone: '+91 9876543210',
    avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    address: '123, Mandir Street, Delhi, India',
  ).obs;
}