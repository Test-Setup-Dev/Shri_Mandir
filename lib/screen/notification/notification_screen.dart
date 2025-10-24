// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mandir/model/notification.dart';
// import 'package:mandir/screen/notification/controller.dart';
// import 'package:mandir/utils/helper.dart';
// import 'package:mandir/values/theme_colors.dart';
// import 'package:mandir/values/size_config.dart';
//
// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({super.key});
//
//   final TextEditingController searchController = TextEditingController();
//   final RxString searchQuery = ''.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.initWithContext(context);
//     final controller = Get.put(NotificationController());
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: ThemeColors.backgroundColor,
//         body: SafeArea(
//           child: Column(
//             children: [
//               _buildHeader(controller),
//               2.h.vs,
//               Expanded(
//                 child: Obx(() {
//                   if (controller.isLoading.value) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: ThemeColors.primaryColor,
//                       ),
//                     );
//                   }
//                   final filteredNotifications = controller.notifications
//                       .where(
//                         (n) => n.title.toLowerCase().contains(
//                           searchQuery.value.toLowerCase(),
//                         ),
//                       )
//                       .toList();
//
//                   if (filteredNotifications.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.notifications_off,
//                             size: 15.w,
//                             color: ThemeColors.greyColor,
//                           ),
//                           2.h.vs,
//                           Text(
//                             'No notifications found',
//                             style: TextStyle(
//                               fontSize: 4.w,
//                               color: ThemeColors.greyColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return RefreshIndicator(
//                     onRefresh: () async => controller.refreshNotifications(),
//                     color: ThemeColors.primaryColor,
//                     child: ListView.builder(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 4.w,
//                         vertical: 2.h,
//                       ),
//                       itemCount: filteredNotifications.length,
//                       itemBuilder: (context, index) {
//                         final notification = filteredNotifications[index];
//                         return _buildNotificationCard(notification, controller);
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(NotificationController controller) {
//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [ThemeColors.white, ThemeColors.offWhite],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: ThemeColors.greyColor.withAlpha(50),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Notifications',
//                 style: TextStyle(
//                   fontSize: 5.w,
//                   fontWeight: FontWeight.bold,
//                   color: ThemeColors.black,
//                 ),
//               ),
//               Spacer(),
//               Obx(
//                 () => controller.unreadCount.value > 0
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.mark_email_read,
//                           color: ThemeColors.black,
//                           size: 6.w,
//                         ),
//                         onPressed: () {
//                           controller.markAllAsRead();
//                           Get.snackbar(
//                             'Success',
//                             'All notifications marked as read',
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: Colors.green,
//                             colorText: Colors.black,
//                           );
//                         },
//                       )
//                     : SizedBox(width: 0),
//               ),
//               IconButton(
//                 icon: Icon(Icons.refresh, color: ThemeColors.black, size: 6.w),
//                 onPressed: () => controller.refreshNotifications(),
//               ),
//             ],
//           ),
//           2.h.vs,
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 4.w),
//             decoration: BoxDecoration(
//               color: ThemeColors.white,
//               borderRadius: BorderRadius.circular(6.w),
//               border: Border.all(color: ThemeColors.greyColor),
//               boxShadow: [
//                 BoxShadow(
//                   color: ThemeColors.greyColor.withAlpha(50),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.search, color: ThemeColors.greyColor, size: 5.w),
//                 3.w.hs,
//                 Expanded(
//                   child: TextField(
//                     controller: searchController,
//                     style: TextStyle(
//                       color: ThemeColors.defaultTextColor,
//                       fontSize: 3.5.w,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: 'Search notifications...',
//                       hintStyle: TextStyle(
//                         color: ThemeColors.greyColor,
//                         fontSize: 3.5.w,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (value) => searchQuery.value = value,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNotificationCard(
//     NotificationModel notification,
//     NotificationController controller,
//   ) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 3.w),
//       decoration: BoxDecoration(
//         color: ThemeColors.white,
//         borderRadius: BorderRadius.circular(3.w),
//         border: Border.all(color: ThemeColors.greyColor.withAlpha(50)),
//         boxShadow: [
//           BoxShadow(
//             color: ThemeColors.greyColor.withAlpha(50),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(3.w),
//           onTap: () {
//             if (!notification.isRead) {
//               controller.markAsRead(notification.id);
//             }
//             _showNotificationDetails(notification);
//           },
//           child: Padding(
//             padding: EdgeInsets.all(4.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildNotificationIcon(notification.type),
//                 3.w.hs,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               notification.title,
//                               style: TextStyle(
//                                 fontSize: 3.5.w,
//                                 fontWeight: notification.isRead
//                                     ? FontWeight.w500
//                                     : FontWeight.bold,
//                                 color: notification.isRead
//                                     ? ThemeColors.defaultTextColor
//                                     : ThemeColors.primaryColor,
//                               ),
//                             ),
//                           ),
//                           if (!notification.isRead)
//                             Container(
//                               width: 2.w,
//                               height: 2.w,
//                               decoration: BoxDecoration(
//                                 color: ThemeColors.primaryColor,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                         ],
//                       ),
//                       1.h.vs,
//                       Text(
//                         notification.message,
//                         style: TextStyle(
//                           fontSize: 3.w,
//                           color: ThemeColors.greyColor,
//                           height: 1.3,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       1.h.vs,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             notification.time,
//                             style: TextStyle(
//                               fontSize: 2.5.w,
//                               color: ThemeColors.greyColor,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () =>
//                                 _showDeleteDialog(notification, controller),
//                             child: Icon(
//                               Icons.delete_outline,
//                               size: 4.w,
//                               color: ThemeColors.greyColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNotificationIcon(String type) {
//     IconData iconData;
//     Color backgroundColor;
//
//     switch (type) {
//       case 'message':
//         iconData = Icons.message;
//         backgroundColor = ThemeColors.blue;
//         break;
//       case 'system':
//         iconData = Icons.system_update;
//         backgroundColor = ThemeColors.accentColor;
//         break;
//       case 'payment':
//         iconData = Icons.payment;
//         backgroundColor = ThemeColors.primaryColor;
//         break;
//       case 'reminder':
//         iconData = Icons.alarm;
//         backgroundColor = ThemeColors.colorSecondary;
//         break;
//       case 'security':
//         iconData = Icons.security;
//         backgroundColor = Colors.red;
//         break;
//       case 'welcome':
//       default:
//         iconData = Icons.celebration;
//         backgroundColor = ThemeColors.primaryColor;
//         break;
//     }
//
//     return Container(
//       width: 8.w,
//       height: 8.w,
//       decoration: BoxDecoration(
//         color: backgroundColor.withOpacity(0.1),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(iconData, color: backgroundColor, size: 4.w),
//     );
//   }
//
//   void _showNotificationDetails(NotificationModel notification) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
//         title: Text(
//           notification.title,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.w),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               notification.message,
//               style: TextStyle(fontSize: 3.5.w, height: 1.4),
//             ),
//             2.h.vs,
//             Text(
//               'Received: ${notification.time}',
//               style: TextStyle(fontSize: 2.5.w, color: ThemeColors.greyColor),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Close', style: TextStyle(fontSize: 3.w)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteDialog(
//     NotificationModel notification,
//     NotificationController controller,
//   ) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
//         title: Text('Delete Notification', style: TextStyle(fontSize: 4.w)),
//         content: Text(
//           'Are you sure you want to delete this notification?',
//           style: TextStyle(fontSize: 3.5.w),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel', style: TextStyle(fontSize: 3.w)),
//           ),
//           TextButton(
//             onPressed: () {
//               controller.deleteNotification(notification.id);
//               Get.back();
//               Get.snackbar(
//                 'Deleted',
//                 'Notification deleted successfully',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.red,
//                 colorText: Colors.white,
//               );
//             },
//             child: Text(
//               'Delete',
//               style: TextStyle(color: Colors.red, fontSize: 3.w),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:mandir/model/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:mandir/screen/notification/controller.dart';
import 'package:mandir/utils/helper.dart';

