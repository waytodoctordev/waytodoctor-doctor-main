import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

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
    _sharedPreferences = await SharedPreferences.getInstance();
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
      _sharedPreferences.getString(keyAccessToken) ?? "";
  static set accessToken(String value) =>
      _sharedPreferences.setString(keyAccessToken, value);

  static String get password => _sharedPreferences.getString(keyPassword) ?? "";
  static set password(String value) =>
      _sharedPreferences.setString(keyPassword, value);

  static int get id => _sharedPreferences.getInt(keyDoctorId) ?? 0;
  static set id(int value) => _sharedPreferences.setInt(keyDoctorId, value);

  static String get verificationId =>
      _sharedPreferences.getString(keyVerificationId) ?? "";
  static set verificationId(String value) =>
      _sharedPreferences.setString(keyVerificationId, value);

  static String get subscriptionId =>
      _sharedPreferences.getString(keySubscriptionId) ?? '';
  static set subscriptionId(String value) =>
      _sharedPreferences.setString(keySubscriptionId, value);

  static int get userId => _sharedPreferences.getInt(keyUserId) ?? 0;
  static set userId(int value) => _sharedPreferences.setInt(keyUserId, value);

  static bool get isDoctor => _sharedPreferences.getBool(keyIsDoctor) ?? false;
  static set isDoctor(bool value) =>
      _sharedPreferences.setBool(keyIsDoctor, value);

  static int get countryDigits =>
      _sharedPreferences.getInt(keyCountryDigits) ?? 0;
  static set countryDigits(int value) =>
      _sharedPreferences.setInt(keyCountryDigits, value);

  static int get skipOtp => _sharedPreferences.getInt(keySkipOtp) ?? 0;
  static set skipOtp(int value) => _sharedPreferences.setInt(keySkipOtp, value);
  static bool get isSubscriped =>
      _sharedPreferences.getBool(keyIsSubscriped) ?? false;
  static set isSubscriped(bool value) =>
      _sharedPreferences.setBool(keyIsSubscriped, value);

  static bool get isPassedLanguage =>
      _sharedPreferences.getBool(keyIsPassedIntro) ?? false;
  static set isPassedLanguage(bool value) =>
      _sharedPreferences.setBool(keyIsPassedIntro, value);

  static String get language => _sharedPreferences.getString(keyLanguage) ?? "";
  static set language(String value) =>
      _sharedPreferences.setString(keyLanguage, value);

  static String get step => _sharedPreferences.getString(keyStep) ?? "";
  static set step(String value) => _sharedPreferences.setString(keyStep, value);

  static String get active => _sharedPreferences.getString(keyActive) ?? "";
  static set active(String value) =>
      _sharedPreferences.setString(keyActive, value);

  static String get insurance =>
      _sharedPreferences.getString(keyInsurance) ?? "";
  static set insurance(String value) =>
      _sharedPreferences.setString(keyInsurance, value);

  static String get clinicUserID =>
      _sharedPreferences.getString(keyClinicUserID) ?? "";
  static set clinicUserID(String value) =>
      _sharedPreferences.setString(keyClinicUserID, value);

  static String get country => _sharedPreferences.getString(keyCountry) ?? "";
  static set country(String value) =>
      _sharedPreferences.setString(keyCountry, value);

  static String get city => _sharedPreferences.getString(keyCity) ?? "";
  static set city(String value) => _sharedPreferences.setString(keyCity, value);

  static String get countryCode =>
      _sharedPreferences.getString(keyCountryCode) ?? "";
  static set countryCode(String value) =>
      _sharedPreferences.setString(keyCountryCode, value);

  static String get email => _sharedPreferences.getString(keyEmail) ?? "";
  static set email(String value) =>
      _sharedPreferences.setString(keyEmail, value);

  static String get fName => _sharedPreferences.getString(keyFname) ?? "";
  static set fName(String value) =>
      _sharedPreferences.setString(keyFname, value);

  static String get sName => _sharedPreferences.getString(keySname) ?? "";
  static set sName(String value) =>
      _sharedPreferences.setString(keySname, value);

  static String get tName => _sharedPreferences.getString(keyTname) ?? "";
  static set tName(String value) =>
      _sharedPreferences.setString(keyTname, value);

  static String get lName => _sharedPreferences.getString(keyLname) ?? "";
  static set lName(String value) =>
      _sharedPreferences.setString(keyLname, value);

  static String get categoryName =>
      _sharedPreferences.getString(keySname) ?? "";
  static set categoryName(String value) =>
      _sharedPreferences.setString(keySname, value);

  static String get description => _sharedPreferences.getString(keyTname) ?? "";
  static set description(String value) =>
      _sharedPreferences.setString(keyTname, value);

  static int get categoryId => _sharedPreferences.getInt(keyCategoryId) ?? 0;
  static set categoryId(int value) =>
      _sharedPreferences.setInt(keyCategoryId, value);

  static String get deviceToken =>
      _sharedPreferences.getString(keyDeviceToken) ?? "";
  static set deviceToken(String value) =>
      _sharedPreferences.setString(keyDeviceToken, value);

  static String get userImage =>
      _sharedPreferences.getString(keyUserImage) ?? "";
  static set userImage(String value) =>
      _sharedPreferences.setString(keyUserImage, value);

  static String get userNumber =>
      _sharedPreferences.getString(keyUserNumber) ?? "";
  static set userNumber(String value) =>
      _sharedPreferences.setString(keyUserNumber, value);

  static String get nationalId =>
      _sharedPreferences.getString(keyNationalId) ?? "";
  static set nationalId(String value) =>
      _sharedPreferences.setString(keyNationalId, value);

  static String get dateOfBirth =>
      _sharedPreferences.getString(keyDateOfBirth) ?? "";
  static set dateOfBirth(String value) =>
      _sharedPreferences.setString(keyDateOfBirth, value);

  static String get gender => _sharedPreferences.getString(keyGender) ?? "";
  static set gender(String value) =>
      _sharedPreferences.setString(keyGender, value);

  static String get status => _sharedPreferences.getString(keyStatus) ?? "";
  static set status(String value) =>
      _sharedPreferences.setString(keyStatus, value);

  static String get address => _sharedPreferences.getString(keyAddress) ?? "";
  static set address(String value) =>
      _sharedPreferences.setString(keyAddress, value);

  static int get formCurrentIndex =>
      _sharedPreferences.getInt(keyFormCurrentIndex) ?? 0;
  static set formCurrentIndex(int value) =>
      _sharedPreferences.setInt(keyFormCurrentIndex, value);

  static int get userCount => _sharedPreferences.getInt(keyUserCount) ?? 0;
  static set userCount(int value) =>
      _sharedPreferences.setInt(keyUserCount, value);

  static double get rating => _sharedPreferences.getDouble(keyRating) ?? 0.0;
  static set rating(double value) =>
      _sharedPreferences.setDouble(keyRating, value);

  static int get experience => _sharedPreferences.getInt(keyExperience) ?? 0;
  static set experience(int value) =>
      _sharedPreferences.setInt(keyExperience, value);

  static int get doctorClinicId =>
      _sharedPreferences.getInt(keyDoctorClinicId) ?? 0;
  static set doctorClinicId(int value) =>
      _sharedPreferences.setInt(keyDoctorClinicId, value);

  static double get lat => _sharedPreferences.getDouble(keyLat) ?? 0.0;
  static set lat(double value) => _sharedPreferences.setDouble(keyLat, value);

  static double get long => _sharedPreferences.getDouble(keyLong) ?? 0.0;
  static set long(double value) => _sharedPreferences.setDouble(keyLong, value);
  static int get formIndicatorCurrentIndex =>
      _sharedPreferences.getInt(keyFormIndicatorCurrentIndex) ?? 0;
  static set formIndicatorCurrentIndex(int value) =>
      _sharedPreferences.setInt(keyFormIndicatorCurrentIndex, value);

  static String get lastScreen =>
      _sharedPreferences.getString(keyLastScreen) ?? "";
  static set lastScreen(String value) =>
      _sharedPreferences.setString(keyLastScreen, value);

  static int get currentSectionId =>
      _sharedPreferences.getInt(keyCurrentSectionId) ?? 1;
  static set currentSectionId(int value) =>
      _sharedPreferences.setInt(keyCurrentSectionId, value);

  static int get currentQuestionId =>
      _sharedPreferences.getInt(keyCurrentQuestionId) ?? 0;
  static set currentQuestionId(int value) =>
      _sharedPreferences.setInt(keyCurrentQuestionId, value);

  static int get currentQuestionIndex =>
      _sharedPreferences.getInt(keyCurrentQuestionIndex) ?? 0;
  static set currentQuestionIndex(int value) =>
      _sharedPreferences.setInt(keyCurrentQuestionIndex, value);

  static int get currentIndicatorIndex =>
      _sharedPreferences.getInt(keyCurrentIndicatorIndex) ?? 0;
  static set currentIndicatorIndex(int value) =>
      _sharedPreferences.setInt(keyCurrentIndicatorIndex, value);

  static set isProfileImage(bool value) =>
      _sharedPreferences.setBool(keyCurrentIndicatorIndex, value);

  static bool get isProfileImage =>
      _sharedPreferences.getBool(keyCurrentQuestionIndex) ?? false;


}
