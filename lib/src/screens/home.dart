import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/src/screens/login.dart';
import 'package:login_app/src/screens/my_adverts_screen.dart';
import 'package:login_app/src/screens/start_screen.dart';
import 'package:login_app/src/screens/upload_screen.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 100.0,),
                      Text(
                          "Hello again!",
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                      SizedBox(height: 100.0,),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push
                                (context,
                                  MaterialPageRoute(builder: (context) => UploadScreen())
                              );
                            },
                            child: Text("Add advert")
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push
                                (context,
                                  MaterialPageRoute(builder: (context) => StartScreen())
                              );
                            },
                            child: Text("All adverts")
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push
                                (context,
                                  MaterialPageRoute(builder: (context) => MyAdvertsScreen())
                              );
                            },
                            child: Text("My adverts")
                        ),
                      ),
                      SizedBox(height: 170.0,),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: (){
                              auth.signOut();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text("Logout")
                        ),
                      ),
                    ]
                )
            )
        ));
  }
}