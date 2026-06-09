class ApiUrl {
  static const String  secondaryUrl= "https://waytodoctor.wecan.work/public";
  // static const String  mainUrl= "https://waytodoctor.wecan.work/public"; 
  static const String mainUrl  = "https://waytodoctor.net/api/v1/";

  //registration
  static const String doctorSignIn = "doctor-login";
  static const String signInUser = "login";
  static const String clinicSignIn = "clinic-login";
  static const String centerSignIn = "center-login";
  static const String pages = "page"; // Privcy - FAQ ..
  static const String profile = "user";
  static const String logout = "logout";
  static const String doctorSignUp = "doctor-create";
  static const String clinicSignUp = "clinic-create";
  static const String centerSignUp = "center-create";
  static const String doctorCreateCertificate = "certificate-create";
  static const String doctorCreateSpecialization =
      "specialization-create";
  static const String updateUser = "user/update";
  static const String checkOtp = "otb-check";
  static const String updateUserNumber = "phone-update";
  static const String resetPassStep1 = "password-otb";
    static const String resendOtp = 'resend-otp';

  static const String resetPassStep2 = "otb-check";
  static const String resetPassStep3 = "change-password";
  static const String countries = "countries";
  static const String cities = "cities";
  static const String plansforJordan = "plans-Jorden";
  static const String plansforOtherCountries = "other-plans";
  static const String currentPlan = "subscription";
  static const String getSubscrib = "subscription";
  static const String createSubscription = "subscription-create";
  // subscription-create

  // home screen
  static const String sliders = "sliders";
  static const String getDoctorRatings = "doctor/get-reviews";
  static const String coupon = "coupon";
  static const String getTransaction = "transaction";
  static const String urgentsAppointmentsForDoctor =
      "check-type-doctor";
  static const String urgentsAppointmentsForClinic =
      "check-type-clinic";
  static const String counterForDoctor = "appointments-counter-doctor";
  static const String counterForClinic = "appointments-counter-clinic";

  // notifications
  static const String notifications = "my-notifications";

  // doctor
  static const String appointmentsByDoctor = "appointments-by-doctor";
  static const String getUserDoctors = "my-doctors";
  static const String categoriesByType = "categories-by-type";
  static const String addCategoriestoDoctor = "doctor/add-category";
  static const String appointmentsByDateForDoctor =
      "appointments-doctor-by-date";
  static const String workHoursForDoctor = "workhours-for-doctor";
  static const String createPayment = "payment-create";
  static const String deletePayment = "payment/delete";
  static const String createPictures = "picture-create";
  static const String deletePictures = "picture/delete";
  static const String createStudies = "study-create";
  static const String deleteStudies = "study/delete";
  static const String createCertificate = "certificate-create";
  static const String deleteCertificate = "certificate/delete";
  static const String getDoctorDetails = "doctor";
  static const String updateWorkHours = "workhour/edit";
  static const String updateDoctorData = "doctor/edit";
  static const String doctorReplays = "replays-by-appointment";
  static const String doctorDescriptions =
      "doctor-description-by-appointment";
  static const String createReplay = "replay-create";
  static const String createDescription = "doctor-description-create";
  static const String userMedicalInfo = "my-results";
  static const String userMedicalHistory = "all-by-user-doctor";
  static const String getMyOtherDoctors = "my-others";
  static const String doctorsCenter = "center/doctors/search";

  //

  // clinic
  static const String appointmentsByclinic = "appointments-by-clinic";
  static const String canceledAppointmentsByclinic =
      "canceled-appointment-clinic";
  static const String finishedAppointmentsByclinic =
      "finished-appointment-clinic";
  static const String nextAppointmentsByclinic =
      "next-appointment-clinic";
  static const String workHoursForClinic = "workhours-for-clinic";
  static const String viewClinicByUserId = "view-clinic";
  static const String updateClinicData = "clinic/edit";
  static const String updateAppointmentData = "appointment/edit";
  static const String viewAppointmentData = "appointment";

  //device token
  static const String updateDeviceToken = "user/token";
  static const String sendNotification = "send-noti";
  static const String deleteAccount = "update-block";
  static const String centerCategories = "center-categories";
  static const String categoryCenters = "centers-by-id";
  static const String deleteCenter = "center/delete";
  static const String editCenterInfo = "center-edit";
  static const String changeActivityStatus = "center-change-status";
  static const String joiningToCenter = "center-assign";
  static const String applePurchase = "verify-purchase";





}
