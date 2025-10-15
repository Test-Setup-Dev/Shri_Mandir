import 'package:get/get.dart';
import 'package:mandir/model/user.dart';
import 'package:mandir/utils/preference.dart';


class ProfileController extends GetxController {
  final Rx<User> user = Preference.user.obs;
}