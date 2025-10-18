// import 'package:get/get.dart';
// import 'package:mandir/model/notification.dart';
//
// class NotificationController extends GetxController {
//   final RxList notifications = <NotificationModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxInt unreadCount = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadNotifications();
//   }
//
//   void loadNotifications() {
//     isLoading.value = true;
//
//     // Simulate API call delay
//     Future.delayed(const Duration(seconds: 1), () {
//       notifications.value = _getDummyNotifications();
//       _updateUnreadCount();
//       isLoading.value = false;
//     });
//   }
//
//   List<NotificationModel> _getDummyNotifications() {
//     return [
//       NotificationModel(
//         id: '1',
//         title: 'Welcome to the App!',
//         message: 'Thank you for downloading our app. Explore all the amazing features we have to offer.',
//         time: '2 minutes ago',
//         type: 'welcome',
//         isRead: false,
//       ),
//       NotificationModel(
//         id: '2',
//         title: 'New Message Received',
//         message: 'You have received a new message from John Doe. Tap to read more.',
//         time: '1 hour ago',
//         type: 'message',
//         isRead: false,
//       ),
//       NotificationModel(
//         id: '3',
//         title: 'System Update Available',
//         message: 'A new system update is available. Update now to get the latest features and bug fixes.',
//         time: '3 hours ago',
//         type: 'system',
//         isRead: true,
//       ),
//       NotificationModel(
//         id: '4',
//         title: 'Payment Successful',
//         message: 'Your payment of \$29.99 has been processed successfully. Receipt has been sent to your email.',
//         time: '1 day ago',
//         type: 'payment',
//         isRead: true,
//       ),
//       NotificationModel(
//         id: '5',
//         title: 'Daily Reminder',
//         message: 'Don\'t forget to complete your daily tasks. You have 3 pending items.',
//         time: '2 days ago',
//         type: 'reminder',
//         isRead: false,
//       ),
//       NotificationModel(
//         id: '6',
//         title: 'Security Alert',
//         message: 'We detected a login attempt from a new device. If this wasn\'t you, please secure your account.',
//         time: '3 days ago',
//         type: 'security',
//         isRead: true,
//       ),
//     ];
//   }
//
//   void markAsRead(String notificationId) {
//     int index = notifications.indexWhere((n) => n.id == notificationId);
//     if (index != -1) {
//       notifications[index] = notifications[index].copyWith(isRead: true);
//       _updateUnreadCount();
//     }
//   }
//
//   void markAllAsRead() {
//     for (int i = 0; i < notifications.length; i++) {
//       notifications[i] = notifications[i].copyWith(isRead: true);
//     }
//     _updateUnreadCount();
//   }
//
//   void deleteNotification(String notificationId) {
//     notifications.removeWhere((n) => n.id == notificationId);
//     _updateUnreadCount();
//   }
//
//   void _updateUnreadCount() {
//     unreadCount.value = notifications.where((n) => !n.isRead).length;
//   }
//
//   void refreshNotifications() {
//     loadNotifications();
//   }
//
// }


import 'package:get/get.dart';
import 'package:mandir/model/local_notification.dart';
import 'package:mandir/utils/db/db.dart';
import 'package:flutter/material.dart';
class NotificationController extends GetxController {
  var notifications = <LocalNotification>[].obs;
  var isLoading = false.obs;
  final _db = NotificationDbHelper();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      final data = await _db.getAllNotifications();
      notifications.assignAll(data);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load notifications',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(int id, bool read) async {
    try {
      await _db.markAsRead(id, read);
      await loadNotifications();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update notification',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  Future<void> deleteNotification(int id) async {
    try {
      await _db.deleteNotification(id);
      await loadNotifications();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete notification',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  Future<void> clearAll() async {
    try {
      await _db.clearNotifications();
      notifications.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear notifications',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }
}
