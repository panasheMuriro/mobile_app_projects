import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotificationService().showNotification(
              id: 0,
              title: 'Hello!',
              body: 'This is a push notification!',
            );
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}
