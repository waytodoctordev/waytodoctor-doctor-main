import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:way_to_doctor_doctor/main.dart';
import 'package:way_to_doctor_doctor/services/notifications/local_notifications_service.dart';
import 'package:way_to_doctor_doctor/services/notifications/notifications_routes_service.dart';

class CloudMessagingService {
  void terminated(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null && message.data.isNotEmpty) {
      final data = message.notification;
      log("terminatedMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
      RoutesService().toggle(message.data);
    }
  }

  void foreground(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null) {
      final data = message.notification;
      notificationsMap = message.data;
      print('${message.data} nancy foreground');
      print("foregroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
      LocalNotificationsService().display(message);

      // if (MySharedPreferences.isDoctor) {
      //   if (DoctorBaseNavBarCtrl.find.navBarController.index == 3) {
      //     DoctorNotificationsCtrl.find.pagingController.refresh();
      //     DoctorHomeScreenCtrl.find.pagingController.refresh();
      //     DoctorHomeScreenCtrl.find.fetchUrgentAppointments();
      //     DoctorHomeScreenCtrl.find.fetchAppointmentsCounter();
      //     DoctorAppointmentsCtrl.find.pagingController.refresh();
      //   } else {
      //     DoctorAppointmentsCtrl.find.pagingController.refresh();
      //     DoctorHomeScreenCtrl.find.pagingController.refresh();
      //     DoctorHomeScreenCtrl.find.fetchUrgentAppointments();
      //     DoctorHomeScreenCtrl.find.fetchAppointmentsCounter();
      //   }
      // }
      // else {
      //   if (ClinicBaseNavBarCtrl.find.navBarController.index == 3)
      //   {
      //     DoctorNotificationsCtrl.find.pagingController.refresh();
      //     ClinicHomeScreenCtrl.find.pagingController.refresh();
      //     ClinicHomeScreenCtrl.find.fetchUrgentAppointments();
      //     ClinicHomeScreenCtrl.find.fetchAppointmentsCounter();
      //     ClinicAppointmentsCtrl.find.pagingController.refresh();
      //   } else {
      //     ClinicHomeScreenCtrl.find.pagingController.refresh();
      //     ClinicHomeScreenCtrl.find.fetchUrgentAppointments();
      //     ClinicHomeScreenCtrl.find.fetchAppointmentsCounter();
      //     ClinicAppointmentsCtrl.find.pagingController.refresh();
      //   }
      }
    // }
  }

  void background(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null && message.data.isNotEmpty) {
      final data = message.notification;
      print("backgroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
      RoutesService().toggle(message.data);
    }
  }
}
