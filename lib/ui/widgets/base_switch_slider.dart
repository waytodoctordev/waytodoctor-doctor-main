import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

import '../../controller/for_doctor/doctor_home_screen/edit_accountr_ctrl.dart';

class BaseSwitchSlider extends StatefulWidget {
  final String title1;
  final String title2;
  final bool isFirst;

  final Color color;
  final Color buttonColor;
  final Color textColor1;
  final Color textColor2;
  final EdgeInsetsGeometry margin;


  const BaseSwitchSlider({
    Key? key,
    required this.title1,
    required this.title2,

    required this.isFirst,
    required this.color,
    required this.margin,
    this.buttonColor = MyColors.primary,
    this.textColor1 = MyColors.red,
    this.textColor2 = MyColors.red,
  }) : super(key: key);

  @override
  State<BaseSwitchSlider> createState() => _BaseSwitchSliderState();
}

class _BaseSwitchSliderState extends State<BaseSwitchSlider> {
  EditAccountCtrl controller = Get.find<EditAccountCtrl>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin,
      width: double.infinity,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: widget.color,
      ),
      child:  Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.height*.020),// Get.height/50
            child: AnimatedAlign(
              alignment:    widget.isFirst ?  Alignment.centerLeft :Alignment.centerRight ,// const Alignment(1, 0),
              // widget.isFirst ? const Alignment(-1, 0) : const Alignment(1, 0),
              duration: const Duration(milliseconds: 750),
              curve: Curves.fastOutSlowIn,
              child: CustomElevatedButton(
                width: 140,
                title: "",
                onPressed: () {},
                color: widget.buttonColor,
              ),
            ),
          ),
          Row(
            children: [
              buildField(widget.title1, widget.textColor1,0),
              const SizedBox(width: 20),
              buildField(widget.title2, widget.textColor2,1,type: false),

            ],
          ),
        ],
      ),
    );
  }

  Widget buildField(String title,  Color textColor,int index, {bool type = true}) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(
                () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.isPersonalInformation = type;
              if(controller.pageCtrl.hasClients){
                controller.pageCtrl.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastOutSlowIn,
                );}
            },
          );
        },//onTap(),
        // color: Colors.transparent,
        // alignment: Alignment.center,
        child: Container(
          // margin:const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(2.1),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
