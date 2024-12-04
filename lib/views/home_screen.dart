import 'package:flutter/material.dart';
import 'package:katalis/views/home/home_page.dart';
import 'package:katalis/views/announcement/announcement_page.dart';
import 'package:katalis/views/nim/nimfinder_screen.dart';
import 'package:katalis/views/profile/profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Color primaryBlue = Color(0xFF0D47A1);
  final Color secondaryBlue = Color(0xFF1976D2);

<<<<<<< HEAD
  final List<Widget> _widgetOptions = [
=======
  static List<String> _appBarTitles = [
    'Beranda',
    'Pencarian NIM',
    'Pengumuman',
    'Profil',
  ];

  static List<Widget> _widgetOptions = <Widget>[
>>>>>>> 621571ff22df7e2ba87a3fca7f5a80b3d9a55b5e
    HomePage(),
    NimFinderScreen(),
    AnnouncementPage(),
    ProfilePage(),
  ];

<<<<<<< HEAD
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);
=======
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
>>>>>>> 621571ff22df7e2ba87a3fca7f5a80b3d9a55b5e

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryBlue, secondaryBlue],
=======
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
>>>>>>> 621571ff22df7e2ba87a3fca7f5a80b3d9a55b5e
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: _widgetOptions[_selectedIndex],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
<<<<<<< HEAD
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'KATALIS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 12),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Image.asset(
                  'assets/images/hmif.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
=======
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
>>>>>>> 621571ff22df7e2ba87a3fca7f5a80b3d9a55b5e
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1976D2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_rounded, 'Home', 0),
          _buildNavItem(Icons.search_rounded, 'NIM', 1),
          _buildNavItem(Icons.notifications_rounded, 'Notif', 2),
          _buildNavItem(Icons.person_rounded, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[300],
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[300],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
