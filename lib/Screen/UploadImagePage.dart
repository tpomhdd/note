import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Controller/ImageUploadController.dart';



class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImageUploadController _controller = ImageUploadController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رفع صورة إلى السيرفر'),
        backgroundColor: Colors.blueAccent,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // عرض الصورة المختارة
                _controller.selectedImage != null
                    ? Image.file(
                  _controller.selectedImage!,
                  height: 200,
                )
                    : Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Center(
                    child: Text('لم يتم اختيار صورة'),
                  ),
                ),
                SizedBox(height: 20),
                // أزرار اختيار الصورة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _controller.pickImage(ImageSource.camera);
                        Navigator.of(context);
                        Navigator.of(context);
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('الكاميرا'),
                    ),
                    ElevatedButton.icon(
                      onPressed: (){_controller.pickImage(ImageSource.gallery);
                        Navigator.of(context);
                        Navigator.of(context);
                        },
                      icon: Icon(Icons.photo),
                      label: Text('المعرض'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // زر رفع الصورة
                _controller.isUploading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    final result = await _controller.uploadImage();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result)),
                    );
                  },
                  child: Text('رفع الصورة'),
                  style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    primary: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
