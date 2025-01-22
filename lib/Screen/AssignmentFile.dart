import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolnot/services/NotebookService.dart';
import 'package:schoolnot/services/myclient.dart';
import 'package:schoolnot/services/uploadfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/GradesController.dart';
import '../Controller/ImageUploadController.dart';
import '../Model/Notebook.dart';
import 'assignment.dart';

class AssignmentFile extends StatefulWidget {
  @override
  _AssignmentFileState createState() => _AssignmentFileState();
}

class _AssignmentFileState extends State<AssignmentFile> {
  final FileUploadController _controller = FileUploadController();
  final GradesController _gradesController = GradesController();
  final GradesController2 _gradesController2 = GradesController2();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();
  late NotebookService _notebookService;
  bool _isUploading = false;
  List<Notebook> _notebooks = [];
  bool _isLoading = true;
  Notebook? _selectedNotebook;
  String? _uploadedFileUrl; // لحفظ رابط الملف المرفوع

  @override
  void initState() {
    super.initState();
    _notebookService = NotebookService();
    _fetchNotebooks();
  }

  Future<void> _fetchNotebooks() async {
    final notebooks = await _notebookService.fetchNotebooks();
    setState(() {
      _notebooks = notebooks;
      _isLoading = false;
    });
//    Get.rawSnackbar(message: 'تمت الاضافة');
  }

  Future<void> _uploadFile() async {
    setState(() {
      _isUploading = true;
    });

    // رفع الملف
    String fileUrl = await _controller.uploadFile(); // تأكد من أنك لديك دالة للرفع هنا

    setState(() {
      _isUploading = false;
      _uploadedFileUrl = fileUrl; // حفظ رابط الملف بعد رفعه
    });

    // عند نجاح الرفع، أضف رابط الملف إلى النموذج
    _tokenController.text = _uploadedFileUrl!;
  }

  @override
  Widget build(BuildContext context) {
    // _nameController.text = 'واجب تاريخ';
    // _courseController.text = 'واجب87';
    // _tokenController.text = 'https://tpowep.com/';
    // _pageController.text = '5';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'رفع واجب',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // اختيار اللوجو
                _controller.selectedFile != null
                    ? _controller.selectedFile!.path.toLowerCase().endsWith('.png') ||
                    _controller.selectedFile!.path.toLowerCase().endsWith('.jpg') ||
                    _controller.selectedFile!.path.toLowerCase().endsWith('.jpeg')
                    ? Image.file(
                  _controller.selectedFile!,
                  height: 200,
                )
                    : Text(
                  '📄 الملف المحدد: ${_controller.selectedFile!.path.split('/').last}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
                    : Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: '📂 اختيار ملف',
                        content: Column(
                          children: [
                            MaterialButton(
                              onPressed: () => _controller.pickFile(),
                              child: Text('📁 اختر ملفًا من الجهاز'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      '📌 اضغط لاختيار ملف',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(height: 15),
                _buildTextField('عنوان الواجب', Icons.person, _nameController),
                SizedBox(height: 15),
                _buildTextField('تفاصيل الواجب', Icons.book, _courseController),
                SizedBox(height: 30),
//                _buildTextField('الرابط', Icons.book, _tokenController),
                SizedBox(height: 30),
                TextField(
                  controller: _pageController,
                  decoration: InputDecoration(
                    labelText: 'رقم الصفحة',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: ' رقم الصفخة',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.pages, color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 30),
                DropdownButtonFormField<Notebook>(
                  value: _selectedNotebook,
                  decoration: InputDecoration(
                    labelText: '',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white54, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  hint: Text(
                    'اختر الدفتر',
                    style: TextStyle(color: Colors.white),
                  ),
                  items: _notebooks.map((notebook) {
                    return DropdownMenuItem<Notebook>(
                      value: notebook,
                      child: Text(
                        notebook.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (notebook) {
                    setState(() {
                      _selectedNotebook = notebook;
                    });
                  },
                ),
                Center(
                  child: _isUploading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                      String username = sharedPreferences.get("id").toString();

                      // رفع الملف قبل إضافة الواجب
                      await _uploadFile();

                      // إرسال الواجب مع رابط الملف
                      await myclient().assignment(
                        _nameController.text,
                        _courseController.text,
                        _controller.url.toString(), // رابط الملف من الخادم
                        username,
                        _pageController.text,
                        _selectedNotebook!.id.toString(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'رفع الواجب',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: _isUploading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {

                      Get.to(Assignment());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      '  رفع الواجب من خلال الرابط',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.white54, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
