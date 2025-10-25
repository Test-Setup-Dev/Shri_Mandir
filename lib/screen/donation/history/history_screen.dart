import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/donation_history.dart';
import 'package:mandir/screen/donation/history/controller.dart';
import 'package:mandir/utils/helper.dart';

class DonationHistoryScreen extends StatelessWidget {
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationHistoryController());

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColors.primaryColor,
        title: Text(
          'Donation History',
          style: TextStyle(
            color: ThemeColors.white,
            fontSize: 5.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ThemeColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.donations.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: ThemeColors.primaryColor),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 20.w,
                  color: ThemeColors.greyColor,
                ),
                2.vs,
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor,
                    fontSize: 5.w,
                  ),
                ),
                3.vs,
                ElevatedButton(
                  onPressed: () => controller.fetchDonationHistory(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 1.5.h,
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(color: ThemeColors.white, fontSize: 5.w),
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.donations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 15.w, color: ThemeColors.greyColor),
                2.vs,
                Text(
                  'No donations yet',
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor,
                    fontSize: 5.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                1.vs,
                Text(
                  'Your donation history will appear here',
                  style: TextStyle(
                    color: ThemeColors.greyColor,
                    fontSize: 3.w,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshDonations,
          color: ThemeColors.primaryColor,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  itemCount: controller.donations.length,
                  itemBuilder: (context, index) {
                    final donation = controller.donations[index];
                    final isLastItem = index == controller.donations.length - 1;

                    return _DonationCard(
                      donation: donation,
                      controller: controller,
                      isLastItem: isLastItem,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _DonationCard extends StatelessWidget {
  final Donation donation;
  final DonationHistoryController controller;
  final bool isLastItem;

  const _DonationCard({
    Key? key,
    required this.donation,
    required this.controller,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastItem ? 0 : 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: ThemeColors.greyColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: ThemeColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Icon(
              Icons.volunteer_activism_rounded,
              color: ThemeColors.primaryColor,
              size: 5.w,
            ),
          ),
          3.w.hs,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thanks to Donate ${'appName'.t}',
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor,
                    fontSize: 3.w,
                  ),
                ),
                1.h.vs,
                Text(
                  controller.formatDate(donation.createdAt),
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor.withAlpha(100),
                    fontSize: 2.4.w,
                  ),
                ),
              ],
            ),
          ),
          Text(
            controller.formatAmount(donation.amount, donation.currency),
            style: TextStyle(
              color: ThemeColors.primaryColor,
              fontSize: 3.5.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
