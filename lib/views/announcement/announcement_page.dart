import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  int selectedCategory = 0;

  final streetData = [
    {'title': 'Street Location 1', 'subtitle': 'Location 1 Description'},
    {'title': 'Street Location 2', 'subtitle': 'Location 2 Description'},
    {'title': 'Street Location 3', 'subtitle': 'Location 3 Description'},
  ];

  final naturalData = [
    {'title': 'Natural Location 1', 'subtitle': 'Location 1 Description'},
    {'title': 'Natural Location 2', 'subtitle': 'Location 2 Description'},
    {'title': 'Natural Location 3', 'subtitle': 'Location 3 Description'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          Container(
            height: 60,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 60),
                  painter: TabBarPainter(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryButton('Street', 0),
                    _buildCategoryButton('Natural', 1),
                  ],
                ),
              ],
            ),
          ),
          // List data based on category
          Expanded(
            child: ListView.builder(
              itemCount: selectedCategory == 0
                  ? streetData.length
                  : naturalData.length,
              itemBuilder: (context, index) {
                final item = selectedCategory == 0
                    ? streetData[index]
                    : naturalData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.place, color: Colors.blue),
                    title: Text(item['title'] ?? ''),
                    subtitle: Text(item['subtitle'] ?? ''),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print('${item['title']} selected');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedCategory == index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedCategory == index ? Colors.blue[800] : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TabBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[800]!
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 1.3, size.width, size.height * 0.7)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
