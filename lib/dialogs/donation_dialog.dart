import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/payment/payment_handler.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';

void donationDialog(amount) {
  if (amount <= 0) {
    Toasty.failed('Please select or enter a valid amount');
    return;
  }

  Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: ThemeColors.white,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              2.h.vs,
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
              2.h.vs,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: ThemeColors.textPrimaryColor,
                        fontSize: 2.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  ElevatedButton(
                    onPressed: () async {
                      final orderResponse = await RazorpayController()
                          .createOrder(amount);
                      if (orderResponse != null &&
                          orderResponse['status'] == true) {
                        Get.back();
                        RazorpayController().startPayment(
                          amount: orderResponse['amount'].toString(),
                          name: orderResponse['name'] ?? 'appName'.t,
                          description: 'Donation for Shri Mandir',
                          email:
                              orderResponse['email'] ??
                              Preference.user.email ??
                              '',
                          contact: Preference.user.phone ?? '',
                          orderId: orderResponse['order_id'],
                          razorpayKey: orderResponse['razorpay_key'],
                        );
                      } else {
                        Toasty.failed('Failed to create order');
                      }
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
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
