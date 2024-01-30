import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/item_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Firestore Demo',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                // VIEW DATA HERE
                StreamBuilder<QuerySnapshot>(
                    stream: users.snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data?.docs
                                  .map((e) => ItemCard(
                                        (e.data() as Map<String, dynamic>)[
                                                'name'] ??
                                            'Default Name',
                                        (e.data() as Map<String, dynamic>)[
                                                'age'] ??
                                            'Default Age',
                                        onUpdate: () {
                                          users.doc(e.id).update({
                                            'age': (e.data() as Map<String,
                                                    dynamic>)['age'] +
                                                1
                                          });
                                        },
                                        onDelete: () {
                                          users.doc(e.id).delete();
                                        },
                                      ))
                                  .toList() ??
                              [],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 130,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: nameController,
                              decoration:
                                  const InputDecoration(hintText: "Name"),
                            ),
                            TextField(
                              controller: ageController,
                              decoration:
                                  const InputDecoration(hintText: "Age"),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.blue[900],
                            ),
                            child: const Text('Add Data',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              // ADD DATA HERE
                              users.add({
                                'name': nameController.text,
                                'age': int.tryParse(ageController.text) ?? 0
                              });

                              nameController.text = '';
                              ageController.text = '';
                            }),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
