// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:schoolnot/Screen/LoginPage.dart';
// import 'package:schoolnot/services/myclient.dart';
//
//
// class SignUpScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   String? selectedRole;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // خلفية وشكل هندسي
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blueAccent, Colors.deepPurple],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: -100,
//               left: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(150),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -100,
//               child: Container(
//                 width: 350,
//                 height: 350,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(150),
//                 ),
//               ),
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'إنشاء حساب جديد',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       SizedBox(height: 20),
//                       // حقول الإدخال الأخرى
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           labelText: 'الاسم الكامل',
//                           labelStyle: TextStyle(color: Colors.white),
//                           prefixIcon: Icon(Icons.person, color: Colors.white),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                         ),
//                         validator: (value) =>
//                         value!.isEmpty ? 'الرجاء إدخال الاسم الكامل' : null,
//                       ),
//                       SizedBox(height: 16),
//                       // ... بقية الحقول هنا ...
//                       // رقم الهاتف
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: phoneController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           labelText: 'الهاتف',
//                           labelStyle: TextStyle(color: Colors.white),
//                           prefixIcon: Icon(Icons.phone, color: Colors.white),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                         ),
//                         validator: (value) =>
//                         value!.isEmpty ? 'الرجاء إدخال الهاتف' : null,
//                       ),
//                       SizedBox(height: 24),
//                       // زر إنشاء حساب
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             // التحقق من الهاتف عبر Firebase
//                             await FirebaseAuth.instance.verifyPhoneNumber(
//                               phoneNumber: phoneController.text,
//                               verificationCompleted: (PhoneAuthCredential credential) async {
//                                 // إذا تم التحقق بنجاح
//                                 await FirebaseAuth.instance.signInWithCredential(credential);
//                                 // تسجيل المستخدم في قاعدة البيانات أو أي إجراءات أخرى
//                                 myclient().registerUser(
//                                   nameController.text,
//                                   emailController.text,
//                                   phoneController.text,
//                                   addressController.text,
//                                   selectedRole.toString(),
//                                 );
//                                 myclient.saveperf(phoneController.text);
//                               },
//                               verificationFailed: (FirebaseAuthException e) {
//                                 // إذا فشل التحقق
//                                 Get.snackbar('فشل التحقق', 'لم يتمكن من إرسال الرمز: ${e.message}');
//                               },
//                               codeSent: (String verificationId, int? resendToken) {
//                                 // يمكنك حفظ verificationId هنا لإدخال الرمز في خطوة لاحقة
//                                 // بعد إرسال الرمز
//                                 // قم بإظهار حوار لإدخال الرمز من المستخدم
//                                 Get.dialog(
//                                   AlertDialog(
//                                     title: Text('أدخل رمز التحقق'),
//                                     content: TextField(
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(hintText: 'أدخل الرمز'),
//                                       onChanged: (value) {
//                                         // حفظ الرمز المدخل
//                                       },
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           // Get the entered SMS code from the user
//                                           String smsCode = '985678';
//
//                                           // Sign in with the phone number verification
//                                           FirebaseAuth.instance
//                                               .signInWithCredential(PhoneAuthProvider.credential(
//                                               verificationId: verificationId, smsCode: smsCode))
//                                               .then((value) {
//                                             // After verifying the code, proceed with the rest of your actions
//                                             // For example, create a user account or perform other tasks
//                                           });
//                                           Get.back();
//                                         },
//                                         child: Text('تأكيد'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                               codeAutoRetrievalTimeout: (String verificationId) {
//                                 // عندما ينتهي وقت التحقق التلقائي
//                               },
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                         ),
//                         child: Text(
//                           'إنشاء حساب',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       // رابط تسجيل الدخول
//                       Center(
//                         child: TextButton(
//                           onPressed: () {
//                             Get.to(LoginPage()); // العودة إلى شاشة تسجيل الدخول
//                           },
//                           child: Text(
//                             'لديك حساب بالفعل؟ قم بتسجيل الدخول',
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
