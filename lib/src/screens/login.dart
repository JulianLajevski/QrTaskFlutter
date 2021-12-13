import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/src/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                fontSize: 30
              ),
            ),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,0,30.0,0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.account_circle),
                ),
                 onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,30,30.0,0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.account_circle),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: (){
                      auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                        Navigator.push
                          (context,
                            MaterialPageRoute(builder: (context) => HomeScreen())
                        );
                      });

                }),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  child: Text('Sign Up'),
                  onPressed: (){
                    auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.push
                        (context,
                          MaterialPageRoute(builder: (context) => HomeScreen())
                      );
                    });

                  },
                ),
              )
            ])
          ],),
      ),
    );
  }
}