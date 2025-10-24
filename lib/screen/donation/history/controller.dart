import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/donation_history.dart';

class DonationHistoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Donation> donations = <Donation>[].obs;
  final RxString totalAmount = '0'.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonationHistory();
  }

  Future<void> fetchDonationHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Replace this with your actual API call
      // Example: final response = await ApiService.getDonationHistory();



      final response = await Repository.instance.getDonations();

      final donationHistory = DonationHistory.fromJson(response);
      donations.value = donationHistory.donations;
      calculateTotalAmount();
    } catch (e) {
      errorMessage.value = 'Failed to fetch donation history';
      Get.snackbar(
        'Error',
        'Failed to load donation history',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void calculateTotalAmount() {
    double total = 0;
    for (var donation in donations) {
      total += double.tryParse(donation.amount) ?? 0;
    }
    totalAmount.value = total.toStringAsFixed(2);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  String formatAmount(String amount, String currency) {
    final parsedAmount = double.tryParse(amount) ?? 0;
    return '₹${parsedAmount.toStringAsFixed(2)}';
  }

  Future<void> refreshDonations() async {
    await fetchDonationHistory();
  }

  List<Donation> getDonationsByMonth(int month, int year) {
    return donations.where((donation) {
      return donation.createdAt.month == month &&
          donation.createdAt.year == year;
    }).toList();
  }

  Map<String, List<Donation>> groupDonationsByDate() {
    final Map<String, List<Donation>> grouped = {};

    for (var donation in donations) {
      final dateKey = DateFormat('dd MMM yyyy').format(donation.createdAt);
      if (grouped[dateKey] == null) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(donation);
    }

    return grouped;
  }
}