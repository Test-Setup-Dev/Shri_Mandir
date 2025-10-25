import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/dialogs/donation_dialog.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';

class DonationController extends GetxController {
  final customAmountController = TextEditingController();

  RxList<int> presetAmounts = [50, 100, 200, 500, 1000, 2000].obs;
  RxInt selectedAmount = 50.obs;

  void selectAmount(int amount) {
    Logger.m(tag: 'Selected Amount', value: amount.toString());
    selectedAmount.value = amount;
    if (amount > 0) {
      customAmountController.clear();
    }
  }

  void processDonation() {
    final amount =
        selectedAmount.value > 0
            ? selectedAmount.value
            : int.tryParse(customAmountController.text) ?? 0;

    if (amount <= 0) {
      Toasty.failed('Please select or enter a valid amount');
      return;
    }

    donationDialog(amount);
    _initiateDonation();
  }

  void _initiateDonation() {
    Future.delayed(const Duration(seconds: 2), () {
      selectedAmount.value = 0;
      customAmountController.clear();
    });
  }

  @override
  void onClose() {
    customAmountController.dispose();
    super.onClose();
  }
}
