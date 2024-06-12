import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myapp/image_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: false,
      ),
      themeMode: ThemeMode.dark,
      title: 'GetItGirl',
      builder: EasyLoading.init(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'GetItGirl',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await imageController.getImage();
                    },
                    child: const Text('Upload Image'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await imageController.saveImage();
                    },
                    child: const Text('Save in Firebase'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (imageController.imageURL.value != "") {
                  if (kIsWeb) {
                    return Image.network(
                      imageController.imageURL.value,
                      width: 230,
                      height: 230,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image.file(
                    File(imageController.imageURL.value),
                    width: 230,
                    height: 230,
                    fit: BoxFit.cover,
                  );
                }
                return Image.asset(
                  'images/placeholder-image.png',
                  width: 230,
                  height: 230,
                  fit: BoxFit.cover,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
