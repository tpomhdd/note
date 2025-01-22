import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/FrameSelectionPage.dart';
import 'package:schoolnot/Screen/LoadingPage.dart';
import 'package:schoolnot/Screen/NotePage.dart';
import 'package:schoolnot/Screen/NotebooksScreen.dart';
import 'package:schoolnot/teacher/index2.dart';

import '../Screen/NotebookPage.dart';

class ImageUploadController extends ChangeNotifier {
  File? _selectedImage;
  bool _isUploading = false;
  String? url;
  String? id;

  final ImagePicker _picker = ImagePicker();

  File? get selectedImage => _selectedImage;
  bool get isUploading => _isUploading;

  // اختيار صورة من الكاميرا أو المعرض
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    } else {
      print('لم يتم اختيار أي صورة');
    }
  }
  Future<String> uploadImage() async {
    if (_selectedImage == null) {
      return 'يرجى اختيار صورة أولاً';
    }

    _isUploading = true;
    notifyListeners();

    final uri = Uri.parse('https://schoolnot.tpowep.com/api/upload'); // رابط API
    final request = http.MultipartRequest('POST', uri);

    try {
      // إضافة الصورة
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // اسم الحقل المتوقع في السيرفر
          _selectedImage!.path,
        ),
      );
      print(selectedImage!.path.toString());

      final response = await request.send();

      _isUploading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        // قراءة استجابة الخادم بالكامل
        final responseBody = await http.Response.fromStream(response);
        print("Response Body: ${responseBody.body}");  // طباعة الاستجابة بالكامل

        try {
          // محاولة تحليل البيانات على شكل JSON
          final Map<String, dynamic> data = Map<String, dynamic>.from(
              jsonDecode(responseBody.body)
          );


            String url=data['path'].toString();
            String cleanedUrl = url.replaceAll(r'\/', '/');
            print(cleanedUrl);
            url=cleanedUrl;

          Get.to(Get.off(LoadingPage(nextPage:teacher())));          return cleanedUrl;  // إذا كان الرابط موجودًا في استجابة الخادم

       } catch (e) {
          return 'خطأ في تحليل الاستجابة: $e';
        }
      } else {
        return 'فشل رفع الصورة: ${response.statusCode}';
      }
    } catch (e) {
      _isUploading = false;
      notifyListeners();
      return 'حدث خطأ أثناء رفع الصورة: $e';
    }
  }
// رفع الصورة إلى السيرفر

}
