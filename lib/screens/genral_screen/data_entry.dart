import 'package:codeline_students_app/collectionRoute/collection_route.dart';

import 'package:flutter/material.dart';

class DataEntry extends StatefulWidget {
  String collection;
  DataEntry({this.collection});
  @override
  _DataEntryState createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  TextEditingController index = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.collection);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: index,
              decoration: InputDecoration(
                hintText: "index",
                labelText: "index",
              ),
            ),
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: "title",
                labelText: "title",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              color: Colors.blueAccent,
              elevation: 10,
              onPressed: () {
                // FirebaseFirestore.instance
                //     .collection("AdminLang")
                //     .doc(widget.collection)
                //     .collection("Data")
                //     .add({
                //   "title": title.text,
                //   "index": int.parse(index.text),
                // }).then((value) {
                //   setState(() {
                //     index.text = (int.parse(index.text) + 1).toString();
                //   });
                //   title.clear();
                // });

                cAdminLangCollection
                    .doc(widget.collection)
                      .collection('Data')
                    .where("index", isEqualTo: 18)
                    .get()
                    .then((value) => {
                  cAdminLangCollection
                              .doc(widget.collection)
                              .collection('Data')
                              .doc(value.docs[0].id)
                              .collection("Details")
                              .add({
                            "title": title.text,
                            "index": int.parse(index.text),
                          }).then((value) {
                            setState(() {
                              index.text =
                                  (int.parse(index.text) + 1).toString();
                            });
                            title.clear();
                          })
                        });
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
