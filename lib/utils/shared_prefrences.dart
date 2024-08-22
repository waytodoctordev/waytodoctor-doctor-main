import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences sharedPreferences;

  static const String keyIsDoctor = "key_is_doctor";
  static const String keyIsSubscriped = "key_is_subscriped";
  static const String keyAccessToken = "key_access_token";
  static const String keyPassword = "key_password";
  static const String keyEmail = "key_email";
  static const String keyFname = "key_fname";
  static const String keySname = "key_sname";
  static const String keyTname = "key_tname";
  static const String keyLname = "key_lname";
  static const String keyGender = "key_gender";

  static const String keyCategoryId = "key_category_id";
  static const String keyCategoryName = "key_category_name";
  static const String keyUserCount = "key_user_count";
  static const String keyRating = "key_rating";
  static const String keyExperience = "key_experience";
  static const String keyDescription = "key_description";
  static const String keyLat = "key_lat";
  static const String keyLong = "key_long";
  static const String keyDoctorClinicId = "key_clinic_id";
  static const String keyClinicUserID = "key_clinic_user_name";
  static const String keyVerificationId =
      "key_verification_id"; // verificationId
  static const String keyStatus = "key_status";
  static const String keyStep = "key_step";
  static const String keyCountry = "key_country";
  static const String keyCountryCode = "key_country_code";
  static const String keyCity = "key_city";
  static const String keyFormCurrentIndex = "key_form_current_index";
  static const String keyFormIndicatorCurrentIndex =
      "key_form_indicator_current_index";
  static const String keyNationalId = "key_national_id";
  static const String keyDateOfBirth = "key_date_of_birth";
  static const String keyInsurance = "key_insurance";
  static const String keyInsuranceName = "key_insurance_name";
  static const String keyAddress = "key_Address";
  static const String keyIsPassedIntro = "key_is_passed_intro";
  static const String keyActive = "key_active";
  static const String keyLanguage = "key_language";
  static const String keyDeviceToken = "key_device_token";
  static const String keyUserImage = "key_user_image";
  static const String keyUserNumber = "key_user_Number";
  static const String keyUserId = "key_user_id";
  static const String keyCountryDigits = "key_country_digits";
  static const String keySkipOtp = "key_skip_otp";
  static const String keyDoctorId = "key_doctor_id";
  static const String keySubscriptionId = "key_subscription_id";
  static const String keyLastScreen = "key_last_screen";
  static const String keyCurrentSectionId = "key_last_section_id";
  static const String keyCurrentQuestionId = "key_last_question_id";
  static const String keyCurrentQuestionIndex = "key_last_question_index";
  static const String keyCurrentIndicatorIndex = "key_last_indicator_index";
  static  String centerCategoryID = "center_category_id";
  static  int centerID = 1;
  static File professionalLicense =File('');
  static File profileImage =File('');



  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void clearProfile() {
    accessToken = "";
    password = "";
    isDoctor = false;
    email = "";
    fName = "";
    sName = "";
    tName = "";
    lName = "";
    categoryName = "";
    categoryId = 0;
    userCount = 0;
    rating = 0;
    experience = 0;
    description = '';
    lat = 0.0;
    verificationId = "";
    long = 0.0;
    doctorClinicId = 0;
    step = '0';
    skipOtp = 0;
    countryDigits = 9;
    gender = "";
    status = "";
    nationalId = "";
    dateOfBirth = "";
    formCurrentIndex = 0;
    formIndicatorCurrentIndex = 0;
    address = "";
    city = "";
    country = "";
    countryCode = "";
    id = 0;
    userId = 0;
    deviceToken = "";
    userImage = '';
    insurance = '0';
    clinicUserID = '';
    userNumber = '';
    active = '0';
    lastScreen = '';
    isPassedLanguage = false;
    isSubscriped = false;
    // wizard
    currentQuestionId = 0;
    currentSectionId = 0;
    currentQuestionIndex = 0;
    currentIndicatorIndex = 0;
    centerID=0;// indicator
    isProfileImage = true;

  }

  static String get accessToken =>
      sharedPreferences.getString(keyAccessToken) ?? "";
  static set accessToken(String value) =>
      sharedPreferences.setString(keyAccessToken, value);

  static String get password => sharedPreferences.getString(keyPassword) ?? "";
  static set password(String value) =>
      sharedPreferences.setString(keyPassword, value);

  static int get id => sharedPreferences.getInt(keyDoctorId) ?? 0;
  static set id(int value) => sharedPreferences.setInt(keyDoctorId, value);

  static String get verificationId =>
      sharedPreferences.getString(keyVerificationId) ?? "";
  static set verificationId(String value) =>
      sharedPreferences.setString(keyVerificationId, value);

  static String get subscriptionId =>
      sharedPreferences.getString(keySubscriptionId) ?? '';
  static set subscriptionId(String value) =>
      sharedPreferences.setString(keySubscriptionId, value);

  static int get userId => sharedPreferences.getInt(keyUserId) ?? 0;
  static set userId(int value) => sharedPreferences.setInt(keyUserId, value);

  static bool get isDoctor => sharedPreferences.getBool(keyIsDoctor) ?? false;
  static set isDoctor(bool value) =>
      sharedPreferences.setBool(keyIsDoctor, value);

  static int get countryDigits =>
      sharedPreferences.getInt(keyCountryDigits) ?? 0;
  static set countryDigits(int value) =>
      sharedPreferences.setInt(keyCountryDigits, value);

  static int get skipOtp => sharedPreferences.getInt(keySkipOtp) ?? 0;
  static set skipOtp(int value) => sharedPreferences.setInt(keySkipOtp, value);
  static bool get isSubscriped =>
      sharedPreferences.getBool(keyIsSubscriped) ?? false;
  static set isSubscriped(bool value) =>
      sharedPreferences.setBool(keyIsSubscriped, value);

  static bool get isPassedLanguage =>
      sharedPreferences.getBool(keyIsPassedIntro) ?? false;
  static set isPassedLanguage(bool value) =>
      sharedPreferences.setBool(keyIsPassedIntro, value);

  static String get language => sharedPreferences.getString(keyLanguage) ?? "";
  static set language(String value) =>
      sharedPreferences.setString(keyLanguage, value);

  static String get step => sharedPreferences.getString(keyStep) ?? "";
  static set step(String value) => sharedPreferences.setString(keyStep, value);

  static String get active => sharedPreferences.getString(keyActive) ?? "";
  static set active(String value) =>
      sharedPreferences.setString(keyActive, value);

  static String get insurance =>
      sharedPreferences.getString(keyInsurance) ?? "";
  static set insurance(String value) =>
      sharedPreferences.setString(keyInsurance, value);

  static String get clinicUserID =>
      sharedPreferences.getString(keyClinicUserID) ?? "";
  static set clinicUserID(String value) =>
      sharedPreferences.setString(keyClinicUserID, value);

  static String get country => sharedPreferences.getString(keyCountry) ?? "";
  static set country(String value) =>
      sharedPreferences.setString(keyCountry, value);

  static String get city => sharedPreferences.getString(keyCity) ?? "";
  static set city(String value) => sharedPreferences.setString(keyCity, value);

  static String get countryCode =>
      sharedPreferences.getString(keyCountryCode) ?? "";
  static set countryCode(String value) =>
      sharedPreferences.setString(keyCountryCode, value);

  static String get email => sharedPreferences.getString(keyEmail) ?? "";
  static set email(String value) =>
      sharedPreferences.setString(keyEmail, value);

  static String get fName => sharedPreferences.getString(keyFname) ?? "";
  static set fName(String value) =>
      sharedPreferences.setString(keyFname, value);

  static String get sName => sharedPreferences.getString(keySname) ?? "";
  static set sName(String value) =>
      sharedPreferences.setString(keySname, value);

  static String get tName => sharedPreferences.getString(keyTname) ?? "";
  static set tName(String value) =>
      sharedPreferences.setString(keyTname, value);

  static String get lName => sharedPreferences.getString(keyLname) ?? "";
  static set lName(String value) =>
      sharedPreferences.setString(keyLname, value);

  static String get categoryName =>
      sharedPreferences.getString(keySname) ?? "";
  static set categoryName(String value) =>
      sharedPreferences.setString(keySname, value);

  static String get description => sharedPreferences.getString(keyTname) ?? "";
  static set description(String value) =>
      sharedPreferences.setString(keyTname, value);

  static int get categoryId => sharedPreferences.getInt(keyCategoryId) ?? 0;
  static set categoryId(int value) =>
      sharedPreferences.setInt(keyCategoryId, value);

  static String get deviceToken =>
      sharedPreferences.getString(keyDeviceToken) ?? "";
  static set deviceToken(String value) =>
      sharedPreferences.setString(keyDeviceToken, value);

  static String get userImage =>
      sharedPreferences.getString(keyUserImage) ?? "";
  static set userImage(String value) =>
      sharedPreferences.setString(keyUserImage, value);

  static String get userNumber =>
      sharedPreferences.getString(keyUserNumber) ?? "";
  static set userNumber(String value) =>
      sharedPreferences.setString(keyUserNumber, value);

  static String get nationalId =>
      sharedPreferences.getString(keyNationalId) ?? "";
  static set nationalId(String value) =>
      sharedPreferences.setString(keyNationalId, value);

  static String get dateOfBirth =>
      sharedPreferences.getString(keyDateOfBirth) ?? "";
  static set dateOfBirth(String value) =>
      sharedPreferences.setString(keyDateOfBirth, value);

  static String get gender => sharedPreferences.getString(keyGender) ?? "";
  static set gender(String value) =>
      sharedPreferences.setString(keyGender, value);

  static String get status => sharedPreferences.getString(keyStatus) ?? "";
  static set status(String value) =>
      sharedPreferences.setString(keyStatus, value);

  static String get address => sharedPreferences.getString(keyAddress) ?? "";
  static set address(String value) =>
      sharedPreferences.setString(keyAddress, value);

  static int get formCurrentIndex =>
      sharedPreferences.getInt(keyFormCurrentIndex) ?? 0;
  static set formCurrentIndex(int value) =>
      sharedPreferences.setInt(keyFormCurrentIndex, value);

  static int get userCount => sharedPreferences.getInt(keyUserCount) ?? 0;
  static set userCount(int value) =>
      sharedPreferences.setInt(keyUserCount, value);

  static double get rating => sharedPreferences.getDouble(keyRating) ?? 0.0;
  static set rating(double value) =>
      sharedPreferences.setDouble(keyRating, value);

  static int get experience => sharedPreferences.getInt(keyExperience) ?? 0;
  static set experience(int value) =>
      sharedPreferences.setInt(keyExperience, value);

  static int get doctorClinicId =>
      sharedPreferences.getInt(keyDoctorClinicId) ?? 0;
  static set doctorClinicId(int value) =>
      sharedPreferences.setInt(keyDoctorClinicId, value);

  static double get lat => sharedPreferences.getDouble(keyLat) ?? 0.0;
  static set lat(double value) => sharedPreferences.setDouble(keyLat, value);

  static double get long => sharedPreferences.getDouble(keyLong) ?? 0.0;
  static set long(double value) => sharedPreferences.setDouble(keyLong, value);
  static int get formIndicatorCurrentIndex =>
      sharedPreferences.getInt(keyFormIndicatorCurrentIndex) ?? 0;
  static set formIndicatorCurrentIndex(int value) =>
      sharedPreferences.setInt(keyFormIndicatorCurrentIndex, value);

  static String get lastScreen =>
      sharedPreferences.getString(keyLastScreen) ?? "";
  static set lastScreen(String value) =>
      sharedPreferences.setString(keyLastScreen, value);

  static int get currentSectionId =>
      sharedPreferences.getInt(keyCurrentSectionId) ?? 1;
  static set currentSectionId(int value) =>
      sharedPreferences.setInt(keyCurrentSectionId, value);

  static int get currentQuestionId =>
      sharedPreferences.getInt(keyCurrentQuestionId) ?? 0;
  static set currentQuestionId(int value) =>
      sharedPreferences.setInt(keyCurrentQuestionId, value);

  static int get currentQuestionIndex =>
      sharedPreferences.getInt(keyCurrentQuestionIndex) ?? 0;
  static set currentQuestionIndex(int value) =>
      sharedPreferences.setInt(keyCurrentQuestionIndex, value);

  static int get currentIndicatorIndex =>
      sharedPreferences.getInt(keyCurrentIndicatorIndex) ?? 0;
  static set currentIndicatorIndex(int value) =>
      sharedPreferences.setInt(keyCurrentIndicatorIndex, value);

  static set isProfileImage(bool value) =>
      sharedPreferences.setBool(keyCurrentIndicatorIndex, value);

  static bool get isProfileImage =>
      sharedPreferences.getBool(keyCurrentQuestionIndex) ?? false;


}
