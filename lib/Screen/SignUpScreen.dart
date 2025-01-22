import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/LoginPage.dart';
import 'package:schoolnot/services/myclient.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
String? selectedRole;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();






  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // nameController.text='mhd5434';
    // emailController.text='tpoep00@gmail.com';
    // phoneController.text='09976466987';
    // addressController.text='دمشق';
    // passwordController.text='Aa122122';
    //
    // confirmPasswordController.text='Aa122122';
    //

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            // الخلفية الاحترافية
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // أشكال هندسية
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إنشاء حساب جديد',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      // الاسم
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'الاسم الكامل',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال الاسم الكامل' : null,
                      ),

                      SizedBox(height: 16),
                      // البريد الإلكتروني
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        !GetUtils.isEmail(value!) ? 'البريد الإلكتروني غير صالح' : null,
                      ),
                      SizedBox(height: 16),
                      // كلمة المرور
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        value!.length < 6 ? 'يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل' : null,
                      ),
                      SizedBox(height: 16),
                      // تأكيد كلمة المرور
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'تأكيد كلمة المرور',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        value != passwordController.text ? 'كلمتا المرور غير متطابقتين' : null,
                      ),
                      SizedBox(height: 24),
                      // الهاتف
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'الهاتف',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال الهاتف' : null,
                      ),
                      SizedBox(height: 24),
                      // العنوان
                      TextFormField(
                        style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'العنوان',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.location_on_outlined, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال العنوان' : null,
                      ),
                      SizedBox(height: 24),
                      // زر إنشاء حساب
                      SizedBox(height: 16),
                      // القائمة المنسدلة لاختيار الدور
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

                        },
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              myclient().registerUser(
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                addressController.text,
                         selectedRole.toString()     );
                            }
                            myclient.saveperf(phoneController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'إنشاء حساب',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // رابط تسجيل الدخول
                      Center(
                        child: TextButton(
                          onPressed: () {
      Get.to(LoginPage()); // العودة إلى شاشة تسجيل الدخول
                          },
                          child: Text(
                            'لديك حساب بالفعل؟ قم بتسجيل الدخول',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
