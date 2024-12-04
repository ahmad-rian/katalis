import 'package:flutter/material.dart';
import 'package:katalis/views/home/home_page.dart';
import 'package:katalis/views/nim/searchnim_page.dart';
import 'package:katalis/views/announcement/announcement_page.dart';
import 'package:katalis/views/profile/profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<String> _appBarTitles = [
    'Beranda',
    'Pencarian NIM',
    'Pengumuman',
    'Profil',
  ];

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchNimPage(),
    AnnouncementPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          style: TextStyle(
            color: Colors.white, // Warna huruf putih
            fontWeight: FontWeight.bold, // (Opsional) Menambahkan efek tebal
          ),
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Implementasi tombol notifikasi
            },
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        elevation: 5,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pencarian NIM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Pengumuman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
