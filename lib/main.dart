//khaled basem awad .. my saved project // ...
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eraser/eraser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:way_to_doctor_doctor/api/notifications/device_token_services.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/form/form_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_signup_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_verification_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/services/notifications/cloud_messaging_service.dart';
import 'package:way_to_doctor_doctor/services/notifications/local_notifications_service.dart';
import 'package:way_to_doctor_doctor/translation/translation.dart';
import 'package:way_to_doctor_doctor/ui/base/for_clinic/clinic_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/forms/form_screen/form_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/components/doctor_center_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/widgets/check_practice_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/language/language_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/subscription_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/registration_end.dart';
import 'package:way_to_doctor_doctor/ui/widgets/no_internet.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/material_theme.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import 'ui/screens/registration/phone_sign_up/phone_sign_up_screen.dart';
import 'ui/screens/registration/phone_verification/phone_verification_screen.dart';
import 'ui/screens/registration/registration/registration_screen.dart';


Map<String, dynamic> notificationsMap = {};

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    final data = message.notification;
    log("onBackgroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InAppPurchase.instance;

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await MySharedPreferences.init();

  /// nancy you have committed this 3 lines
  // MySharedPreferences.language = MySharedPreferences.isPassedLanguage
  //     ? MySharedPreferences.language
  //     : 'en';
  // print(MySharedPreferences.userId);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MyColors.white,
      systemNavigationBarDividerColor: MyColors.white,
    ),
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


if(Platform.isIOS){
  await Purchases.configure(PurchasesConfiguration('appl_qcOhbTzuTasmrDNUAFsUkqUBsFE'));
}
  runApp(const MyApp());
  Eraser.clearAllAppNotifications();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool internetConnection = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.resumed == state) {
      Eraser.clearAllAppNotifications();
    }
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    MySharedPreferences.sharedPreferences.clear();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.instance.getToken().then((value) async {
      MySharedPreferences.deviceToken = value!;
      // log("deviceToken:: $value");
      if (MySharedPreferences.accessToken.isNotEmpty) {
        DeviceTokenService().updateDeviceToken(value);
      }
    });
    Connectivity().onConnectivityChanged.listen((status) {
      log("internetStatus:: $status");
      if (status == ConnectivityResult.none) {
        setState(() {
          internetConnection = false;
        });
      } else {
        setState(() {
          internetConnection = true;
        });
      }
    });
    LocalNotificationsService().initialize();

    FirebaseMessaging.instance.requestPermission().then((value) {});

    //  check if needed for ios
    // FirebaseMessaging.instance.getToken().then((token) {});
    // FirebaseMessaging.instance.getAPNSToken().then((aPNStoken) {});

    FirebaseMessaging.instance
        .getInitialMessage()
        .then(CloudMessagingService().terminated);
    FirebaseMessaging.onMessage.listen(CloudMessagingService().foreground);
    FirebaseMessaging.onMessageOpenedApp
        .listen(CloudMessagingService().background);
    super.initState();
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
        return RegestirationBinding();
    }
  }

  _toggleScreen() {

    if (!MySharedPreferences.isPassedLanguage) {
      return const LanguageScreen();
    } else {
      switch (MySharedPreferences.lastScreen) {
        case 'DoctorBaseNavBar':
          return const DoctorBaseNavBar();
        case 'ClinicBaseNavBar':
          return const ClinicBaseNavBar();
        case 'DoctorsCenterScreen':
          return const  DoctorsCenterScreen();
        case 'PhoneSignUpScreen':
          return const PhoneSignUpScreen();
        case 'PhoneVerificationScreen':
          return const PhoneVerificationScreen();
        case 'RegistrationEnd':
          return const RegistrationEnd();
        case 'SubscriptionEnd':
          return const SubscriptionEnd();
        case 'CheckPracticeEndScreen':
          return const CheckPracticeEndScreen();
        case 'SpecializationEndScreen':
          return const SpecializationEndScreen();
        case 'FormScreen':
          return const FormScreen();
        default:
          return const RegistrationScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('MySharedPreferences.language ${MySharedPreferences.language}');
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
}
