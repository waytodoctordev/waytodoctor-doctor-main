import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/model/center/category_centers.dart';

import '../../../../controller/for_center/center_ctrl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/shared_prefrences.dart';

class CategoriesComponent extends StatefulWidget {
  List<DropdownMenuItem<int>>? mapList;
   CategoriesComponent({super.key,this.mapList });

  @override
  State<CategoriesComponent> createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {

  CenterCtrl centerCtrl = Get.find<CenterCtrl>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CenterCtrl.find.getCategoriesList(context: context);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  FadeInDown(
      from: 6,
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 150),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: MyColors.fillColor,
            borderRadius: BorderRadius.circular(26),
          ),
          child:DropdownButton(
            borderRadius: BorderRadius.circular(26),
            underline: const SizedBox(),
            value:centerCtrl.centerID.value,
            style: const TextStyle(
              fontSize: 18,
              color: MyColors.blue14B,
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
            items: centerCtrl.categoryCentersList!.map(
                  (CategoryCentersData center) {
                return DropdownMenuItem(
                  value: center.id,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      center.name.toString(),
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: MyColors.blue14B,
                      ),
                    ),),

                );
              },
            ).toList(),
            onChanged: (int?  value) {
              setState(() {
                centerCtrl.centerID.value = value!;
                MySharedPreferences.isDoctor
                    ? print('yes nancy')
                    : print('no nancy');
              });

            },

          ),
      ),
    );

  }
}
