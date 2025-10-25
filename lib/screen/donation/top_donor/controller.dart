import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/screen/donation/top_donor/top_donor_screen.dart';

class TopDonorsController extends GetxController {
  var donors = <Donor>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchTopDonors();
  }

  Future<void> fetchTopDonors() async {
    // Simulating API response (replace with Dio call later)

    final apiResponse = await Repository.instance.getTopDonor();

    if (apiResponse['status'] == true && apiResponse['data'] != null) {
      donors.value =
          (apiResponse['data'] as List)
              .map((donorJson) => Donor.fromJson(donorJson))
              .toList();
    }
  }
}
