import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  int selectedCategory = 0; // 0 untuk Street, 1 untuk Natural

  // Dummy data
  final streetData = [
    {'title': 'Lokasi Street 1', 'subtitle': 'Deskripsi Lokasi 1'},
    {'title': 'Lokasi Street 2', 'subtitle': 'Deskripsi Lokasi 2'},
    {'title': 'Lokasi Street 3', 'subtitle': 'Deskripsi Lokasi 3'},
  ];

  final naturalData = [
    {'title': 'Lokasi Natural 1', 'subtitle': 'Deskripsi Lokasi 1'},
    {'title': 'Lokasi Natural 2', 'subtitle': 'Deskripsi Lokasi 2'},
    {'title': 'Lokasi Natural 3', 'subtitle': 'Deskripsi Lokasi 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Tab Bar
          Container(
            height: 80,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 80),
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
          // List data berdasarkan kategori
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
                      // Implementasikan aksi saat item dipilih
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
