import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isButtonVisible = false;
  int _selectedIndex = 0;

  void _toggleButtons() {
    setState(() {
      _isButtonVisible = !_isButtonVisible;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom FAB Example'),
      ),
      body: Center(child: Text('Selected Index: $_selectedIndex')),
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Tombol tambahan yang muncul saat FAB ditekan
          if (_isButtonVisible) ...[
            Positioned(
              bottom: 70,
              child: _buildActionButton(Icons.add, 'Penjualan', Colors.blue, () {
                print('Penjualan pressed');
              }),
            ),
            Positioned(
              bottom: 130,
              child: _buildActionButton(Icons.person_add, 'Pelanggan', Colors.green, () {
                print('Pelanggan pressed');
              }),
            ),
            Positioned(
              bottom: 190,
              child: _buildActionButton(Icons.swap_horiz, 'Mutasi', Colors.orange, () {
                print('Mutasi pressed');
              }),
            ),
          ],
          // Floating Action Button utama di dalam lengkungan
          Positioned(
            bottom: -20, // Sesuaikan jarak agar berada di dalam lengkungan
            child: FloatingActionButton(
              onPressed: _toggleButtons,
              child: Icon(_isButtonVisible ? Icons.close : Icons.add),
              backgroundColor: Color(0xFF00b3b0),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow, // Mengubah warna latar belakang menjadi kuning
        child: ClipPath(
          clipper: InnerCurveClipper(),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifikasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF00b3b0),
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            backgroundColor: Colors.blue, // Membuat background transparan untuk BottomNavigationBar
            // fixedColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class InnerCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerX = size.width / 2;
    double fabRadius = 16; // Sesuaikan ini berdasarkan ukuran tombol dan jarak

    path.moveTo(0, 0);
    path.lineTo(centerX - fabRadius - 20, 0);
    path.arcToPoint(
      Offset(centerX + fabRadius + 20, 0),
      radius: Radius.circular(fabRadius + 20),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
