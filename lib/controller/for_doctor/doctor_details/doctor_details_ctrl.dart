import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:way_to_doctor_doctor/model/create_payment/create_payment_mode.dart';
import 'package:way_to_doctor_doctor/model/delete_model.dart';
import '../../../api/for_doctor/doctor_details/doctor_details_api.dart';
import '../../../api/registration/update_form_information_api.dart';
import '../../../model/create_certificate/create_certificate_mode.dart';
import '../../../model/doctor_model/doctor_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/user/user_model.dart';
import '../../../services/api_request_handlers/api_service.dart';
import '../../../ui/widgets/overlay_loader.dart';
import '../../../utils/api_url.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefrences.dart';

class DoctorDetailsCtrl extends GetxController {
  static DoctorDetailsCtrl get find => Get.find();
  ApiService apiRequestService = ApiService();

  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  String doctorID = '';
  UserModel? userModel;
  DoctorDetailsModel? doctor;
  DoctorDetailsModel? doctorDetailsModel;
  CreatePaymentModel? createPaymentModel;
  CreateCertificateModel? createCertificateModel;
  DeleteModel? deleteModel;

  late Future<DoctorDetailsModel?> initializeDoctorDetailsFuture;

  /// DONE . => GETTING DOCTOR DETAILS API REPLACED WITH OLD DoctorDetailsApi API
  Future<DoctorDetailsModel?> fetchDoctorDetailsData(
      {required String doctorId, required BuildContext context}) async {
    try {
      print('fetchDoctorDetailsData');
      print('doctorID $doctorID');
      doctor = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.getDoctorDetails}/$doctorId',
          fromJson: (json) => DoctorDetailsModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
            'X-localization': MySharedPreferences.language,
          });
      if (doctor!.code == 200) {
        isLoading = false;
        update();
        return doctor;
      }
      // doctor = await DoctorDetailsApi.data(doctorId: id);
    } catch (error) {
      doctor!.msg == ''
          ? AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage)
          : AppConstants().showMsgToast(context, msg: doctor!.msg!);
      Loader.hide();
      isLoading = false;
      update();
      return doctor;
    }
    return null;
  }

  /// DONE WITHOUT ANY NEW API REQUEST
  Future getProfileImage(
      {required BuildContext context, required String doctorId}) async {
    print(doctorId);
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    doctorID = doctorId;
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      print('picked file $imageFile');
      updateUserImage(
        profileImage: imageFile,
        context: context,
      );
      // updateProfileImage(profileImage: imageFile, context: context);
      update();
    } else {
      debugPrint('no image selected');
    }
  }

  /// DONE WITHOUT ANY NEW API REQUEST
  Future updateUserImage(
      {required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    print('updateUserImage');
    userModel = await UpdateUserDataApi.updateUserImage(
      profileImage: profileImage,
    );
    if (userModel == null) {
      print('userModel == null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      print('userModel == 200');

      await updateDoctorImage(profileImage: profileImage, context: context);
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }

  /// DONE WITHOUT ANY NEW API REQUEST
  Future updateDoctorImage(
      {required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    print('updateDoctorImage');
    print('doctorID $doctorID');
    doctorDetailsModel = await UpdateUserDataApi.updateDoctorImage(
      profileImage: profileImage,
    );
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.userImage =
          doctorDetailsModel!.data!.image.toString();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      fetchDoctorDetailsData(doctorId: doctorID, context: context);
      update();
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  /// DONE . => EDITING DOCTOR DESCRIPTION API REPLACED WITH OLD doctorDescription API
  Future updateDoctorDescription(
      {required String description, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    try {
      doctorDetailsModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url:
              '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}',
          fromJson: (json) => DoctorDetailsModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
            'X-localization': MySharedPreferences.language,
          },
          body: {
            "description": description,
          });
      // doctorDetailsModel =
      //     await DoctorDetailsApi().doctorDescription(description: description);

      if (doctorDetailsModel!.code == 200) {
        MySharedPreferences.description =
            doctorDetailsModel!.data!.description!;
        AppConstants()
            .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
        fetchDoctorDetailsData(
            doctorId: MySharedPreferences.id.toString(), context: context);
        Loader.hide();
      }
    } catch (error) {
      doctorDetailsModel!.msg != ''
          ? AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!)
          : AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
  }

  /// DONE . => EDITING DOCTOR EXPERIENCE API REPLACED WITH OLD doctorExperience API
  Future updateDoctorExperience(
      {required int experience, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    try {
      doctorDetailsModel = await apiRequestService.makeRequest(
        method: AppConstants.postMethod,
        url:
            '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}',
        fromJson: (json) => DoctorDetailsModel.fromJson(json),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
          'X-localization': MySharedPreferences.language,
        },
        body: {
          "experience": experience,
        },
      );
      // doctorDetailsModel =
      //     await DoctorDetailsApi().doctorExperience(experience: experience);

      if (doctorDetailsModel!.code == 200) {
        MySharedPreferences.experience = doctorDetailsModel!.data!.experience!;

        AppConstants()
            .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
        fetchDoctorDetailsData(
            doctorId: MySharedPreferences.id.toString(), context: context);
        Loader.hide();
        update();
      }
    } catch (error) {
      doctorDetailsModel!.msg == ''
          ? AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage)
          : AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
      Loader.hide();

      return;
    }
  }

  /// DONE . => ADDING PAYMENT METHOD FOR  DOCTOR'S METHODS API REPLACED WITH OLD createPayment API
  Future createPayment({
    required BuildContext context,
    required String name,
  }) async {
    AppConstants.showLoading(context);
    try {
      createPaymentModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.createPayment}',
          fromJson: (json) => CreatePaymentModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
            'X-localization': MySharedPreferences.language,
          },
          body: {
            "name": name,
            "doctor_id": MySharedPreferences.id,
            // "phone": MySharedPreferences.userNumber,
          });
      // createPaymentModel = await DoctorDetailsApi.createPayment(name: name);

      if (createPaymentModel!.code == 200) {
        fetchDoctorDetailsData(
            doctorId: MySharedPreferences.id.toString(), context: context);
        AppConstants()
            .showMsgToast(context, msg: AppConstants.addedSuccessfully);
        update();
        Loader.hide();
      }
      if (createPaymentModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      } else {
        createPaymentModel!.msg == ''
            ? AppConstants()
                .showMsgToast(context, msg: AppConstants.failedMessage)
            : AppConstants()
                .showMsgToast(context, msg: createPaymentModel!.msg!);
        Loader.hide();
      }
      Loader.hide();
    } catch (error) {
      createPaymentModel!.msg == ''
          ? AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage)
          : AppConstants().showMsgToast(context, msg: createPaymentModel!.msg!);
      Loader.hide();
    }
  }

  /// DONE . => DELETING PAYMENT METHOD FOR  DOCTOR'S METHODS API REPLACED WITH OLD deletePayment API
  Future deletePaymentAndCertificateAndStudyAndPIC(
      {required BuildContext context,
      required String id,
      required isCertificate,
      required isStudy,
      required isPicture,
      required isPayment}) async {
    AppConstants.showLoading(context);
    try {
      String url = '${ApiUrl.mainUrl}'
          '${isCertificate ? ApiUrl.deleteCertificate : isStudy ? ApiUrl.deleteStudies : isPicture ? ApiUrl.deletePictures : isPayment ? ApiUrl.deletePayment : ''}/$id';

      deleteModel = await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url: url,
        fromJson: (json) => DeleteModel.fromJson(json),
      );
      if (deleteModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      } else if (deleteModel!.code == 200) {
        fetchDoctorDetailsData(
            doctorId: MySharedPreferences.id.toString(), context: context);
        AppConstants()
            .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
        update();
        Loader.hide();
      } else {
        AppConstants().showMsgToast(context, msg: deleteModel!.msg!);
        Loader.hide();
      }
    } catch (error) {
      deleteModel!.msg != ''
          ? AppConstants().showMsgToast(context, msg: deleteModel!.msg!)
          : AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
    // deleteModel = await DoctorDetailsApi.deletePayment(id: id);
  }

  /// DONE
  getStudiesAndCertificatesAndPictures(
      {context,
      required isCertificate,
      required isPicture,
      required isStudy}) async {
    FilePickerResult? result =
        await FilePicker.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      isCertificate
          ? createCertificateAndStudyAndPic(
              context: context,
              image: file,
              isCertificate: true,
              isStudy: false,
              isPicture: false)
          : '';
      isPicture
          ? createPictures(context: context, image: file)
          //createCertificateAndStudyAndPic(
          //   context: context,
          // image: file,
          // isCertificate: false,
          // isStudy: false,
          // isPicture: true)
          : '';
      isStudy
          ? createCertificateAndStudyAndPic(
              context: context,
              image: file,
              isCertificate: false,
              isStudy: true,
              isPicture: false)
          : '';

      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  /// DONE BY DOING NOTHING.

  Future createCertificateAndStudyAndPic(
      {required BuildContext context,
      required File image,
      required isCertificate,
      required isPicture,
      required isStudy}) async {
    AppConstants.showLoading(context);
    createCertificateModel = await uploadPractice(
        image: image,
        isCertificate: isCertificate,
        isPicture: isPicture,
        isStudy: isStudy);
    if (createCertificateModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createCertificateModel!.code == 200) {
      fetchDoctorDetailsData(
          doctorId: MySharedPreferences.id.toString(), context: context);
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      update();
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);

      Loader.hide();
    }
    Loader.hide();
  }

  static Future<CreateCertificateModel?> uploadPractice(
      {required File image,
      required isCertificate,
      required isPicture,
      required isStudy}) async {
    try {
      var imageStream = http.ByteStream(image.openRead());
      var imageLength = await image.length();
      var fileStream = http.ByteStream(image.openRead());
      var fileLength = await image.length();
      var uri = Uri.parse(
          "${ApiUrl.mainUrl}${isCertificate ? ApiUrl.doctorCreateCertificate : isStudy ? ApiUrl.createStudies : isPicture ? ApiUrl.createPictures : ''}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      request.headers.addAll(headers);
      var multipartImage = http.MultipartFile("image", imageStream, imageLength,
          filename: basename(image.path));
      var multipartFile = http.MultipartFile("file", fileStream, fileLength,
          filename: basename(image.path));
      request.files.add(multipartImage);
      request.files.add(multipartFile);
      request.fields['title'] = MySharedPreferences.fName;
      request.fields['doctor_id'] = MySharedPreferences.id.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        CreateCertificateModel certificateModel =
            CreateCertificateModel.fromJson(jsonData);
        return certificateModel;
      } else {
        throw "error uploading images ";
      }
    } catch (e) {
      return null;
    }
  }

  Future createPictures({
    required BuildContext context,
    required File image,
  }) async {
    AppConstants.showLoading(context);
    try {
      createCertificateModel =
          await DoctorDetailsApi.createPictures(image: image);
      if (createCertificateModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      }
      if (createCertificateModel!.code == 200) {
        fetchDoctorDetailsData(
            doctorId: MySharedPreferences.id.toString(), context: context);
        AppConstants()
            .showMsgToast(context, msg: AppConstants.addedSuccessfully);
        update();
        Loader.hide();
      } else {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
      }
    } catch (error) {
      createCertificateModel!.msg == ''
          ? AppConstants()
              .showMsgToast(context, msg: AppConstants.failedMessage)
          : AppConstants()
              .showMsgToast(context, msg: createCertificateModel!.msg!);
      Loader.hide();
    }
  }
}
///// DONE BY DOING NOTHING
//   Future createStudies({
//     required BuildContext context,
//     required File image,
//   }) async {
//     AppConstants.showLoading(context);
//     try {
//       createStudiesModel = await DoctorDetailsApi.createStudies(image: image);
//       if (createStudiesModel == null) {
//         AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
//         Loader.hide();
//         return;
//       }
//       if (createStudiesModel!.code == 200) {
//         fetchDoctorDetailsData(
//             doctorId: MySharedPreferences.id.toString(), context: context);
//         AppConstants()
//             .showMsgToast(context, msg: AppConstants.addedSuccessfully);
//       } else {
//         AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
//         Loader.hide();
//       }
//     } catch (error) {
//       createStudiesModel!.msg == ''
//           ? AppConstants()
//               .showMsgToast(context, msg: AppConstants.failedMessage)
//           : AppConstants().showMsgToast(context, msg: createStudiesModel!.msg!);
//       Loader.hide();
//     }
//
//     Loader.hide();
//   }
//
//   /// DONE BY DOING NOTHING
//
