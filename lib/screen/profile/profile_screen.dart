import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/profile/controller.dart';
import 'package:mandir/values/theme_colors.dart';
import 'package:mandir/values/size_config.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: SafeArea(
        child: Obx(() {
          final user = controller.user.value;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Curved Header with Profile Info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                  decoration: BoxDecoration(
                    color: ThemeColors.primaryColor.withAlpha(200),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4.w),
                      bottomLeft: Radius.circular(4.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeColors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 15.w,
                              backgroundImage: NetworkImage(user.avatarUrl),
                              backgroundColor: ThemeColors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: ThemeColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: ThemeColors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: ThemeColors.primaryColor,
                                size: 5.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      2.h.vs,
                      Text(
                        user.name,
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
                  offset: Offset(0, -5.h),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      border: Border.all(
                        color: ThemeColors.primaryColor.withAlpha(120),
                      ),
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.greyColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Bookings', '23', Icons.calendar_today),
                        _buildStatItem('Completed', '18', Icons.check_circle),
                        _buildStatItem('Points', '2.5K', Icons.star),
                      ],
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
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'My Bookings',
                        Icons.calendar_month,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Saved Services',
                        Icons.favorite,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Payment Methods',
                        Icons.payment,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Help & Support',
                        Icons.help_outline,
                        onTap: () {},
                      ),
                      _buildProfileAction(
                        'Logout',
                        Icons.logout,
                        isLast: true,
                        onTap: () {},
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
