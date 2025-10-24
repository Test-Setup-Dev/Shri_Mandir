import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/donation/controller.dart';
import 'package:mandir/screen/test.dart';
import 'package:mandir/utils/helper.dart';

class DonationScreen extends StatelessWidget {
  final controller = Get.put(DonationController());

  DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.offWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(),
                _buildDonationOptions(),
                _buildCustomAmount(),
                _buildBenefits(),
                _buildDonateButton(context),
                4.h.vs,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [ThemeColors.white, ThemeColors.offWhite],
        // ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(6.w),
                  border: Border.all(color: ThemeColors.greyColor),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyColor.withAlpha(50),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Helper.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: ThemeColors.primaryColor,
                    size: 6.w,
                  ),
                ),
              ),
              15.hs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'appName'.t,
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Divine Sounds & Videos Collection',
                    style: TextStyle(
                      color: ThemeColors.whiteBlue,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationOptions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Text(
              'Choose an Amount',
              style: TextStyle(
                fontSize: 2.2.h,
                fontWeight: FontWeight.w600,
                color: ThemeColors.defaultTextColor,
              ),
            ),
          ),
          1.h.vs,
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 1.3,
              ),
              itemCount: controller.presetAmounts.length,
              itemBuilder: (context, index) {
                final amount = controller.presetAmounts[index];
                return Obx(() {
                  final isSelected = controller.selectedAmount.value == amount;
                  return GestureDetector(
                    onTap: () => controller.selectAmount(amount),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? ThemeColors.primaryColor
                                : ThemeColors.white,
                        borderRadius: BorderRadius.circular(4.w),
                        border: Border.all(
                          color:
                              isSelected
                                  ? ThemeColors.primaryColor
                                  : ThemeColors.greyColor.withOpacity(0.3),
                          width: isSelected ? 0.5.w : 0.3.w,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: ThemeColors.primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹$amount',
                            style: TextStyle(
                              fontSize: 2.5.h,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? ThemeColors.white
                                      : ThemeColors.defaultTextColor,
                            ),
                          ),
                          0.3.h.vs,
                          Text(
                            _getAmountLabel(amount),
                            style: TextStyle(
                              fontSize: 1.4.h,
                              color:
                                  isSelected
                                      ? ThemeColors.white.withOpacity(0.9)
                                      : ThemeColors.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getAmountLabel(int amount) {
    switch (amount) {
      case 50:
        return 'Coffee';
      case 100:
        return 'Supporter';
      case 200:
        return 'Believer';
      case 500:
        return 'Champion';
      case 1000:
        return 'Hero';
      case 2000:
        return 'Legend';
      default:
        return 'Custom';
    }
  }

  Widget _buildCustomAmount() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Or Enter Custom Amount',
            style: TextStyle(
              fontSize: 2.h,
              fontWeight: FontWeight.w600,
              color: ThemeColors.defaultTextColor,
            ),
          ),
          1.5.h.vs,
          TextField(
            controller: controller.customAmountController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 2.2.h,
              fontWeight: FontWeight.w600,
              color: ThemeColors.defaultTextColor,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.currency_rupee,
                color: ThemeColors.primaryColor,
                size: 3.h,
              ),
              hintText: 'Enter amount',
              hintStyle: TextStyle(
                fontSize: 2.h,
                color: ThemeColors.textPrimaryColor,
              ),
              filled: true,
              fillColor: ThemeColors.offWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.w),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.w),
                borderSide: BorderSide(
                  color: ThemeColors.greyColor.withOpacity(0.2),
                  width: 0.3.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.w),
                borderSide: BorderSide(
                  color: ThemeColors.primaryColor,
                  width: 0.5.w,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.selectAmount(-1);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBenefits() {
    final benefits = [
      {
        'icon': Icons.rocket_launch,
        'title': 'New Features',
        'desc': 'Help us develop exciting new features',
      },
      {
        'icon': Icons.speed,
        'title': 'Better Performance',
        'desc': 'Improve app speed and reliability',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Priority Support',
        'desc': 'Get faster response to your queries',
      },
      {
        'icon': Icons.security,
        'title': 'Enhanced Security',
        'desc': 'Keep your data safe and secure',
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Text(
              'Your Support Helps Us',
              style: TextStyle(
                fontSize: 2.2.h,
                fontWeight: FontWeight.w600,
                color: ThemeColors.defaultTextColor,
              ),
            ),
          ),
          1.h.vs,
          ...benefits.map(
            (benefit) => _buildBenefitCard(
              benefit['icon'] as IconData,
              benefit['title'] as String,
              benefit['desc'] as String,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(IconData icon, String title, String desc) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ThemeColors.primaryColor.withOpacity(0.2),
                  ThemeColors.accentColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Icon(icon, size: 3.h, color: ThemeColors.primaryColor),
          ),
          3.w.hs,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 2.h,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.defaultTextColor,
                  ),
                ),
                0.5.h.vs,
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 1.5.h,
                    color: ThemeColors.textPrimaryColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonateButton(BuildContext context) {
    return Obx(() {
      final isEnabled =
          controller.selectedAmount.value > 0 ||
          controller.customAmountController.text.isNotEmpty;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        width: double.infinity,
        height: 6.h,
        child: ElevatedButton(
          onPressed: isEnabled ? () => controller.processDonation() : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.primaryColor,
            foregroundColor: ThemeColors.white,
            disabledBackgroundColor: ThemeColors.greyColor.withOpacity(0.3),
            elevation: isEnabled ? 8 : 0,
            shadowColor: ThemeColors.primaryColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 2.5.h),
              2.w.hs,
              Text(
                'Donate Now',
                style: TextStyle(fontSize: 2.2.h, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });
  }
}
