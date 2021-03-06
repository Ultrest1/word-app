import 'package:deneme12/firebase.dart';
import 'package:deneme12/kelimeEkle.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({Key? key}) : super(key: key);

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  int currentIndex = 1;
  final screens = [
    kelimeEkle(),
    Center(
        child: Text(
      "feed",
      style: TextStyle(fontSize: 60),
    )),
    eklemesayfasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.orange,
          iconSize: 30,
          currentIndex: currentIndex,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "ekle",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: "feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "chat",
            ),
          ],
        ),
      ),
    );
  }
}
