import 'dart:convert';
import 'package:schoolnot/Screen/NotebookCustomizationScreen.dart';
import 'package:schoolnot/services/myclient.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/NotebookPage.dart';
import 'package:schoolnot/cpre/AppUrl.dart';
import 'package:schoolnot/teacher/index2.dart';

class MyClient {
  Future<void> login(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6IlJSL1ZwejRPNWU3eFhPT3c2N0FZN2c9PSIsInZhbHVlIjoia1lubWdyZUlwODRqbmc5Y3VFckNJbk1KVjdhTHhMT0hWMXBoYytGaFRwL3Y3Y1JXQ095ODZpU0w3eGlyYzVGTnBIaXhTbjQzKzZXWGNQYUZMRmhucjMzVmMyZjJXOXAvS25uNnhScVR5THNOcC9GMkxHelprcndwdk9pUldtK0ciLCJtYWMiOiJhN2JhYzFiN2EzZmUxZGRmMTY5ZGI2YzYxNDhjZDQ0OTA3OGVmODFlYjlhYzFkODY3MjZhMjNiM2M4YmQ1ODQwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkprdVplbEVveEp5eEpGNzR1V0JBYVE9PSIsInZhbHVlIjoiWW8vZURvc0tlbVFxTEl1SXZHeDQ1SlBMaE52Zzg4V3I2a0RBNXF3RVBqZVlHNklwMnBoTnBZNHdQVCs0YVQ5MXVyU2s3eFJDQ0VZMG50bWl4L1JqSDNUQnNQd1FzUDJBOUZiSjhmaFp1b0VMRHZDeVdOR2pnZmhPUXZ5V1N2WFgiLCJtYWMiOiI5MTdkNzUxNThmNzM4NzU3MzJkMWQ2NzI3YTI1NzgxZTM2NWM0NDhlZDJmOGUzODlkZjY4YWEwMTBjOGZjMWRmIiwidGFnIjoiIn0%3D'
    };

    var request = http.Request(
      'POST',
      Uri.parse('https://schoolnot.tpowep.com/login/'),
    );

    request.body = '''
    {
      "email": "$email",
      "password": "$password"
    }
    ''';

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
print(response.statusCode.toString());
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح!',
            snackPosition: SnackPosition.BOTTOM);

        print(responseBody);
      } else {
        Get.snackbar('خطأ', 'فشل تسجيل الدخول: ${response.reasonPhrase}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء تسجيل الدخول: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  late String type;  // تحويل المتغير إلى Observable حتى يمكن تحديثه تلقائيًا
  var isLoading = false.obs;
  final myClient = MyClient();



      Future<void> login() async {
        var url = Uri.parse('${AppUrl.url}/login.php');
print('object========='+phoneController.text);
        // إرسال طلب POST باستخدام http
        var response = await http.post(
          url,
          body: {'phone': phoneController.text},
        );

        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          if (result == "Login") {
            myclient.saveperf(phoneController.text);



            if (type == 'طالب') {
              Get.to(() => NotebookCustomizationScreen());
            } else {
              Get.to(() =>
                  teacher());
            }
          print(type);}
          else
          if (result == "No Login")
            Get.defaultDialog(content: Text('لم يتم تسجيل الدخول'));


          print(result); // سيتم طباعة الاستجابة من الـ API
        } else {
          print('Error: ${response.statusCode}');
        }
      }      }

