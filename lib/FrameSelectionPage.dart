// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FrameSelectionPage extends StatefulWidget {
//   final VoidCallback onFrameSelected; // لاستدعاء إجراء بعد الاختيار
//
//   const FrameSelectionPage({Key? key, required this.onFrameSelected}) : super(key: key);
//
//   @override
//   State<FrameSelectionPage> createState() => _FrameSelectionPageState();
// }
//
// class _FrameSelectionPageState extends State<FrameSelectionPage> {
//   final List<String> _frames = [
//     'asstes/1.jpg',
//     'asstes/2.png',
//
//   ]; // مسارات صور الإطارات
//
//   String? _selectedFrame;
//
//   Future<void> _saveSelectedFrame(String frame) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('selected_frame', frame);
//     widget.onFrameSelected(); // استدعاء الإجراء عند الحفظ
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('اختيار إطار للدفتر'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // عدد العناصر في كل صف
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: _frames.length,
//           itemBuilder: (context, index) {
//             String frame = _frames[index];
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedFrame = frame;
//                 });
//                 _saveSelectedFrame(frame);
//               },
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: _selectedFrame == frame ? Colors.blue : Colors.grey,
//                         width: 3,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Image.asset(frame, fit: BoxFit.cover),
//                   ),
//                   if (_selectedFrame == frame)
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: Icon(Icons.check_circle, color: Colors.green, size: 24),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
