import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class NotebookReader extends StatefulWidget {
  @override
  _NotebookReaderState createState() => _NotebookReaderState();
}

class _NotebookReaderState extends State<NotebookReader> {
  int _currentPage = 0;

  final List<String> _pages = [
    "📖 هذه هي الصفحة الأولى من الدفتر.",
    "✍️ هذه هي الصفحة الثانية من الدفتر.",
    "📚 هذه هي الصفحة الثالثة من الدفتر.",
    "✅ هذه هي الصفحة الرابعة من الدفتر.",
  ];

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _currentPage++;
        });
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _currentPage--;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(initialPage: _currentPage),
      physics: BouncingScrollPhysics(), // تأثير جميل عند محاولة تجاوز الصفحات
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return NotebookPage(
          text: _pages[index],
          pageIndex: index,
          totalPages: _pages.length,
          goToNextPage: _goToNextPage,
          goToPreviousPage: _goToPreviousPage,
        );
      },
    );
  }
}

class NotebookPage extends StatelessWidget {
  final String text;
  final int pageIndex;
  final int totalPages;
  final VoidCallback goToNextPage;
  final VoidCallback goToPreviousPage;

  NotebookPage({
    required this.text,
    required this.pageIndex,
    required this.totalPages,
    required this.goToNextPage,
    required this.goToPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("دفتر الملاحظات"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: pageIndex > 0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          goToPreviousPage();
                          return NotebookPage(
                            text: text,
                            pageIndex: pageIndex - 1,
                            totalPages: totalPages,
                            goToNextPage: goToNextPage,
                            goToPreviousPage: goToPreviousPage,
                          );
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return TurnPageTransition(
                            animation: animation,
                            overleafColor: Colors.blueAccent.shade100,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_back_ios),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              Visibility(
                visible: pageIndex < totalPages - 1,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          goToNextPage();
                          return NotebookPage(
                            text: text,
                            pageIndex: pageIndex + 1,
                            totalPages: totalPages,
                            goToNextPage: goToNextPage,
                            goToPreviousPage: goToPreviousPage,
                          );
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return TurnPageTransition(
                            animation: animation,
                            overleafColor: Colors.blueAccent.shade100,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
