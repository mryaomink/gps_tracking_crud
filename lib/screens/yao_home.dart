import 'dart:ui';
import 'package:app_data/screens/yao_barang.dart';
import 'package:app_data/screens/yao_instalasi.dart';
import 'package:app_data/screens/yao_konsumen.dart';
import 'package:app_data/screens/yao_laporan.dart';
import 'package:flutter/material.dart';

class YaoHome extends StatefulWidget {
  const YaoHome({super.key});

  @override
  State<YaoHome> createState() => _YaoHomeState();
}

class _YaoHomeState extends State<YaoHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          // Background with clip shape and blur effect
          Positioned.fill(
            child: ClipPath(
              clipper: CustomClipperPath(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow.withOpacity(0.6), Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 40,
            right: 0,
            top: 60,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Welcome To My Application',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    title: "Data Konsumen",
                    icon: Icons.people,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YaoKonsumen()));
                    },
                  ),
                  _buildMenuCard(
                    title: "Instalasi",
                    icon: Icons.gps_fixed_outlined,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YaoInstalasi()));
                    },
                  ),
                  _buildMenuCard(
                    title: "Stok Barang",
                    icon: Icons.inventory,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YaoBarang()));
                    },
                  ),
                  _buildMenuCard(
                    title: "Laporan",
                    icon: Icons.book,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YaoLaporan()));
                    },
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 130,
            right: 0,
            bottom: -3,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Created by Yaomink @2024',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required IconData icon,
    required Color color,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom clipper class for background shape
class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.60);

    final firstControlPoint = Offset(size.width * 0.25, size.height * 0.65);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.60);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.85);
    final secondEndPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
