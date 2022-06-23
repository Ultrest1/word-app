import 'package:deneme12/ekleme%20sayfasi.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({Key? key}) : super(key: key);

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  int currentIndex = 1;
  final screens = [
    Center(
        child: Text(
      "home",
      style: TextStyle(fontSize: 60),
    )),
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
          backgroundColor: Colors.lime,
          iconSize: 30,
          currentIndex: currentIndex,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: "feed",
              backgroundColor: Colors.lime,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "chat",
              backgroundColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
