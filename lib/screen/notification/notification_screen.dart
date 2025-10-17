import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/notification.dart';
import 'package:mandir/screen/notification/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/values/theme_colors.dart';
import 'package:mandir/values/size_config.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);
    final controller = Get.put(NotificationController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(controller),
              2.h.vs,
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ThemeColors.primaryColor,
                      ),
                    );
                  }
                  final filteredNotifications = controller.notifications
                      .where(
                        (n) => n.title.toLowerCase().contains(
                          searchQuery.value.toLowerCase(),
                        ),
                      )
                      .toList();

                  if (filteredNotifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off,
                            size: 15.w,
                            color: ThemeColors.greyColor,
                          ),
                          2.h.vs,
                          Text(
                            'No notifications found',
                            style: TextStyle(
                              fontSize: 4.w,
                              color: ThemeColors.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async => controller.refreshNotifications(),
                    color: ThemeColors.primaryColor,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];
                        return _buildNotificationCard(notification, controller);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(NotificationController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ThemeColors.white, ThemeColors.offWhite],
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 5.w,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.black,
                ),
              ),
              Spacer(),
              Obx(
                () => controller.unreadCount.value > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.mark_email_read,
                          color: ThemeColors.black,
                          size: 6.w,
                        ),
                        onPressed: () {
                          controller.markAllAsRead();
                          Get.snackbar(
                            'Success',
                            'All notifications marked as read',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.black,
                          );
                        },
                      )
                    : SizedBox(width: 0),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: ThemeColors.black, size: 6.w),
                onPressed: () => controller.refreshNotifications(),
              ),
            ],
          ),
          2.h.vs,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
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
            child: Row(
              children: [
                Icon(Icons.search, color: ThemeColors.greyColor, size: 5.w),
                3.w.hs,
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(
                      color: ThemeColors.defaultTextColor,
                      fontSize: 3.5.w,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search notifications...',
                      hintStyle: TextStyle(
                        color: ThemeColors.greyColor,
                        fontSize: 3.5.w,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => searchQuery.value = value,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    NotificationModel notification,
    NotificationController controller,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: ThemeColors.greyColor.withAlpha(50)),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(3.w),
          onTap: () {
            if (!notification.isRead) {
              controller.markAsRead(notification.id);
            }
            _showNotificationDetails(notification);
          },
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(notification.type),
                3.w.hs,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 3.5.w,
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                color: notification.isRead
                                    ? ThemeColors.defaultTextColor
                                    : ThemeColors.primaryColor,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 2.w,
                              height: 2.w,
                              decoration: BoxDecoration(
                                color: ThemeColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      1.h.vs,
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 3.w,
                          color: ThemeColors.greyColor,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      1.h.vs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification.time,
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: ThemeColors.greyColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                _showDeleteDialog(notification, controller),
                            child: Icon(
                              Icons.delete_outline,
                              size: 4.w,
                              color: ThemeColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData iconData;
    Color backgroundColor;

    switch (type) {
      case 'message':
        iconData = Icons.message;
        backgroundColor = ThemeColors.blue;
        break;
      case 'system':
        iconData = Icons.system_update;
        backgroundColor = ThemeColors.accentColor;
        break;
      case 'payment':
        iconData = Icons.payment;
        backgroundColor = ThemeColors.primaryColor;
        break;
      case 'reminder':
        iconData = Icons.alarm;
        backgroundColor = ThemeColors.colorSecondary;
        break;
      case 'security':
        iconData = Icons.security;
        backgroundColor = Colors.red;
        break;
      case 'welcome':
      default:
        iconData = Icons.celebration;
        backgroundColor = ThemeColors.primaryColor;
        break;
    }

    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: backgroundColor, size: 4.w),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        title: Text(
          notification.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.w),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(fontSize: 3.5.w, height: 1.4),
            ),
            2.h.vs,
            Text(
              'Received: ${notification.time}',
              style: TextStyle(fontSize: 2.5.w, color: ThemeColors.greyColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close', style: TextStyle(fontSize: 3.w)),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    NotificationModel notification,
    NotificationController controller,
  ) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        title: Text('Delete Notification', style: TextStyle(fontSize: 4.w)),
        content: Text(
          'Are you sure you want to delete this notification?',
          style: TextStyle(fontSize: 3.5.w),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(fontSize: 3.w)),
          ),
          TextButton(
            onPressed: () {
              controller.deleteNotification(notification.id);
              Get.back();
              Get.snackbar(
                'Deleted',
                'Notification deleted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontSize: 3.w),
            ),
          ),
        ],
      ),
    );
  }
}
