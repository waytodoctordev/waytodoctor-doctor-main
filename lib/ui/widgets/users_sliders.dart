import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

import '../../controller/registration/sign_in_ctrl.dart';

class UsersSliders extends StatefulWidget {
  SignInCtrl signInCtrl = Get.find<SignInCtrl>();
  final int i0 =0;
  final int i1 =1;
  final int i2 =2;


  PageController? pageCtrl;



  UsersSliders({
    Key? key,
    this.pageCtrl,
  }) : super(key: key);

  @override
  State<UsersSliders> createState() => _UsersSlidersState();
}

class _UsersSlidersState extends State<UsersSliders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
      width: double.infinity,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          buildField('Doctor'.tr, widget.i0,),
          const SizedBox(width: 20),
          buildField('Clinic'.tr,  widget.i1,clicked:false),
          const SizedBox(width: 20),
          buildField('Center'.tr, widget.i2,),
        ],
      ),
    );
  }

  Widget buildField(String title, int index ,{bool clicked=true}) {
    return Expanded(
      child: AnimatedAlign(
        alignment: false? const Alignment(-1, 0) : const Alignment(1, 0),
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInExpo,
        child: FadeInDown(
          from: 10,
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 150),
          child: Container(
            height: Get.height*.05,
            decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(24),
                color: widget.signInCtrl.activeButton.value=='button$index'
                    ? MyColors.blue14B
                    : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: (){
                setState(
                      () {
                        widget.signInCtrl.activeButton.value='button$index';
                        FocusManager.instance.primaryFocus?.unfocus();
                        widget.signInCtrl.signInVar.value = clicked;
                        widget.pageCtrl?.animateToPage(index,
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn,
                    );
                  },
                );
              },
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, color: widget.signInCtrl.activeButton.value=='button$index'
                      ? MyColors.white
                      : MyColors.blue14B ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
