import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Timer _timer;
  String _currentTime = "";

  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;

  final List<String> availableBooks = List.generate(
    10,
    (index) => "Buku ${index + 1} - Available",
  );

  Timer? _pageTimer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());

    // Auto scroll page view setiap 3 detik
    _pageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < availableBooks.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C54),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'BOOK_LOVER',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Jam realtime
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _currentTime,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amberAccent),
              ),
            ),
            const SizedBox(height: 10),

            const Icon(
              Icons.menu_book_rounded,
              size: 100,
              color: Colors.amberAccent,
            ),

            const SizedBox(height: 20),

            // PageView sebagai carousel buku available
            SizedBox(
              height: 120,
              child: PageView.builder(
                controller: _pageController,
                itemCount: availableBooks.length,
                itemBuilder: (context, index) {
                  bool active = index == _currentPage;
                  return _buildBookCard(availableBooks[index], active);
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            // Dua tombol besar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMainButton(
                  context,
                  icon: Icons.download_for_offline,
                  label: 'Pengambilan\nLoker',
                  onTap: () => Navigator.pushNamed(context, '/pickup'),
                ),
                _buildMainButton(
                  context,
                  icon: Icons.upload_file,
                  label: 'Pengembalian\nLoker',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur belum tersedia')),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Dua ikon kecil
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(
                  context,
                  icon: Icons.book_online,
                  label: 'Peminjaman',
                  onTap: () => Navigator.pushNamed(context, '/borrow'),
                ),
                _buildIconButton(
                  context,
                  icon: Icons.history,
                  label: 'Riwayat',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur belum tersedia')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(String title, bool active) {
    final double margin = active ? 10 : 20;
    final double scale = active ? 1.0 : 0.9;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 10),
      transform: Matrix4.identity()..scale(scale),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(15),
        boxShadow: active
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ]
            : [],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF464577),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.amber,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.black,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }
}
