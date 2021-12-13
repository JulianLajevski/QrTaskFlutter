
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/Models/advert.dart';
import 'package:login_app/src/redux/actions.dart';
import 'package:login_app/src/redux/app_state.dart';
import 'package:redux/redux.dart';

class MyAdvertsScreen extends StatefulWidget {
  @override
  State<MyAdvertsScreen> createState() => _MyAdvertsScreenState();
}

class _MyAdvertsScreenState extends State<MyAdvertsScreen> {
  final auth = FirebaseAuth.instance;

  var edited = false;

  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    List<Advert> userAdverts = <Advert>[];
    for(var ad in store.state.advert){
      if(ad.userId == auth.currentUser.uid){
        userAdverts.add(ad);
      }
    }

    deleteAdvert(String adId) async {
      FirebaseFirestore.instance
      .collection('advert')
      .doc(adId)
      .delete()
      .catchError((e) {
        print(e);
      });
    }

    updateAdvert(String title, String adId) async {
      FirebaseFirestore.instance
          .collection('advert')
          .doc(adId)
          .update({"title":title})
          .catchError((e) {
        print(e);
      });
    }

    _displayDialog(BuildContext context, String adId, String currentTitle) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Your comment:'),
              content: TextField(
                controller: _textFieldController,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(hintText: currentTitle),
              ),
              actions: <Widget>[
                new ElevatedButton(
                  child: new Text('Add'),
                  onPressed: () {
                    updateAdvert(_textFieldController.text, adId);
                    store.dispatch(UpdateAdvert(_textFieldController.text, adId));
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My adverts"),
      ),
      body: Center(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => ListView.builder(
              itemCount: userAdverts.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      userAdverts[index].title,
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      userAdverts[index].price,
                                      style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB( 0, 0, 10, 0),
                                  child: ClipOval(
                                    child: Image.file(
                                      File(userAdverts[index].image),
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        deleteAdvert(userAdverts[index].adId);
                                        setState(() {
                                          store.dispatch(DeleteAdvert(userAdverts[index].adId));
                                        });
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ),
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        _displayDialog(context, userAdverts[index].adId, userAdverts[index].title);
                                      },
                                      child: Text("Edit"),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    )
                );
              }
          ),
        ),
      ),
    );
  }
}
