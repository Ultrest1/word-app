import 'package:flutter/material.dart';

class kelimeEkle extends StatefulWidget {
  const kelimeEkle({Key? key}) : super(key: key);

  @override
  State<kelimeEkle> createState() => _kelimeEkleState();
}

class _kelimeEkleState extends State<kelimeEkle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'İngilizce Kelime',
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_double_arrow_right, color: Colors.red),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "İngilizce Kelime Giriniz",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.add,
                            ),
                            onPressed: () {},
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 3,
                            ),
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
