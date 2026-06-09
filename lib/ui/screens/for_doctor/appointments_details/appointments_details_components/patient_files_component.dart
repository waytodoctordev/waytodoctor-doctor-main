import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class PatientFilesComponents extends StatelessWidget {
  final List<FileElement> attachedFiles;
  const PatientFilesComponents({super.key, required this.attachedFiles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
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
                  'attached files'.tr,
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
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: attachedFiles.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                          '${ApiUrl.mainUrl}/${attachedFiles[index].file}'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColors.fillColor,
                        borderRadius: BorderRadius.circular(18)),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      attachedFiles[index].file.toString().split('/').last,
                      style: const TextStyle(
                        color: MyColors.textColor,
                        fontSize: 14,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
