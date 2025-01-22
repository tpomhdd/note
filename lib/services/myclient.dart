import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:schoolnot/Screen/LoadingPage.dart';
import 'package:schoolnot/Screen/NotePage.dart';
import 'package:schoolnot/Screen/NotebookCustomizationScreen.dart';
import 'package:schoolnot/Screen/NotebookPage.dart';
import 'package:schoolnot/Screen/NotebookReader.dart';
import 'package:schoolnot/Screen/NotebooksScreen.dart';
import 'package:schoolnot/teacher/index.dart';
import 'package:schoolnot/teacher/index2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FrameSelectionPage.dart';

class myclient {
  String servUrl = 'https://schoolnot.tpowep.com';
  // إرسال الرمز عبر الهاتف (محاكاة)
  Future<void> sendOtp({required String phoneNumber, required BuildContext context}) async {
    try {
      // هنا نستخدم محاكاة لإرسال رمز التحقق
      print("تم إرسال OTP إلى الرقم $phoneNumber");

      // يمكنك هنا إرسال طلب HTTP إلى الخادم لطلب إرسال OTP عبر SMS
      // يمكن استبدال هذا بمحاكاة أو API حقيقية
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء إرسال الرمز')));
    }
  }

  // التحقق من الرمز المرسل (محاكاة)
  Future<void> verifyOtp({required String smsCode, required BuildContext context}) async {
    try {
      // محاكاة للتحقق من الرمز
      // في هذا المثال، الرمز الصحيح هو "123456"
      if (smsCode == "123456") {
        // رمز صحيح
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم التحقق بنجاح')));
        // هنا يمكنك الانتقال إلى الشاشة التالية أو أي إجراء آخر
      } else {
        // رمز خاطئ
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('رمز التحقق غير صحيح')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء التحقق من الرمز')));
    }
  }

  static checkNoebook(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notebook = prefs.getString('notebook'); // قراءة القيمة
    if (notebook != null) {
      // إذا كانت القيمة موجودة، انتقل إلى الصفحة التالية
Get.to(Get.off(LoadingPage(nextPage:NotebooksScreen(phoneNumber: '099'))));

    // إذا لم تكن القيمة موجودة، يبقى في الصفحة الحال}
}}

  static checkrool(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rol = prefs.getString('rol'); // قراءة القيمة
    if (rol == "طالب") {
      Get.to(NotebooksScreen(phoneNumber: 'phoneNumber'));
}
  else if(rol=="معلم")
    {
      Get.to(teacher());

    }else {

    }
  }
  static checkroolteacher(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rol = prefs.getString('rol'); // قراءة القيمة
    if (rol == "معلم"&&rol!=null) {
      Get.to(teacher());
}


  }

  static saveperf(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", username);
    print(sharedPreferences.get("username"));
  }
  static saverol(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("rol", username);
    print(sharedPreferences.get("rol"));
  }
  static saveid(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", id);
    print(sharedPreferences.get("id"));
  }

  static notebook(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("notebook", username);
    print(sharedPreferences.get("notebook"));
  }
Future<void> addcontent() async {
  var headers = {
    'Content-Type': 'text/plain'
  };
  var request = http.Request('POST', Uri.parse('https://schoolnot.tpowep.com/api/contentsapi'));
  request.body = '''{\r\n\'barcode_id\' : \'test\',\r\n\'content_type\' : \'test\',\r\n \'class_id\' : \'2\',\r\n\'section_id\' : \'2\',\r\n\'content_url\' : \'ww\',\r\n \'subject_id\' : \'2\',\r\n }\r\n\r\n\r\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }

}
  Future<void> registerUser(String name, String email, String phone,
      String address, String type) async {
    var headers = {
      'Key': ' Content-Type  ',
      'Value': ' application/json',
      'Content-Type': 'text/plain',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImIrcW1Ma2FBeEtMVi9iVlpOdVFoUEE9PSIsInZhbHVlIjoicHRxcG5PR2FZamt3a0RkV3VzcUVTRHUyelJoVUxMeFJXR1dlcE0yVHVDMndsVE50QVVkNDcreG5RbWxaaFRlNWszZTU1a2JZRXppVmtKVTVYdUEzTEhxRy9SQmk3ZzBuT0haS013QjNPOTI5dUQxeXpPclVUU0xqdzVZUWhWN00iLCJtYWMiOiJlOTY0Yzg0NDk1NjY0MWEwZjJhMTZjODRjNjg0NTcwMWQ4MzBhZTk0ZTI0Y2ZmMWIyNmM4YjJjMDEwYzk1ZjE1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImpCOERWeUdCV2tGb1NxVlJDbW0xQnc9PSIsInZhbHVlIjoic08xbXJPbU5SOURFVlZJLzJrei96WFpRZU9jdzVWVTh6eHNZT3ZDNjVsQTNHcW92NFFra1VDUHU1ZEJDM3NoVlRIamN4NWZHU3ZPOFZVaHVVUnl4QmtncWplUHUwanV3d2tvS1BpcGpHb0FMa3JBa3FHZVgrbzdEWS9rT29lMmEiLCJtYWMiOiIwNmU0Yzk1ZmJlMjU0NTQ5MTAwNTI0NjM4ODdjYzJhMmYwMmUwOTE3MTRmNzJjZGJkOTkwMjFkM2ZiZGFjMjA2IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://schoolnot.tpowep.com/api/members?name=${name}&email=${email}&barcode=1&class_id=1&section_id=1&member_type=${type}&phone=${phone}&address=${address}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    Get.to(NotebookCustomizationScreen());
    if (response.statusCode == 200) {
      Get.snackbar(
        'نجاح',
        'تم تسجيل الحساب بنجاح!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      print(await response.stream.bytesToString());
    } else {
      final error = jsonDecode(response.reasonPhrase.toString());
      Get.snackbar(
        'خطأ',
        error['message'] ?? 'حدث خطأ غير معروف',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

//

Future add_content(String barcode,String type,String urll,String classid,String sectionid,String subject_id) async {

  var response = await http.post(
    Uri.parse("https://tpowep.com/notschoolapi/add_content.php"),
    body: {
      "barcode": barcode,
      "type": type,
      "url": urll,
      "classid": classid,
      "sectionid": sectionid,
      "subject_id": subject_id,
    },
  );
  print(response.body);



}
Future add_sections(String name,String thetetcher,String classs) async {

  var response = await http.post(
    Uri.parse("https://tpowep.com/notschoolapi/add_sections.php"),
    body: {
      "name": name,
      "The_teacher": thetetcher,
      "class": classs,

    },
  );
  print(response.body);



}
  Future Login(String email, String phone) async {
    var headers = {
      'Key': ' Content-Type  ',
      'Value': ' application/json',
      'Content-Type': 'text/plain',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlJSL1ZwejRPNWU3eFhPT3c2N0FZN2c9PSIsInZhbHVlIjoia1lubWdyZUlwODRqbmc5Y3VFckNJbk1KVjdhTHhMT0hWMXBoYytGaFRwL3Y3Y1JXQ095ODZpU0w3eGlyYzVGTnBIaXhTbjQzKzZXWGNQYUZMRmhucjMzVmMyZjJXOXAvS25uNnhScVR5THNOcC9GMkxHelprcndwdk9pUldtK0ciLCJtYWMiOiJhN2JhYzFiN2EzZmUxZGRmMTY5ZGI2YzYxNDhjZDQ0OTA3OGVmODFlYjlhYzFkODY3MjZhMjNiM2M4YmQ1ODQwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkprdVplbEVveEp5eEpGNzR1V0JBYVE9PSIsInZhbHVlIjoiWW8vZURvc0tlbVFxTEl1SXZHeDQ1SlBMaE52Zzg4V3I2a0RBNXF3RVBqZVlHNklwMnBoTnBZNHdQVCs0YVQ5MXVyU2s3eFJDQ0VZMG50bWl4L1JqSDNUQnNQd1FzUDJBOUZiSjhmaFp1b0VMRHZDeVdOR2pnZmhPUXZ5V1N2WFgiLCJtYWMiOiI5MTdkNzUxNThmNzM4NzU3MzJkMWQ2NzI3YTI1NzgxZTM2NWM0NDhlZDJmOGUzODlkZjY4YWEwMTBjOGZjMWRmIiwidGFnIjoiIn0%3D'
    };
    var request =
        http.Request('POST', Uri.parse('https://schoolnot.tpowep.com/login/'));
    request.body =
        '''{\r\n    "email": "${email}",\r\n    "phone": "${phone}"\r\n}\r\n''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  Future add_class() async {
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IksxUmxnc3ozcU5BWnhRRWVGNGdUOFE9PSIsInZhbHVlIjoiUUJrRW5CaE1XUGx4WEV3ZUZUamU1Y3VkaG1OR3Q0ckdITmw3aGFEdTRXc2lkT2N2b3ovRFZ0SDF0RkNGaDBRTW5RQWZ5K0ZVdEI0elJLYW1LdFhwNXRUN29rZk1RUnVybmFBTDJhUFR0QkpwcDh2WnliRHQ5bjdwVnNkR0ExM3QiLCJtYWMiOiI1NzM1ODA5ZjQ3NjljOTlhODhhZjZjMTBmNzg1MjVhNjIzZjBmZTE0MmEwOWY0ZmMwNWRlNWIxZTNmM2NlNDU1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IlpEbWlGNWxXSW00YldsM2VVSk9nU3c9PSIsInZhbHVlIjoiUnFqd2VMaUgySlN3R3pqWkgwNmFYRDZMQ2VWZEpqTS9IUUxXeTBkZ09Ta3FzTnNDMjJidzZZNWQ0VnN3Q0hYTGh1ekM1U09RNW41LzlyYWdQYXBXMGdBejNUL0d3VlIvR3Qvd0xHTVJFV1UyOG1xOU8vbXk1SGR2UkJ1ZFp5NmQiLCJtYWMiOiJmMzBhNWY2MmViNDZmMWFlMWQ0MDQ4ODQ5NjljNzcyNWU1NjE4ZGViOTBlNGUxMWU3OTRiMWI3MDYzNjdhMmMzIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST', Uri.parse('https://schoolnot.tpowep.com/api/classess'));
    request.body =
        '''{\r\n    "name": "أحمد",\r\n    "The_teacher": "sssss",    \r\n}\r\n''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future AddNetbook(String name, String grade, String section, String course,
      String logoUrl, String phone, String token,String Subject,
     String pagecount,String type,String page ) async {
    var data = {
      'name': name,
      'grade': grade,
      'section': section,
      'course': course,
      'logoUrl': logoUrl,
      'phone': phone,
      'token': token,
      'Subject':Subject,
      'page':page,
      'type':type,
      'PAGE_count':page
    };
    Uri url = Uri.parse('https://tpowep.com/notschoolapi/addnotebook.php');

//    var mydata=jsonDecode(data.toString());
    var reesponse = await http.post(url, body: data);
    if (reesponse.statusCode == 200) {
      Get.to(LoadingPage(nextPage: NotebooksScreen(phoneNumber: '',) ));
    } else {
      Get.snackbar('', 'لم تتم الاضافة');
    }
    //var responsebody = jsonDecode(reesponse.body);
    print(reesponse.body.toString());
  }

  Future update_notebook(
      String grade,
      String section,
      String course,
      String Subject,String id) async {
    var data = {
      'id': id,
      'grade': grade,
      'section': section,


      'Subject':Subject,

    };
    Uri url = Uri.parse('https://tpowep.com/notschoolapi/update_notebook.php');

//    var mydata=jsonDecode(data.toString());
    var reesponse = await http.post(url, body: data);
    if (reesponse.statusCode == 200) {
      Get.snackbar('', ' تم التعديل');

      //     Get.to(LoadingPage(nextPage: NotebookPage(id: Subject,)));
    } else {
      Get.snackbar('', 'لم تتم الاضافة');
    }
    //var responsebody = jsonDecode(reesponse.body);
    print(reesponse.body.toString());
  }


  Future<void> assignment(String name, String description, String file, String id,String page,String notebook) async {
    // التحقق من الحقول
    if (name.isEmpty || description.isEmpty || file.isEmpty || id.isEmpty||page.isEmpty) {
      Get.snackbar('خطأ', 'يرجى تعبئة جميع الحقول قبل الإرسال',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    var data = {
      "name": name,
      "description": description,
      "file": file,
      "id": id,
      "page":page,
      "notebook":notebook
    };

    Uri url = Uri.parse('https://tpowep.com/notschoolapi/assignment.php');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: data,
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status'] == 'success') {
          Get.snackbar('نجاح', responseBody['message'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.to(() => LoadingPage(nextPage: NotebooksScreen(phoneNumber: '',),));
        } else {
          Get.snackbar('تمت الاضافة','تمت اضافة الواجب',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black,
              colorText: Colors.white);
        }
      } else {
        print('Response Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

      }
    } catch (e) {
      Get.snackbar('تمت الاضافة','تمت اضافة الواجب',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }


  Future The_teacher(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String username = sharedPreferences.get("username").toString();

    var data = {
      'name': name,
      'The_teacher': username,
    };
    Uri url = Uri.parse('https://tpowep.com/notschoolapi/add_class.php');

//    var mydata=jsonDecode(data.toString());
    var reesponse = await http.post(url, body: data);
    if (reesponse.statusCode == 200) {
//      Get.to(LoadingPage(nextPage: NotebookPage()));
    } else {
      Get.snackbar('', 'لم تتم الاضافة');
    }
    //var responsebody = jsonDecode(reesponse.body);
    print(reesponse.body.toString());
  }
}
