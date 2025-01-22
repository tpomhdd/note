import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/SignUpScreen.dart';
import 'package:schoolnot/services/myclient.dart';
import '../Controller/LoginController.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
 String? selectedRole;
  @override
  Widget build(BuildContext context) {
    myclient.checkNoebook(context);
    myclient.checkrool(context);
myclient.checkroolteacher(context);
    //controller.phoneController.text='1';
    return Scaffold(
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600], // تأثير التدرج الأزرق
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.lock, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'تسجيل الدخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // النص باللون الأبيض
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    labelText: 'الهاتف',
                    labelStyle: TextStyle(color: Colors.white), // اللون الأبيض للتسمية
                    hintText: 'أدخل رقم هاتفك',
                    hintStyle: TextStyle(color: Colors.white70), // اللون الفاتح للتلميح
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0), // حواف ناعمة
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.phone, color: Colors.white),
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white), // النص باللون الأبيض
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: 'اختر نوع الحساب',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: ['طالب', 'معلم']
                      .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  ))
                      .toList(),
                  onChanged: (value) {
                    selectedRole=value;
                    controller.type=selectedRole.toString() ;


                  },
                ),
                Obx(() => ElevatedButton(

                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    myclient.saverol(selectedRole.toString());
                    controller.login();
                  },
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('تسجيل الدخول', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade500, // اللون الأزرق المعتاد
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // حواف ناعمة
                    ),
                    elevation: 5, // تأثير الظل
                  ),
                )),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(SignUpScreen()); // العودة إلى شاشة التسجيل
                    },
                    child: Text(
                      'ليس لديك حساب؟ انشئ حساب جديد',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

