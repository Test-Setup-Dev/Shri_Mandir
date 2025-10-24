import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/api_keys.dart';
import 'package:mandir/screen/donation/donation_screen.dart';
import 'package:mandir/screen/profile/controller.dart';
import 'package:mandir/utils/helper.dart';

import 'personal_info/personal_info_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ThemeColors.primaryColor.withAlpha(50),
      ),
      body: SafeArea(
        child: Obx(() {
          final user = controller.user.value;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Curved Header with Profile Info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  decoration: BoxDecoration(
                    color: ThemeColors.primaryColor.withAlpha(200),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(3.w),
                      bottomLeft: Radius.circular(3.w),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        // user.image ?? "",
                        'https://images.unsplash.com/photo-1623952146070-f13fc902f769',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        ThemeColors.colorSecondary.withAlpha(100),
                        BlendMode.srcOver,
                      ),
                      // opacity: 0.6,
                    ),
                  ),
                  child: Column(
                    children: [
                      5.h.vs,
                      Text(
                        user.name ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 6.w,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.white,
                        ),
                      ),
                      1.h.vs,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.w,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Text(
                          'Premium Member',
                          style: TextStyle(
                            color: ThemeColors.white,
                            fontSize: 3.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Stats Section
                Transform.translate(
                  offset: Offset(0, -6.h),
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      border: Border.all(
                        color: ThemeColors.primaryColor.withAlpha(120),
                      ),
                      borderRadius: BorderRadius.circular(50.w),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.greyColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 15.w,
                      backgroundImage: NetworkImage(
                        user.image ??
                            'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png',
                      ),
                      backgroundColor: ThemeColors.white,
                    ),
                  ),
                ),
                // Profile Actions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      _buildProfileAction(
                        'Personal Information',
                        Icons.person,
                        onTap: () => Get.to(() => PersonalInfoScreen()),
                      ),
                      _buildProfileAction(
                        'Donation History',
                        Icons.payments_outlined,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Donate Now',
                        Icons.clean_hands_outlined,
                        onTap: ()=> Get.to(()=> DonationScreen()),
                      ),
                      _buildProfileAction(
                        'Favorite',
                        Icons.favorite,
                        onTap: () {},
                      ),

                      _buildProfileAction(
                        'Help & Support',
                        Icons.help_outline,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Privacy Policy',
                        Icons.lock_outline,
                        onTap:
                            () =>
                                Helper.openUrl('${BaseUrl.baseUrl}privacy-policy-page'),
                      ),
                      _buildProfileAction(
                        'Terms & Conditions',
                        Icons.info_outline,
                        onTap:
                            () =>
                                Helper.openUrl('${BaseUrl.baseUrl}conditions'),
                      ),
                      _buildProfileAction(
                        'About Us',
                        Icons.people_rounded,
                        onTap:
                            () =>
                                Helper.openUrl('${BaseUrl.baseUrl}about-us-page'),
                      ),
                      _buildProfileAction(
                        'Logout',
                        Icons.logout,
                        isLast: true,
                        onTap: () => Helper.logOut(),
                      ),
                    ],
                  ),
                ),
                4.h.vs,
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ThemeColors.primaryColor, size: 6.w),
        ),
        1.h.vs,
        Text(
          value,
          style: TextStyle(
            fontSize: 4.5.w,
            fontWeight: FontWeight.bold,
            color: ThemeColors.defaultTextColor,
          ),
        ),
        0.5.h.vs,
        Text(
          label,
          style: TextStyle(fontSize: 3.w, color: ThemeColors.greyColor),
        ),
      ],
    );
  }

  Widget _buildProfileAction(
    String title,
    IconData icon, {
    bool isLast = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 2.h),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Icon(icon, color: ThemeColors.primaryColor, size: 5.w),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 3.5.w,
            fontWeight: FontWeight.w500,
            color: ThemeColors.defaultTextColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ThemeColors.greyColor,
          size: 4.w,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
      ),
    );
  }
}
