class ApiUrl {
  static const String  secondaryUrl= "https://waytodoctor.wecan.work/public";
  static const String mainUrl  = "https://waytodoctor.net";

  //registration
  static const String doctorSignIn = "/api/v1/doctor-login";
  static const String signInUser = "/api/v1/login";
  static const String clinicSignIn = "/api/v1/clinic-login";
  static const String centerSignIn = "/api/v1/center-login";
  static const String pages = "/api/v1/page"; // Privcy - FAQ ..
  static const String profile = "/api/v1/user";
  static const String logout = "/api/v1/logout";
  static const String doctorSignUp = "/api/v1/doctor-create";
  static const String clinicSignUp = "/api/v1/clinic-create";
  static const String centerSignUp = "/api/v1/center-create";
  static const String doctorCreateCertificate = "/api/v1/certificate-create";
  static const String doctorCreateSpecialization =
      "/api/v1/specialization-create";
  static const String updateUser = "/api/v1/user/update";
  static const String checkOtp = "/api/v1/otb-check";
  static const String updateUserNumber = "/api/v1/phone-update";
  static const String resetPassStep1 = "/api/v1/password-otb";
  static const String resetPassStep2 = "/api/v1/otb-check";
  static const String resetPassStep3 = "/api/v1/change-password";
  static const String countries = "/api/v1/countries";
  static const String cities = "/api/v1/cities";
  static const String plansforJordan = "/api/v1/plans-Jorden";
  static const String plansforOtherCountries = "/api/v1/other-plans";
  static const String currentPlan = "/api/v1/subscription";
  static const String getSubscrib = "/api/v1/subscription";
  static const String createSubscription = "/api/v1/subscription-create";
  // subscription-create

  // home screen
  static const String sliders = "/api/v1/sliders";
  static const String getDoctorRatings = "/api/v1/doctor/get-reviews";
  static const String coupon = "/api/v1/coupon";
  static const String getTransaction = "/api/v1/transaction";
  static const String urgentsAppointmentsForDoctor =
      "/api/v1/check-type-doctor";
  static const String urgentsAppointmentsForClinic =
      "/api/v1/check-type-clinic";
  static const String counterForDoctor = "/api/v1/appointments-counter-doctor";
  static const String counterForClinic = "/api/v1/appointments-counter-clinic";

  // notifications
  static const String notifications = "/api/v1/my-notifications";

  // doctor
  static const String appointmentsByDoctor = "/api/v1/appointments-by-doctor";
  static const String getUserDoctors = "/api/v1/my-doctors";
  static const String categoriesByType = "/api/v1/categories-by-type";
  static const String addCategoriestoDoctor = "/api/v1/doctor/add-category";
  static const String appointmentsByDateForDoctor =
      "/api/v1/appointments-doctor-by-date";
  static const String workHoursForDoctor = "/api/v1/workhours-for-doctor";
  static const String createPayment = "/api/v1/payment-create";
  static const String deletePayment = "/api/v1/payment/delete";
  static const String createPictures = "/api/v1/picture-create";
  static const String deletePictures = "/api/v1/picture/delete";
  static const String createStudies = "/api/v1/study-create";
  static const String deleteStudies = "/api/v1/study/delete";
  static const String createCertificate = "/api/v1/certificate-create";
  static const String deleteCertificate = "/api/v1/certificate/delete";
  static const String getDoctorDetails = "/api/v1/doctor";
  static const String updateWorkHours = "/api/v1/workhour/edit";
  static const String updateDoctorData = "/api/v1/doctor/edit";
  static const String doctorReplays = "/api/v1/replays-by-appointment";
  static const String doctorDescriptions =
      "/api/v1/doctor-description-by-appointment";
  static const String createReplay = "/api/v1/replay-create";
  static const String createDescription = "/api/v1/doctor-description-create";
  static const String userMedicalInfo = "/api/v1/my-results";
  static const String userMedicalHistory = "/api/v1/all-by-user-doctor";
  static const String getMyOtherDoctors = "/api/v1/my-others";
  static const String doctorsCenter = "/api/v1/center/doctors/search";

  //

  // clinic
  static const String appointmentsByclinic = "/api/v1/appointments-by-clinic";
  static const String canceledAppointmentsByclinic =
      "/api/v1/canceled-appointment-clinic";
  static const String finishedAppointmentsByclinic =
      "/api/v1/finished-appointment-clinic";
  static const String nextAppointmentsByclinic =
      "/api/v1/next-appointment-clinic";
  static const String workHoursForClinic = "/api/v1/workhours-for-clinic";
  static const String viewClinicByUserId = "/api/v1/view-clinic";
  static const String updateClinicData = "/api/v1/clinic/edit";
  static const String updateAppointmentData = "/api/v1/appointment/edit";
  static const String viewAppointmentData = "/api/v1/appointment";

  //device token
  static const String updateDeviceToken = "/api/v1/user/token";
  static const String sendNotification = "/api/v1/send-noti";
  static const String deleteAccount = "/api/v1/update-block";
  static const String centerCategories = "/api/v1/center-categories";
  static const String categoryCenters = "/api/v1/centers-by-id";
  static const String deleteCenter = "/api/v1/center/delete";
  static const String editCenterInfo = "/api/v1/center-edit";
  static const String changeActivityStatus = "/api/v1/center-change-status";
  static const String joiningToCenter = "/api/v1/center-assign";
  static const String applePurchase = "/api/v1/verify-purchase";





}
