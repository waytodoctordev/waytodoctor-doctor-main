import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

import '../../../../../../utils/shared_prefrences.dart';

class MedicalHistoryContentsComponents extends StatelessWidget {
  final List<DoctorDescription?> description;
  final String title;

  const MedicalHistoryContentsComponents({
    super.key,
    required this.description, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: MyColors.blue14B,
              radius: 12,
              child: SvgPicture.asset(
                MyIcons.clip,
                height: 10,
                width: 10,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title??'prescription'.tr,
                style: const TextStyle(
                  color: MyColors.blue14B,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        description.isEmpty
            ? SizedBox(
                height: 40,
                child: Text(AppConstants.noItems),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 10),
                itemCount: description.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                            '${ApiUrl.mainUrl}/${description[index]!.file}'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.fillColor,
                          borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${'Time'.tr} :',style: const TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text(DateFormat.yMMMMEEEEd(MySharedPreferences.language).format(description[index]!.date!).toString(),
                        // controller.pickedFiles[index].toString().split('/').last,
                        style: const TextStyle(
                          color: MyColors.textColor,
                          fontSize: 14,
                          // fontWeight: FontWeight.w600,
                        )),
                      ]
                          ),
                          const SizedBox(height: 10,),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${'prescription'.tr} :',style: const TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(height: 5,),
                                Text(description[index]!.content!.toString(),
                                    // controller.pickedFiles[index].toString().split('/').last,
                                    style: const TextStyle(
                                      color: MyColors.textColor,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w600,
                                    )),
                              ]
                          ),
                          if(description[index]!.file != null)  const SizedBox(height: 10,),
                          if(description[index]!.file != null)  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${'File'.tr} :',style: const TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(height: 5,),
                                Text(description[index]!.file.toString().split('/').last,
                                    // controller.pickedFiles[index].toString().split('/').last,

                                    style: const TextStyle(
                                      decoration: TextDecoration.underline, color: Colors.blue,
                                      fontSize: 14,

                                      // fontWeight: FontWeight.w600,
                                    )),
                              ]
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
      ],
    );
  }
}
