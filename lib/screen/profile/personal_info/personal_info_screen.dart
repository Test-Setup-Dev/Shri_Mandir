import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/profile/controller.dart';
import 'package:mandir/utils/helper.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 4.5.w,
              fontWeight: FontWeight.bold,
              color: ThemeColors.primaryColor,
            ),
          ),
          Divider(height: 4.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 3.5.w,
                color: ThemeColors.greyColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Not provided',
              style: TextStyle(
                fontSize: 3.5.w,
                color: ThemeColors.defaultTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        final user = controller.user.value;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 30.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ThemeColors.primaryColor,
                            ThemeColors.primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(0.8.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeColors.white,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 12.w,
                              backgroundImage: NetworkImage(
                                user.image ?? 'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png',
                              ),
                            ),
                          ),
                          2.h.vs,
                          Text(
                            user.name ?? 'Unknown',
                            style: TextStyle(
                              color: ThemeColors.white,
                              fontSize: 5.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    _buildSection(
                      'Basic Information',
                      [
                        _buildInfoItem('Email', user.email),
                        _buildInfoItem('Phone', user.phone),
                        _buildInfoItem('Gender', user.gender),
                        _buildInfoItem('Date of Birth', user.dob),
                      ],
                    ),
                    _buildSection(
                      'Address Details',
                      [
                        _buildInfoItem('Address', user.address),
                        _buildInfoItem('City', user.city),
                        _buildInfoItem('State', user.state),
                        _buildInfoItem('Pin Code', user.pinCode),
                        _buildInfoItem('Country', user.country),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
