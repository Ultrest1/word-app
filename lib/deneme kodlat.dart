
Divider(height: 20),
StreamBuilder<QuerySnapshot>(
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
)