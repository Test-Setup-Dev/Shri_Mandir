import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/test.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';

class DonationController extends GetxController {
  final customAmountController = TextEditingController();

  final presetAmounts = [50, 100, 200, 500, 1000, 2000].obs;
  var selectedAmount = 0.obs;

  void selectAmount(int amount) {
    selectedAmount.value = amount;
    if (amount > 0) {
      customAmountController.clear();
    }
  }

  void processDonation(BuildContext context) {
    final amount =
        selectedAmount.value > 0
            ? selectedAmount.value
            : int.tryParse(customAmountController.text) ?? 0;

    if (amount <= 0) {
      Toasty.failed('Please select or enter a valid amount');
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.volunteer_activism,
                  color: ThemeColors.primaryColor,
                  size: 3.5.h,
                ),
                2.w.hs,
                Text(
                  'Confirm Donation',
                  style: TextStyle(
                    fontSize: 2.2.h,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are about to donate:',
                  style: TextStyle(
                    fontSize: 1.8.h,
                    color: ThemeColors.textPrimaryColor,
                  ),
                ),
                1.5.h.vs,
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: ThemeColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        color: ThemeColors.primaryColor,
                        size: 4.h,
                      ),
                      Text(
                        '$amount',
                        style: TextStyle(
                          fontSize: 4.h,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                1.5.h.vs,
                Text(
                  'Thank you for supporting our development!',
                  style: TextStyle(
                    fontSize: 1.6.h,
                    color: ThemeColors.textPrimaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor,
                    fontSize: 2.h,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final payController = RazorpayController();
                  final orderResponse = await payController.createOrder(
                    customAmountController.text.isNotEmpty
                        ? int.parse(customAmountController.text)
                        : selectedAmount.value,
                  );
                  if (orderResponse != null &&
                      orderResponse['status'] == true) {
                    payController.startPayment(
                      amount: orderResponse['amount'].toString(),
                      name: orderResponse['name'] ?? 'Shri Mandir',
                      description: 'Donation for Shri Mandir',
                      email:
                          orderResponse['email'] ?? Preference.user.email ?? '',
                      contact: Preference.user.phone ?? '',
                      orderId: orderResponse['order_id'],
                      razorpayKey: orderResponse['razorpay_key'],
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to create order'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  _initiateDonation(amount, context);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryColor,
                  foregroundColor: ThemeColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                child: Text('Proceed', style: TextStyle(fontSize: 2.h)),
              ),
            ],
          ),
    );
  }

  void _initiateDonation(int amount, BuildContext context) {
    // Here you would integrate your payment gateway
    // For now, showing success message

    Toasty.info('Integration with payment gateway will be added here');
    // Reset after donation
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
