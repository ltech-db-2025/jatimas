import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ljm/pages/homepage/umum/controller.dart';

class BannerUmum extends StatefulWidget {
  const BannerUmum({super.key});

  @override
  State<BannerUmum> createState() => _BannerUmumState();
}

class _BannerUmumState extends State<BannerUmum> {
  var c = getBarangUmumController();
  int currentPage = 0;
  late Timer _timer;
  final List<String> banners = [
    'assets/data/BannerBaseus.jpg',
    'assets/data/BannerOlike.jpg',
    'assets/data/BannerOraimo.jpg',
    'assets/data/BannerUgreen.jpg',
    'assets/data/BlackFriday.jpg',
  ];
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < banners.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return BannerWidget(imagePath: banners[index]);
              },
            ),
          ),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_pageController.page?.round() == index) ? Colors.blue : Colors.grey,
                    ),
                  );
                },
              );
            }),
          ), */
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  final String imagePath;

  const BannerWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
