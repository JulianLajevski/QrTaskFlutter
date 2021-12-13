import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/Models/advert.dart';
import 'package:login_app/src/redux/app_state.dart';
import 'package:redux/redux.dart';

class StartScreen extends StatelessWidget {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    List<Advert> userAdverts = <Advert>[];
    for(var ad in store.state.advert){
      if(ad.userId == auth.currentUser.uid){
        userAdverts.add(ad);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("All adverts"),
      ),
      body: Center(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => ListView.builder(
            itemCount: state.advert.length,
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
                                      state.advert[index].title,
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                     Text(
                                      state.advert[index].price,
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
                                      File(state.advert[index].image),
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                ),
                                ),
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
