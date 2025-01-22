import 'package:flutter/material.dart';
import '../services/phone_auth_controller.dart'; // تأكد من أنك قد أضفت الكلاس PhoneAuthController هنا

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final PhoneAuthController _controller = PhoneAuthController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول برقم الهاتف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // إدخال رقم الهاتف
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),

            // زر إرسال رمز التحقق
            ElevatedButton(
              onPressed: () {
                final phoneNumber = _phoneController.text.trim();
                if (phoneNumber.isNotEmpty) {
                  _controller.sendOtp(
                    phoneNumber: phoneNumber,
                    context: context,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('يرجى إدخال رقم الهاتف.')));
                }
              },
              child: Text('إرسال رمز التحقق'),
            ),
            SizedBox(height: 16),

            // إدخال رمز التحقق
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'رمز التحقق',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // زر التحقق من الرمز
            ElevatedButton(
              onPressed: () {
                final smsCode = _otpController.text.trim();
                if (smsCode.isNotEmpty) {
                  _controller.verifyOtp(
                    smsCode: smsCode,
                    context: context,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('يرجى إدخال رمز التحقق.')));
                }
              },
              child: Text('تأكيد تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
