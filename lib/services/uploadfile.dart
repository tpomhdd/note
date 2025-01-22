import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/FrameSelectionPage.dart';
import 'package:schoolnot/Screen/LoadingPage.dart';
import 'package:schoolnot/Screen/NotebooksScreen.dart';

class FileUploadController extends ChangeNotifier {
  File? _selectedFile;
  bool _isUploading = false;
  String? url;

  File? get selectedFile => _selectedFile;
  bool get isUploading => _isUploading;

  // اختيار أي ملف من الجهاز
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectedFile = File(result.files.single.path!);
      notifyListeners();
    } else {
      print('❌ لم يتم اختيار أي ملف');
    }
  }

  // رفع الملف إلى السيرفر
  Future<String> uploadFile() async {
    if (_selectedFile == null) {
      return '❌ يرجى اختيار ملف أولاً';
    }

    _isUploading = true;
    notifyListeners();

    final uri = Uri.parse('https://schoolnot.tpowep.com/api/upload');
    final request = http.MultipartRequest('POST', uri);

    try {
      // إضافة الملف إلى الطلب
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // تأكد أن هذا هو اسم الحقل الذي ينتظره السيرفر
          _selectedFile!.path,
        ),
      );

      print("📤 جاري رفع الملف: ${_selectedFile!.path}");

      final response = await request.send();

      _isUploading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        print("✅ استجابة السيرفر: ${responseBody.body}");

        try {
          final Map<String, dynamic> data =
          jsonDecode(responseBody.body) as Map<String, dynamic>;

          String fileUrl = data['path'].toString();
          fileUrl = fileUrl.replaceAll(r'\/', '/'); // تنظيف الرابط

          print("🔗 رابط الملف: $fileUrl");

          // الانتقال إلى الصفحة التالية بعد نجاح الرفع
          Get.to(
              Get.to(Get.off(LoadingPage(nextPage:NotebooksScreen(phoneNumber: '099')))));
url=fileUrl;
          return fileUrl;
        } catch (e) {
          return '❌ خطأ في تحليل الاستجابة: $e';
        }
      } else {
        return '❌ فشل رفع الملف: ${response.statusCode}';
      }
    } catch (e) {
      _isUploading = false;
      notifyListeners();
      return '⚠️ حدث خطأ أثناء رفع الملف: $e';
    }
  }
}