class NotificationScreen extends StatelessWidget {
  final controller = Get.put(NotificationController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.offWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            1.h.vs,
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.primaryColor,
                  ),
                );
              }

              if (controller.notifications.isEmpty) {
                return Center(heightFactor: .5.h, child: _buildEmptyState());
              }

              return RefreshIndicator(
                color: ThemeColors.primaryColor,
                onRefresh: () async {
                  await controller.loadNotifications();
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notif = controller.notifications[index];
                    return _buildNotificationItem(context, notif, index);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ThemeColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 5.h,
              color: ThemeColors.primaryColor.withOpacity(0.6),
            ),
          ),
          3.h.vs,
          Text(
            "No notifications yet",
            style: TextStyle(
              fontSize: 1.8.h,
              fontWeight: FontWeight.w600,
              color: ThemeColors.defaultTextColor,
            ),
          ),
          1.h.vs,
          Text(
            "You're all caught up!",
            style: TextStyle(
              fontSize: 1.8.h,
              color: ThemeColors.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    LocalNotification notif,
    int index,
  ) {
    return Dismissible(
      key: Key(notif.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5.w),
        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Icon(Icons.delete_outline, color: ThemeColors.white, size: 6.h),
      ),
      onDismissed: (direction) async {
        await controller.deleteNotification(notif.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Notification deleted",
              style: TextStyle(fontSize: 1.8.h),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.5.w),
            ),
            action: SnackBarAction(
              label: "Undo",
              textColor: ThemeColors.primaryColor,
              onPressed: () {
                // Implement undo functionality if needed
              },
            ),
          ),
        );
      },
      child: Container(
        height: 12.h,
        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color:
              notif.read
                  ? ThemeColors.white
                  : ThemeColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color:
                notif.read
                    ? ThemeColors.greyColor.withOpacity(0.2)
                    : ThemeColors.primaryColor.withOpacity(0.3),
            width: 0.3.w,
          ),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: ThemeColors.transparentColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(4.w),
            splashColor: ThemeColors.primaryColor.withOpacity(0.1),
            onTap: () async {
              if (!notif.read) {
                await controller.markAsRead(notif.id!, true);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ThemeColors.primaryColor,
                          ThemeColors.accentColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: ThemeColors.white,
                      size: 1.8.h,
                    ),
                  ),
                  3.w.hs,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notif.title,
                                style: TextStyle(
                                  fontSize: 1.8.h,
                                  fontWeight:
                                      notif.read
                                          ? FontWeight.w500
                                          : FontWeight.w700,
                                  color: ThemeColors.defaultTextColor,
                                ),
                              ),
                            ),
                            if (!notif.read)
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
                        .5.h.vs,
                        Text(
                          notif.body,
                          style: TextStyle(
                            fontSize: 1.5.h,
                            color: ThemeColors.textPrimaryColor,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        .5.h.vs,
                        Text(
                          _formatTimestamp(notif.timestamp),
                          style: TextStyle(
                            fontSize: 1.5.h,
                            color: ThemeColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2.w.hs,
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: ThemeColors.textPrimaryColor,
                      size: 3.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    onSelected: (value) async {
                      if (value == 'delete') {
                        await controller.deleteNotification(notif.id!);
                      } else if (value == 'toggle') {
                        await controller.markAsRead(notif.id!, !notif.read);
                      }
                    },
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 'toggle',
                            child: Row(
                              children: [
                                Icon(
                                  notif.read
                                      ? Icons.mark_email_unread_outlined
                                      : Icons.mark_email_read_outlined,
                                  size: 1.8.h,
                                  color: ThemeColors.defaultTextColor,
                                ),
                                3.w.hs,
                                Text(
                                  notif.read
                                      ? 'Mark as Unread'
                                      : 'Mark as Read',
                                  style: TextStyle(fontSize: 1.8.h),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 1.8.h,
                                  color: Colors.red,
                                ),
                                3.w.hs,
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 1.8.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 1) {
        return 'Just now';
      } else if (diff.inHours < 1) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inDays < 1) {
        return '${diff.inHours}h ago';
      } else if (diff.inDays < 7) {
        return '${diff.inDays}d ago';
      } else {
        return timestamp;
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
            title: Text(
              'Clear All Notifications?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 2.5.h),
            ),
            content: Text(
              'This will permanently delete all notifications. This action cannot be undone.',
              style: TextStyle(fontSize: 1.8.h),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColors.textPrimaryColor,
                    fontSize: 1.8.h,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await controller.clearAll();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "All notifications cleared",
                        style: TextStyle(fontSize: 2.h),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.5.w),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: ThemeColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                child: Text('Clear All', style: TextStyle(fontSize: 1.8.h)),
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
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
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
                    'Notifications',
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Notifications List',
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
}
