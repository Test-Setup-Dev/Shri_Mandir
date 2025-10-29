import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/screen/donation/top_donor/top_donor_screen.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/logger.dart';

class TopDonorsController extends GetxController {
  final RxString status = Status.NORMAL.obs;

  var donors = <Donor>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchTopDonors();
  }

  Future<void> fetchTopDonors() async {
    status.value = Status.PROGRESS;
    try {
      final apiResponse = await Repository.instance.getTopDonor();

      if (apiResponse['status'] == true && apiResponse['data'] != null) {
        donors.value =
            (apiResponse['data'] as List)
                .map((donorJson) => Donor.fromJson(donorJson))
                .toList();
      }
    } catch (e) {
      Logger.e(tag: 'Fetch Top Donors ctrl', value: e);
    } finally {
      status.value = Status.COMPLETED;
    }
  }
}
