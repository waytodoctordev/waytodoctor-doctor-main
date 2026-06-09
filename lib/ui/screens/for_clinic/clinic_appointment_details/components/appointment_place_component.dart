import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

import '../../../../../utils/shared_prefrences.dart';

class PlaceComponent extends StatefulWidget {
  final String place;
  final String paymentMethod;

  const PlaceComponent({
    super.key,
    required this.place,
    required this.paymentMethod,
  });

  @override
  State<PlaceComponent> createState() => PlaceComponentState();
}

class PlaceComponentState extends State<PlaceComponent> {
  @override
  void initState() {
    ClinincAppointmentsDetailsCtrl.find.placeCtrl =
        TextEditingController(text: widget.place.tr);
    ClinincAppointmentsDetailsCtrl.find.paymentMethodCtrl =
        TextEditingController(text: widget.paymentMethod);
    ClinincAppointmentsDetailsCtrl.find.place = widget.place;
    ClinincAppointmentsDetailsCtrl.find.paymentMethod = widget.paymentMethod;
    super.initState();
  }

  @override
  void dispose() {
    ClinincAppointmentsDetailsCtrl.find.placeCtrl.dispose();
    ClinincAppointmentsDetailsCtrl.find.paymentMethodCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Place : '.tr,
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.blue14B,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        CustomTextField(
          hintText: ClinincAppointmentsDetailsCtrl.find.placeCtrl.text,
          controller: ClinincAppointmentsDetailsCtrl.find.placeCtrl,
          horizontalPadding: 20,
        ),
        const SizedBox(height: 10),
        Text(
          MySharedPreferences.language == 'ar'
              ? 'نوع الدفع : '
              : 'Payment mothod : ',
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.blue14B,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        CustomTextField(
          hintText: ClinincAppointmentsDetailsCtrl.find.paymentMethodCtrl.text,
          controller: ClinincAppointmentsDetailsCtrl.find.paymentMethodCtrl,
          horizontalPadding: 20,
        ),
        // RichText(
        //   text: TextSpan(
        //     children: <TextSpan>[
        //       TextSpan(
        //         text: MySharedPreferences.language == 'ar'
        //             ? 'نوع الدفع : '
        //             : 'Payment mothod : ',
        //         style: GoogleFonts.tajawal(
        //           fontSize: 16,
        //           color: MyColors.blue14B,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       TextSpan(
        //         text: widget.paymentMethod == ''
        //             ? AppConstants.noItems
        //             : widget.paymentMethod,
        //         style: GoogleFonts.tajawal(
        //             fontSize: 14, color: MyColors.textColor),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
