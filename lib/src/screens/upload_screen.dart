import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/src/Models/advert.dart';
import 'package:login_app/src/redux/actions.dart';
import 'package:login_app/src/redux/app_state.dart';
import 'package:redux/redux.dart';


class UploadScreen extends StatefulWidget {

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  File image;
  final auth = FirebaseAuth.instance;

  addData(String userId, String title, String description, String price, String image) {
    Map<String, dynamic> data = {
      "userId" : userId,
      "title" : title,
      "description" : description,
      "image" : image,
      "price" : "$price\$",
    };
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('advert');
    collectionReference.add(data);
  }

  Future uploadImage(ImageSource source) async {
    try {
      final image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
        body: SafeArea(
            child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) => Center(
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0,),
                        Text(
                          "Upload your advert!",
                          style: TextStyle(
                              fontSize: 30
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        InkWell(
                          onTap: (){
                            uploadImage(ImageSource.gallery);
                          },
                          child: image != null
                              ? ClipOval(
                            child: Image.file(
                              image,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          )
                              : FlutterLogo(size: 160),
                        ),
                        SizedBox(height: 30.0,),
                        SizedBox(
                          width: 230,
                          child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Title',
                              prefixIcon: Icon(Icons.text_fields),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        SizedBox(
                          width: 230,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description',
                              prefixIcon: Icon(Icons.description),
                            ),
                            maxLength: 200,
                            maxLines: 6,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        SizedBox(
                          width: 230,
                          child: TextField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Price',
                              prefixIcon: Icon(Icons.label),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 90.0,),
                        SizedBox(
                          width: 230,
                          height: 50,
                          child: ElevatedButton(
                              onPressed:(){
                                if(image != null){
                                  addData(
                                      auth.currentUser.uid,
                                      titleController.text,
                                      descriptionController.text,
                                      priceController.text,
                                      image.path
                                  );
                                  store.dispatch(AddAdvertText(
                                      Advert(
                                          auth.currentUser.uid,
                                          '1',
                                          titleController.text,
                                          descriptionController.text,
                                          image.path,
                                          priceController.text
                                      )));
                                }
                              },
                              child: Text(
                                  "Upload",
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                          ),
                        ),
                      ]
                  )
              ),
            )
        ));
  }
}