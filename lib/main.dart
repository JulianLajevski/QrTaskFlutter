import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/Models/advert.dart';
import 'package:login_app/src/app.dart';
import 'package:login_app/src/redux/app_state.dart';
import 'package:login_app/src/redux/reducers.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Future<List<Advert>> getDocs() async {
    List<Advert> adList = <Advert>[];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("advert").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data();
      final title = a['title'] as String;
      final description = a['description'] as String;
      final image = a['image'] as String;
      final price = a['price'] as String;
      final userId = a['userId'] as String;
      final adId = querySnapshot.docs[i].id;

      Advert ad = Advert(userId, adId, title, description, image, price);
      adList.add(ad);
    }
    return adList;
  }

  final Store<AppState> store = Store(reducer, initialState: AppState(await getDocs()));
  runApp(StoreProvider(
    store: store,
      child: App()
  )
  );
}
