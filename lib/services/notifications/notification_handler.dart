import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:way_to_doctor_doctor/services/notifications/cloud_messaging_service.dart';
import 'package:way_to_doctor_doctor/services/notifications/local_notifications_service.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../api/notifications/device_token_services.dart';

class NotificationHandler {
  static Future<void> initializeFCM() async {
    final messaging = FirebaseMessaging.instance;

    // Request permission
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ✅ Now safe to get APNs token (iOS only)
      await _setupTokens(messaging);
    } else {
      print('❌ Notifications permission not granted.');
    }

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // Foreground
    FirebaseMessaging.onMessage.listen(CloudMessagingService().foreground);

    // Background
    FirebaseMessaging.onMessageOpenedApp
        .listen(CloudMessagingService().background);

    // Terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(CloudMessagingService().terminated);

    // Local notifications
    //The local notifications service lets you display a notification banner when a message arrives while the app is open.
    LocalNotificationsService().initialize();
  }

  static Future<void> _setupTokens(FirebaseMessaging messaging) async {
    try {
      if (Platform.isIOS) {
        final apnsToken = await messaging.getAPNSToken();
        log(apnsToken != null
            ? '✅ APNs Token: $apnsToken'
            : '❌ APNs token is null.');
      }

      final fcmToken = await messaging.getToken();
      //This fcmToken uniquely identifies this app instance.
      //It can exist even if the user hasn’t logged in yet.
      if (fcmToken != null) {
        log('✅ FCM Token: $fcmToken');
        MySharedPreferences.deviceToken = fcmToken;

        if (MySharedPreferences.accessToken.isNotEmpty) {
          await DeviceTokenService().updateDeviceToken(fcmToken);
        }
      } else {
        log('❌ Failed to fetch FCM token');
      }
    } catch (e) {
      log('Error fetching tokens: $e');
    }
  }
}

/// 🔹 Must be top-level function
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  final data = message.notification;
  if (data != null) {
    log("onBackgroundMessage::\nTitle:: ${data.title}\nBody:: ${data.body}\nData:: ${message.data}");
  }
}
