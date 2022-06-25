import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class kelimeEkle extends StatefulWidget {
  const kelimeEkle({Key? key}) : super(key: key);

  @override
  State<kelimeEkle> createState() => _kelimeEkleState();
}

class _kelimeEkleState extends State<kelimeEkle> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController ingilizceKelime = TextEditingController();
  TextEditingController turkceKelime = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference kelime = _firestore.collection("kelime");

    //var babaRef = kelime.doc("Baba");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Word - App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        autofocus: true,
                        controller: ingilizceKelime,
                        decoration: InputDecoration(
                          labelText: "  İngilizce Kelime Giriniz",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_double_arrow_right, color: Colors.red),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        controller: turkceKelime,
                        decoration: InputDecoration(
                          labelText: " Türkce Kelime Giriniz",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    child: Text("ekle"),
                    onPressed: () async {
                      Map<String, dynamic> worddata = {
                        "turkce": turkceKelime.text,
                        "ingilizce": ingilizceKelime.text,
                      };
                      await kelime.doc(ingilizceKelime.text).set(worddata);
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 350,
              child: StreamBuilder<QuerySnapshot>(
//neyi dinlenecek bilgisi,hangi streami
                stream: kelime.snapshots(), //stream aktariyo
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
                                  "${listOfDocument[index].data()}",
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
            )
          ],
        ),
      ),
    );
  }
}
