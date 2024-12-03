import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/background1.jpg',
      'title': 'Semangat motivasi',
      'subtitle':
          'Bagikan kata-kata motivasi dan inspirasi yang dapat memberi semangat bagi semua.',
    },
    {
      'image': 'assets/images/background2.jpg',
      'title': 'Cari nim',
      'subtitle':
          'Pengguna dapat dengan mudah mencari data atau informasi terkait dengan NIM (Nomor Induk Mahasiswa) melalui fitur pencarian di aplikasi.',
    },
    {
      'image': 'assets/images/background3.jpg',
      'title': 'Data real-time',
      'subtitle':
          'Data dalam aplikasi selalu diperbarui secara real-time, memastikan bahwa pengguna selalu mendapatkan informasi terkini dan akurat.',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(
          context, '/login'); // Navigasi ke halaman utama
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      onboardingData[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Overlay untuk membuat background lebih gelap
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.5)),
                  ),
                  // Content
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  onboardingData[index]['title']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  onboardingData[index]['subtitle']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          // Page Indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingData.length,
                              (dotIndex) => AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: dotIndex == _currentPage ? 12 : 8,
                                height: dotIndex == _currentPage ? 12 : 8,
                                decoration: BoxDecoration(
                                  color: dotIndex == _currentPage
                                      ? Colors.white
                                      : Colors.white54,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Button "Next" untuk halaman selain terakhir
                          if (index != onboardingData.length - 1)
                            ElevatedButton(
                              onPressed: _goToNextPage,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text('Next'),
                            ),
                          // Button "Get Started" untuk halaman terakhir
                          if (index == onboardingData.length - 1)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context,
                                    '/login'); // Navigasi ke halaman utama
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text('Get Started'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Skip Button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/home'); // Navigasi langsung ke halaman utama
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
