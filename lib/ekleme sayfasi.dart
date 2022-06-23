import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart ';

class eklemesayfasi extends StatefulWidget {
  const eklemesayfasi({Key? key}) : super(key: key);

  @override
  State<eklemesayfasi> createState() => _eklemesayfasiState();
}

class _eklemesayfasiState extends State<eklemesayfasi> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference moviesRef = _firestore.collection("movies");

    var babaRef = moviesRef.doc("Baba");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text("ekle"),
          onPressed: () async {
            print(nameController.text);
            print(ratingController.text);

            ///text alanlardaki veriden bir map olusturulmasi

            ///veriyi yazmak istedigimiz reference a ulas ve ilgili metoda ulas

            Map<String, dynamic> movieData = {
              "name": nameController.text,
              "rating": ratingController.text,
            };

            await moviesRef.doc(nameController.text).set(movieData);
            await moviesRef.doc(nameController.text).update({
              "rating": 3.1,
              "year": 2012
            }); //update metodu set ile map in hepsi kullanılmadı
          },
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "yazi 1 "),
                ),
                SizedBox(
                  height: 13,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ratingController,
                  decoration: InputDecoration(hintText: "numara 2 "),
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var response = await babaRef.get();
                        //document snapshot nedir?
                        //document snapshot icinden veri cıkarilmalı
                        var map = response.data(); //VERİ ZARF İCİNDEN ACILDI
                        print(map);
                      },
                      child: Text("get data"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var response = await moviesRef.get();
                        var List = response.docs;
                        //querysnapshot
                        //list icinde neler var

                        print(List[0].data());
                      },
                      child: Text("Get QuerySnapsnapshat"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("sil"),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  //neyi dinlenecek bilgisi,hangi streami
                  stream: moviesRef.snapshots(), //stream aktariyo
                  //streamden heryeni veri aktıgında asagidaki metodu calıstır
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text("bir hata olustu tekrar deneyiniz"),
                      );
                    } else {
                      if (asyncSnapshot.hasData) {
                        List<DocumentSnapshot> listOfDocument =
                            asyncSnapshot.data.docs;
                        return Flexible(
                          child: ListView.builder(
                            itemCount: listOfDocument.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    "${listOfDocument[index].data() ?? [
                                          "name"
                                        ]}",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      ///dokuman referenci .delete(),
                                      await listOfDocument[index]
                                          .reference //REFERENCE ONCE ULAS
                                          .delete();
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                      child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration:
                            InputDecoration(hintText: "film adını giriniz"),
                      ),
                      TextField(
                        controller: ratingController,
                        decoration: InputDecoration(hintText: "rating giriniz"),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
