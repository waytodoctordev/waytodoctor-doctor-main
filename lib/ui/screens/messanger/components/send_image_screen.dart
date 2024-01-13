import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class SendImageScreen extends StatelessWidget {
  final String imagePath;

  const SendImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    File(imagePath),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: 200,
                child: FloatingActionButton.extended(
                  backgroundColor: MyColors.primary,
                  heroTag: 'asf54888',
                  onPressed: () {
                    Get.back(result: 'send');
                  },
                  label: Text(
                    "Send".tr,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
