import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movielist/listscreen.dart';

class gsign extends StatefulWidget {
  const gsign({ Key? key }) : super(key: key);

  @override
  _gsignState createState() => _gsignState();
}

class _gsignState extends State<gsign> {


  late FirebaseAuth firebaseAuth;


   Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
   
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MListScreen()));
      }
       
    });
  } 


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                      backgroundColor: Color(0xFF0F044C),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                child: Text(
                  "Sign in with Google to continue",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            ElevatedButton(onPressed: ()async{
              await signInWithGoogle();
            }, child:Text('Sign in with Google')),
          ],
        ),
      ),
    );
  }
}