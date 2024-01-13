import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class ComunicationComponent extends StatefulWidget {
  final String communication;

  const ComunicationComponent({
    super.key,
    required this.communication,
  });

  @override
  State<ComunicationComponent> createState() => _ComunicationComponentState();
}

class _ComunicationComponentState extends State<ComunicationComponent> {
  @override
  void initState() {
    ClinincAppointmentsDetailsCtrl.find.currentCommunication = widget.communication.tr;
    ClinincAppointmentsDetailsCtrl.find.currentCommunicationEnglish = widget.communication;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communication : '.tr,
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.blue14B,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: MyColors.fillColor,
            borderRadius: BorderRadius.circular(26),
          ),
          child: GetBuilder<ClinincAppointmentsDetailsCtrl>(
            builder: (controller) => DropdownButton(
              borderRadius: BorderRadius.circular(26),
              underline: const SizedBox(),
              value: controller.currentCommunication,
              style: const TextStyle(
                fontSize: 14,
                color: MyColors.textColor,
              ),
              itemHeight: 60,
              alignment: Alignment.center,
              isExpanded: true,
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  MyIcons.angleSmallRight,
                  height: 7,
                  width: 14,
                  color: MyColors.blue14B,
                ),
              ),
              elevation: 1,
              items: controller.communicationTypes.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        items,
                        style: GoogleFonts.tajawal(
                          fontSize: 16,
                          color: MyColors.textColor,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (String? newValue) {
                controller.setCommunication(newValue.toString());
              },
            ),
          ),
        )
      ],
    );
  }
}
