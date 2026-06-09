//flutter build appbundle --release
//flutter build ios --release


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/services/subscriptions/revenueCat_service.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import 'doctor_app.dart';
import 'services/notifications/notification_handler.dart';


Map<String, dynamic> notificationsMap = {};
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreferences.init();



  await NotificationHandler.initializeFCM();// ✅ Setup FCM

  await RevenueCatService.init(); // ✅ Setup RevenueCat
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await RevenueCatService.refreshCustomerInfo();
  }
  runApp(const DoctorApp());
}


