import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/model/center/category_centers.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../controller/for_center/center_ctrl.dart';
import '../../model/categories/categories_model.dart';
import '../../utils/colors.dart';
import '../../utils/icons.dart';

class CategoryCentersComponent extends StatefulWidget {
   CategoryCentersComponent({super.key,});

  @override
  State<CategoryCentersComponent> createState() => _CategoryCentersComponentState();
}

class _CategoryCentersComponentState extends State<CategoryCentersComponent> {
  CenterCtrl centerCtrl = Get.find<CenterCtrl>();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // CenterCtrl.find.getCategoriesCentersList(context: context);
      CenterCtrl.find.getCategoriesList(context: context);
      // CenterCtrl.find.getCategoriesList(context: context);
      // CenterCtrl.find.getCategoriesCentersList(context: context);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   FadeInDown(
      from: 6,
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 150),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: MyColors.fillColor,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Obx(()=>DropdownButton(
          borderRadius: BorderRadius.circular(26),
          underline: const SizedBox(),
          value: centerCtrl.categoriesID.value,//centerCtrl.categoriesID.value
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
          items: centerCtrl.categories?.map(
                (Categories category) {
              return DropdownMenuItem(
                value: category.id,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    category.name.toString(),
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (int?  value) {
            centerCtrl.categoriesID.value = value!;
            MySharedPreferences.isDoctor
                ? print('yes nancy')
                : print('no nancy');

          },

        ),
        ),
      ),
    );
  }
}
//    GetBuilder<CenterCtrl>(builder: (controller) {
//               return Column(
//                 children: [
//                   // CategoriesComponent(),
//                   const SizedBox(height: 5),
//                   // CategoryCentersComponent()
//                   // mapList: centerCtrl.categoryCentersList?.map(
//                   //       (CategoryCentersData center) {
//                   //     return DropdownMenuItem(
//                   //       value: center.id,
//                   //       child: Padding(
//                   //         padding: const EdgeInsets.symmetric(horizontal: 20),
//                   //         child: Text(
//                   //           center.name.toString(),
//                   //           style: GoogleFonts.tajawal(
//                   //             fontSize: 18,
//                   //             color: MyColors.blue14B,
//                   //           ),
//                   //         ),),
//                   //
//                   //     ) ;
//                   //   },
//                   // ).toList()
//                 ],
//               );
//             }),
//             SizedBox(
//                 height: Get.height * .45,
//                 child: Column(
//                   children: [
//                     FadeInDown(
//                       from: 6,
//                       duration: const Duration(milliseconds: 600),
//                       delay: const Duration(milliseconds: 150),
//                       child: CustomTextField(
//                         textInputAction: TextInputAction.next,
//                         readOnly: true,
//                         hintText: 'Centers',
//                         horizontalPadding: 16,
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.transparent,
//                             builder: (BuildContext context) {
//                               return CupertinoActionSheet(
//                                 cancelButton: CupertinoActionSheetAction(
//                                   onPressed: () => Get.back(),
//                                   // isDefaultAction: true,
//                                   child: Text(
//                                     'Cancel'.tr,
//                                     style: GoogleFonts.tajawal(
//                                       fontSize: 16,
//                                       color: MyColors.red,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 actions: [
//                                   SizedBox(
//                                     height: 250,
//                                     child: CupertinoPicker(
//                                       onSelectedItemChanged: (value) {
//                                         centerCtrl.categoriesID.value = value;
//                                         MySharedPreferences.isDoctor
//                                             ? print('yes nancy')
//                                             : print('no nancy');
//
//                                         // controller.getCurrentCountry(controller
//                                         //     .countries![value].name
//                                         //     .toString());
//                                         MySharedPreferences.centerID =
//                                             centerCtrl.categoriesID.value;
//                                         centerCtrl.getCategoriesCentersList(
//                                             // countryId: controller.countries![value].id .toString(),
//                                             context: context);
//                                       },
//                                       itemExtent: 28.0,
//                                       children: centerCtrl.categories!.map(
//                                         (Categories category) {
//                                           return DropdownMenuItem(
//                                             value: category.id,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                               child: Text(
//                                                 category.name.toString(),
//                                                 style: GoogleFonts.tajawal(
//                                                   fontSize: 18,
//                                                   color: MyColors.blue14B,
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ).toList(),
//                                     ),
//                                   ),
//
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         suffixIcon: SvgPicture.asset(
//                           MyIcons.angleSmallRight,
//                           height: 7,
//                           width: 14,
//                           color: MyColors.blue14B,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     FadeInDown(
//                       from: 6,
//                       duration: const Duration(milliseconds: 600),
//                       delay: const Duration(milliseconds: 300),
//                       child: CustomTextField(
//                         textInputAction: TextInputAction.next,
//                         readOnly: true,
//                         hintText: 'currentCity',
//                         horizontalPadding: 16,
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.transparent,
//                             builder: (BuildContext context) {
//                               return CupertinoActionSheet(
//                                 cancelButton:
//                                 CupertinoActionSheetAction(
//                                   onPressed: () => Get.back(),
//                                   // isDefaultAction: true,
//                                   child: Text(
//                                     'Cancel'.tr,
//                                     style: GoogleFonts.tajawal(
//                                       fontSize: 16,
//                                       color: MyColors.red,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 actions: [
//                                   SizedBox(
//                                     height: 250,
//                                     child: CupertinoPicker(
//                                       onSelectedItemChanged:
//                                           (value) {
//                                         // controller.getCurrentCity(
//                                         //   controller.cities![value].name.toString(),
//                                         // );
//                                       },
//                                       itemExtent: 28.0,
//                                       children: centerCtrl
//                                           .categoryCentersList!
//                                           .map(
//                                             (CategoryCentersData
//                                         center) {
//                                           return DropdownMenuItem(
//                                             value: center.id,
//                                             child: Padding(
//                                               padding:
//                                               const EdgeInsets
//                                                   .symmetric(
//                                                   horizontal:
//                                                   20),
//                                               child: Text(
//                                                 center.name
//                                                     .toString(),
//                                                 style: GoogleFonts
//                                                     .tajawal(
//                                                   fontSize: 18,
//                                                   color: MyColors
//                                                       .blue14B,
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ).toList(),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         suffixIcon: SvgPicture.asset(
//                           MyIcons.angleSmallRight,
//                           height: 7,
//                           width: 14,
//                           color: MyColors.blue14B,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),