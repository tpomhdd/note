import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/FrameSelectionPage.dart';
import 'package:schoolnot/Screen/AddClass.dart';
import 'package:schoolnot/Screen/BarcodeSlider.dart';
import 'package:schoolnot/Screen/LoginPage.dart';
import 'package:schoolnot/Screen/NotebookReader.dart';
import 'package:schoolnot/Screen/Notebook_Barcodes.dart';
import 'package:schoolnot/Screen/NotebooksScreen.dart';
import 'package:schoolnot/Screen/Pages.dart';
import 'package:schoolnot/Screen/PhoneAuthScreen.dart';
import 'package:schoolnot/Screen/SignUpScreen.dart';
import 'package:schoolnot/Screen/UploadAssignmentPage.dart';
import 'package:schoolnot/Screen/UploadImagePage.dart';
import 'package:schoolnot/Screen/testbarcode.dart';
import 'package:schoolnot/teacher/AddContent.dart';
import 'package:schoolnot/teacher/add_sections.dart';
import 'package:schoolnot/teacher/getNotebookall.dart';
import 'package:schoolnot/teacher/index.dart';
import 'package:schoolnot/teacher/index2.dart';

import 'Screen/NotebookCustomizationScreen.dart';
import 'Screen/NotebookPage.dart';
import 'Screen/PageView.dart';
import 'Screen/assignment.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  //FirebaseMessaging.onMessageOpenedApp;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home:LoginPage()
      //FrameSelectionPage(onFrameSelected: () {  Get.off(() => NotebookPage());},),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

