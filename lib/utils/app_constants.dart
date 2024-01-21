import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/model/agora_model.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class AppConstants {
  static const agoraAppId = 'f910d300985d422b8a59bb8a8ac04994';

  static const googleApiKey = 'AIzaSyDSPeDTWmjTol4rLhHw0fT9Nzrb7bAqs2M';

  static const differentCredentialMessage =
      "[firebase_auth/account-exists-with-different-credential] An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
  static final failedMessage = "Something went Wrong, try again later".tr;
  static final noInternet = "Internet Error".tr;
  static String get requiredField => "Field is required".tr;

  static const String facebookUrl = "https://www.facebook.com/Google/";
  static const String instagram = "https://www.instagram.com/google/";
  static const String twitterUrl =
      "https://twitter.com/Google?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor";

  static String clinic = 'Clinic';
  static String video = 'Video';
  static String chat = 'Chat';
  static String call = 'Call';

  static const String finished = 'Finished';
  static const String approved = 'Approved';
  static const String binding = 'Binding';
  static const String canceled = 'Canceled';

  static const orderCurrency = "USD";
  static const orderDescription = "Way To doctor Subscription";
  static const merchantPass = "bed6e2f9d0166c8796839cb258ceb56b";
  // static const merchantPassDemo = "b6984e6867e341275cb631ca4561f42c";
  static const checkoutUrl = 'https://checkout.montypay.com/api/v1/session';
  static const merchantKey = "5da3c0f4-b36f-11ed-b747-da74035bae1e";
  // static const merchantKeyDemo = "4d759bf8-8cf0-11ed-bc0a-66be8322d928";

  static String get loginFirstMsg => 'Please login first'.tr;
  static String get noItems => 'No items'.tr;
  static String get updatedSuccessfully => 'Updated Successfully'.tr;
  static String get addedSuccessfully => 'Added Successfully'.tr;
  static String get deletedSuccessfully => 'Deleted Successfully'.tr;
  static String get userNotFound => 'Deleted Successfully'.tr;

  Stream<QuerySnapshot<AgoraModel>> fireAgoraStreamForCall() {
    return FirebaseFirestore.instance
        .collection('chat')
        .where('doctorId', isEqualTo: MySharedPreferences.id)
        .where('canCall', isEqualTo: true)
        .orderBy('createdAt', descending: false)
        .withConverter<AgoraModel>(
          fromFirestore: (snapshot, _) => AgoraModel.fromJson(snapshot.data()!),
          toFirestore: (agora, _) => agora.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<AgoraModel>> fireAgoraStreamForAppointment() {
    return FirebaseFirestore.instance
        .collection('chat')
        .where('doctorId', isEqualTo: MySharedPreferences.id)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: false)
        .withConverter<AgoraModel>(
          fromFirestore: (snapshot, _) => AgoraModel.fromJson(snapshot.data()!),
          toFirestore: (agora, _) => agora.toJson(),
        )
        .snapshots();
  }

  showMsgToast(context, {required String msg}) {
    showToast(msg,
        textStyle: const TextStyle(
          color: MyColors.white,
          // fontWeight: FontWeight.w700,
        ),
        context: context,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.sizeFade,
        // fullWidth: true,
        borderRadius: BorderRadius.circular(24),
        isHideKeyboard: true,
        backgroundColor: MyColors.blue14B);
  }

  showLoginFirstToast(context) {
    showToast(AppConstants.loginFirstMsg,
        textStyle: const TextStyle(
          color: MyColors.white,
          // fontWeight: FontWeight.w700,
        ),
        context: context,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.sizeFade,
        // fullWidth: true,
        borderRadius: BorderRadius.circular(24),
        isHideKeyboard: true,
        backgroundColor: MyColors.blue14B);
  }

  static showLoading(
    BuildContext context, {
    Widget? progressIndicator,
  }) {
    Loader.show(
      context,
      overlayColor: Colors.black26,
      progressIndicator: SizedBox(
        height: 60,
        width: 60,
        child: Lottie.asset(
          MyImages.heartLoading,
        ),
      ),
    );
  }
}
