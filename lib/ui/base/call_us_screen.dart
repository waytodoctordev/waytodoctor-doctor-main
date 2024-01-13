import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/drawer/call_us_api.dart';
import '../../utils/colors.dart';
import '../../utils/icons.dart';
import '../../utils/shared_prefrences.dart';
import '../screens/registration/widgets/prefix_icon.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';


class CallUsScreen extends StatefulWidget {
  const CallUsScreen({Key? key}) : super(key: key);

  @override
  State<CallUsScreen> createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  late TextEditingController userNameCtrl;
  late TextEditingController phoneNumberCtrl;
  late TextEditingController messageCtrl;

  late TextEditingController emailCtrl;

  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userNameCtrl = TextEditingController();
    phoneNumberCtrl = TextEditingController();
    messageCtrl = TextEditingController();
    emailCtrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    userNameCtrl.dispose();
    phoneNumberCtrl.dispose();
    messageCtrl.dispose();
    emailCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: MySharedPreferences.language == 'ar'
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(270 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                )
              : RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                ),
        ),
        leadingWidth: 80,
        title: Text(
          'contact us'.tr,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'We are here for you! How can we help?'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: MyColors.blue14B,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  // physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  children: [
                    FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 150),
                      child: CustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: userNameCtrl,
                        hintText: 'Username'.tr,
                        horizontalPadding: 10,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username".tr;
                          }
                          if (value.length < 4) {
                            return 'Username too short'.tr;
                          }
                          return null;
                        },
                        prefixIcon: const CustomPrefixIcon(icon: MyIcons.user),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 300),
                      child: CustomTextField(
                        textInputAction: TextInputAction.next,
                        horizontalPadding: 10,
                        controller: emailCtrl,
                        hintText: 'Email'.tr,
                        validator: (value) {
                          String pattern =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$";
                          RegExp regex = RegExp(pattern);
                          if (value!.isEmpty) {
                            return "Enter your email".tr;
                          }
                          if (!regex.hasMatch(value)) {
                            return "Please enter a valid email address".tr;
                          }
                          return null;
                        },
                        prefixIcon: const CustomPrefixIcon(icon: MyIcons.att),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 150),
                      child: CustomTextField(
                        horizontalPadding: 10,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              MySharedPreferences.countryDigits),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: phoneNumberCtrl,
                        // keyboardType: TextInputType.number,
                        hintText: 'Phone number'.tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter phone number".tr;
                          }
                          if (value.length < 9) {
                            return "The phone number is too short.".tr;
                          }
                          return null;
                        },
                        prefixIcon: const CustomPrefixIcon(icon: MyIcons.call),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 150),
                      child: CustomTextField(
                        horizontalPadding: 20,
                        textInputAction: TextInputAction.done,
                        controller: messageCtrl,
                        maxLines: 7,
                        hintText: 'Write your message'.tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "".tr;
                          }
                          if (value.length < 9) {
                            return "".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30,),
                        Text('You Can Call Us By This Information'.tr,style: const TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        /// ADDRESS
                        SizedBox(
                          height: 35,
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                             leading: Text('${'Address'.tr}:',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              title: Text('Jordan, Amman, Jabal Al-Hussein, Adel Al-Qasem Complex, 3rd Floor, Office 307'.tr,style: TextStyle(fontSize: 14),)
                          ),
                        ),
                        /// PHONE NUMBER
                        SizedBox(
                          height: 30,
                          child: ListTile(
                              onTap: ()=> launchUrl(Uri.parse('tel:+962790314103')),
                              titleAlignment: ListTileTitleAlignment.center,
                            leading:  Text('${'Phone number'.tr}:',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                             title: const Text('+962790314103',style: TextStyle(fontSize: 14,color: Colors.blue,  decoration: TextDecoration.underline,),)

                          ),
                        ),
                        /// PHONE NUMBER
                        SizedBox(
                          height: 30,
                          child: ListTile(
                              onTap: ()=>launchUrl(Uri.parse('tel:+96262221166')),
                              titleAlignment: ListTileTitleAlignment.center,
                             leading: Text('${'Phone number'.tr}:',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              title:const Text('+96262221166',style: TextStyle(fontSize: 14,color: Colors.blue,  decoration: TextDecoration.underline,))

                          ),
                        ),
                        /// EMAIL
                        SizedBox(
                          height: 40,
                          child: ListTile(
                            onTap: ()=> launchUrl(Uri.parse('mailto:info@waytodoctor.net')),
                              titleAlignment: ListTileTitleAlignment.center,
                             leading: Text('${'Email'.tr}:',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            title:  const Text('info@waytodoctor.net',style: TextStyle(fontSize: 14,color: Colors.blue,  decoration: TextDecoration.underline,))
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(

        height: Get.height*.07,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
        child: CustomElevatedButton(
          width: double.maxFinite,
          height: 56,
          title: 'Send'.tr,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              SendEmailApi.sendEmailData(
                name: userNameCtrl.text,
                email: emailCtrl.text,
                subject: 'Message From ${MySharedPreferences.fName}',
                message: messageCtrl.text,
                context: context,
              );
            }
          },
          color: MyColors.blue14B,
        ),
      ),
    );
  }
}
