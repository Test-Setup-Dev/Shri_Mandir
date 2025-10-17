import 'package:get/get.dart';
import 'package:mandir/model/local_notification.dart';
import 'package:mandir/utils/db/db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen2 extends StatelessWidget {
  final controller = Get.put(NotificationController());

  NotificationScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () async {
              await controller.clearAll();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No notifications yet"));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];
            return _buildNotificationItem(notif);
          },
        );
      }),
    );
  }

  Widget _buildNotificationItem(LocalNotification notif) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          notif.title,
          style: TextStyle(
            fontWeight: notif.read ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notif.body),
            const SizedBox(height: 4),
            Text(
              notif.timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
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
                  child: Text(notif.read ? 'Mark as Unread' : 'Mark as Read'),
                ),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
        ),
      ),
    );
  }
}

class NotificationController extends GetxController {
  var notifications = <LocalNotification>[].obs;
  final _db = NotificationDbHelper();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final data = await _db.getAllNotifications();
    notifications.assignAll(data);
  }

  Future<void> markAsRead(int id, bool read) async {
    await _db.markAsRead(id, read);
    await loadNotifications();
  }

  Future<void> deleteNotification(int id) async {
    await _db.deleteNotification(id);
    await loadNotifications();
  }

  Future<void> clearAll() async {
    await _db.clearNotifications();
    notifications.clear();
  }
}
