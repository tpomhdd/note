import 'package:flutter/material.dart';
import 'package:schoolnot/Screen/barcodepage.dart';
import 'package:schoolnot/Widget/assigment_qr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

import '../services/PrintService.dart';

class PageViewScreen extends StatefulWidget {
  final int pages;
  final String id;
  final String idnot;

  const PageViewScreen({
    Key? key,
    required this.pages,
    required this.id,
    required this.idnot,
  }) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int _currentPage = 0;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadPageNumber();
  }

  Future<void> _loadPageNumber() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _currentPage = prefs.getInt('current_page_${widget.id}') ?? 0;
        if (_currentPage >= widget.pages) {
          _currentPage = widget.pages - 1; // منع تجاوز الحد
        }
      });
    } catch (e) {
      print('Error loading page number: $e');
    }
  }

  Future<void> _updateAndSavePageNumber(int newPage) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _currentPage = newPage;
      });
      await prefs.setInt('current_page_${widget.id}', _currentPage);
    } catch (e) {
      print('Error saving page number: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < widget.pages - 1) {
      _updateAndSavePageNumber(_currentPage + 1);
      Navigator.of(context).push(
        TurnPageRoute(
          overleafColor: Colors.white,
          transitionDuration: const Duration(milliseconds: 600),
          builder: (context) => PageViewScreen(
            pages: widget.pages,
            id: widget.id,
            idnot: widget.idnot,
          ),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _updateAndSavePageNumber(_currentPage - 1);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousPage,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: _nextPage,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => PrintService.printScreen(context, _globalKey),
        child: const Icon(Icons.print, size: 25),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    100,
                        (i) => Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                left: 10,
                child: assigment_qr(
                  idnot: widget.idnot,
                  title: 'title',
                  content: 'content',
                  id: 'id',
                  pages: _currentPage,
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  color: Colors.transparent,
                  height: 150,
                  width: 100,
                  child: BarcodeSliderPages(
                    id: widget.id,
                    pages: _currentPage, // تأكد من عدم تجاوز النطاق هنا
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 160,
                child: Text(
                  "صفحة ${_currentPage + 1}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
