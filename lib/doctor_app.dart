import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eraser/eraser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/form/form_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_signup_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_verification_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/services/subscriptions/revenueCat_service.dart';
import 'package:way_to_doctor_doctor/translation/translation.dart';
import 'package:way_to_doctor_doctor/ui/base/for_clinic/clinic_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_screen/form_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/components/doctor_centers_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/widgets/check_practice_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/language/language_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/subscription_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/registration_end.dart';
import 'package:way_to_doctor_doctor/ui/widgets/no_internet.dart';
import 'package:way_to_doctor_doctor/utils/material_theme.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import 'ui/screens/registration/check_practice/check_practice_screen.dart';
import 'ui/screens/registration/phone_sign_up/phone_sign_up_screen.dart';
import 'ui/screens/registration/phone_verification/phone_verification_screen.dart';
import 'ui/screens/registration/registration/registration_screen.dart';
import 'ui/screens/registration/specialization_certificate/specialization_certificate_screen.dart';

class DoctorApp extends StatefulWidget {
  const DoctorApp({super.key});

  @override
  State<DoctorApp> createState() => _DoctorAppState();
}

class _DoctorAppState extends State<DoctorApp> with WidgetsBindingObserver {
  bool internetConnection = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // Monitor connectivity
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((status) {
      setState(() {
        // no internet connection.
        internetConnection = status.any((s) => s != ConnectivityResult.none);
        //.any(...)
        // Checks all interfaces in the list.
        //Returns true if any interface is connected.
        //Use it if you want to detect internet availability regardless of which interface is active.
        // ✅ Safer, more accurate
        // ✅ Works if multiple connections exist (Wi-Fi + mobile)
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        RevenueCatService.refreshCustomerInfo();
        setState(() {});
        // The app is in the foreground and visible to the user.
        // This is when the user returns to your app after minimizing or switching apps.
        Eraser.clearAllAppNotifications();
        break;
      case AppLifecycleState.inactive:
        // On iOS, when the app is in the foreground but the Control Center or a phone call UI appears.
        // On Android, when the app is paused due to a system dialog.
        break;
      case AppLifecycleState.paused:
        // The app is not visible but still running in the background.
        // The user switched to another app, but your app isn’t killed.
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: _initialBinding(),
      translations: Translation(),
      title: 'Doctor',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'JO'),
        Locale('tr', 'TR'),
      ],
      locale: MySharedPreferences.language.isNotEmpty
          ? Locale(MySharedPreferences.language)
          : Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: AppThemeData().materialTheme,
      home: internetConnection ? _toggleScreen() : const NoInternet(),
    );
  }

  Bindings? _initialBinding() {
    switch (MySharedPreferences.lastScreen) {
      case 'DoctorBaseNavBar':
        return DoctorBaseNavBarBinding();
      case 'ClinicBaseNavBar':
        return ClinicBaseNavBarBinding();
      case 'PhoneVerificationScreen':
        return PhoneVerificationBinding();
      case 'FormScreen':
        return FormBinding();
      case 'PhoneSignUpScreen':
        return PhoneSignupBinding();
      default:
        return RegistrationBinding();
    }
  }

  Widget _toggleScreen() {
    if (!MySharedPreferences.isPassedLanguage) {
      return const LanguageScreen();
    }
    switch (MySharedPreferences.lastScreen) {
      case 'DoctorBaseNavBar':
        return const DoctorBaseNavBar();
      case 'CenterHomeScreen':
        return CenterHomeScreen();
      case 'ClinicBaseNavBar':
        return const ClinicBaseNavBar();
      case 'DoctorsCenterScreen':
        return const DoctorsCenterScreen();
      case 'PhoneSignUpScreen':
        return const PhoneSignUpScreen();
      case 'PhoneVerificationScreen':
        return const PhoneVerificationScreen();
      case 'RegistrationEnd':
        return const RegistrationEnd();
      case 'SubscriptionEnd':
        return const SubscriptionEnd();
      case 'CheckPracticeScreen':
        return const CheckPracticeScreen();
      case 'CheckPracticeEndScreen':
        return const CheckPracticeEndScreen();
      case 'SpecializationEndScreen':
        return const SpecializationEndScreen();
      case 'FormScreen':
        return const FormScreen();
      case 'SpecializationScreen':
        return const SpecializationScreen();
      default:
        return const RegistrationScreen();
    }
  }
}
