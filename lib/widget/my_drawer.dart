import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/screen/shop/controller.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/widget/widgets.dart';
import '../utils/helper.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Drawer(
        backgroundColor: ThemeColors.whiteBlue,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            _navHeader(),
            _navItem('assets/icons/home_outline.png', 'Home', () {
              Get.back();
            }, selected: true),

            _navItem('assets/icons/user_bold.png', 'Profile', () {
              Get.back();
              // Get.to(() => ProfileScreen());
            }),

            _navItem(
              'assets/icons/notification_outline.png',
              'Notification',
              () {
                Get.back();
                //   Get.to(() => NotificationScreen());
              },
            ),
            _navItem('assets/icons/lock.png', 'Change Password', () {
              Get.back();
              //   Get.to(() => ChangePassword());
            }),
            _navItem('assets/icons/logout_outline.png', 'Log Out', () {
              Get.back();
              Helper.logOut();
            }),

            //TODO: Comment 'Logs' & 'Tester Login' before app store submission
            if (Helper.isTester) ...[
              _navItem('assets/icons/hacker.png', 'TEST BUTTON', () {
                Get.back();
                final controller = Get.put(HomeController());
                controller.testFunction();
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _navHeader() {
    return InkWell(
      onTap: () {
        Get.back();
        //// Get.to(() => EditUserProfilePage());
      },
      child: Container(
        decoration: const BoxDecoration(color: ThemeColors.white),
        padding: const EdgeInsets.only(left: 15, top: 60, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'appName'.t,
              style: const MyTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            // 8.vs,
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 12,
            //       height: 12,
            //       decoration: const BoxDecoration(
            //         color: Colors.green,
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //     6.hs,
            //     Obx(
            //       () => Text(
            //         Const.name.value.nullSafe,
            //         style: MyTextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //     Text(
            //       Preference.user.name.nullSafe,
            //       style: const MyTextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            8.vs,
            // Obx(
            //   () => Text(
            //     "     ${Const.email.value.nullSafe}",
            //     style: MyTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            //   ),
            // ),
            Text(
              "  ${Preference.user.email.placeholder("+91${Preference.user.phone ?? '1234567890'}")}",
              style: const MyTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    String icon,
    String title,
    void Function() onTap, {
    bool selected = false,
    String suffix = '',
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      child: Row(
        children: [
          assetImage(
            icon,
            color: /*selected ? Colors.black : Colors.grey.shade800*/
                ThemeColors.primaryColor,
            width: 20,
            height: 20,
          ),
          15.hs,
          Expanded(
            child: Text(
              title,
              style: MyTextStyle(
                fontSize: 16,
                color: selected ? Colors.black : Colors.grey.shade800,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
          if (suffix.notEmpty)
            Text(
              suffix,
              style: MyTextStyle(
                color: selected ? Colors.black : Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
