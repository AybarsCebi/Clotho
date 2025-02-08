import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modaapp/BottomNavigationBar.dart';
import 'package:modaapp/FirebaseFunctions.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modaapp/constraints.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? image;
  Future pickImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _statusMessage;

  bool isValidEmail(String email) {
    return email.contains('@');
  }

  bool arePasswordsMatching() {
    return _registerPasswordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  Future<void> signUpandAddUser() async {
    if (_registerEmailController.text.isEmpty ||
        !isValidEmail(_registerEmailController.text)) {
      setState(() {
        _statusMessage = "Please enter a valid email address.";
      });
      return;
    }

    if (!arePasswordsMatching()) {
      setState(() {
        _statusMessage = "Passwords do not match.";
      });
      return;
    }

    if (_isChecked == false) {
      setState(() {
        _statusMessage = "CheckBox must be checked";
      });
      return;
    }

    try {
      // Kullanıcıyı Firebase Authentication'a kaydet
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmailController.text.trim(), // Emaili al
        password: _registerPasswordController.text.trim(), // Şifreyi al
      );

      String uid = userCredential.user!.uid; // Kullanıcının UID'sini al

      // Firestore'a kullanıcıyı ekle
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': _usernameController.text.trim(), // Kullanıcı adını al
        'email': _registerEmailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'followers': [],
        'following': [],
        'posts': [],
        'dailies': [],
        'saved': [],
        'profilepic': "",
        'personalDescription': "ilk hesap"
      });

      debugPrint("🎉 Kullanıcı başarıyla kayıt oldu ve Firestore'a eklendi!");
      _statusMessage = "Sign Up is successfull";
    } catch (e) {
      debugPrint("❌ Kullanıcı kaydedilirken hata oluştu: $e");
    }

    debugPrint(_statusMessage);
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color bckgrd = Color.fromARGB(255, 235, 235, 235);

    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);

    return SafeArea(
        child: Scaffold(
      backgroundColor: bckgrd,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: sc_height / 25,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Clotho",
                    style: GoogleFonts.dancingScript(
                        color: darkcolor, fontSize: 35),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: sc_width / 5,
                    endIndent: sc_width / 5,
                    thickness: 1,
                  ),
                  Text(
                    "Follow, create, inspire. \nJust fashion",
                    style: GoogleFonts.aboreto(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            /*Container(      
              height: sc_height / 10,
              width: sc_height/10,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              child:  image!=null ? Image.file(image!,): IconButton(onPressed: (){
                pickImageCamera();
              }, icon: Icon(Icons.camera_alt_rounded, color: Colors.white,))

            ),*/

            SizedBox(
              height: sc_height / 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: "Username",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
                  controller: _registerEmailController,
                  decoration: InputDecoration(
                    hintText: 'example@example.com',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
                  controller: _registerPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Create a Password',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Enter the Password',
                  ),
                ),
              ),
            ),
            SizedBox(height: sc_height / 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Kullanım koşulları ve şartları okudum ve kabul ediyorum.",
                      style: TextStyle(color: Colors.black),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 80, sc_width / 9, 0),
              child: TextButton(
                onPressed: () async {
                  await signUpandAddUser();
                  setState(() {});
                  if(_statusMessage=="Sign Up is successfull"){
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                  }
                  else{
                    showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              content: Text("Sign Up is unsuccessfull"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Popup'ı kapat
                                  },
                                  child: Text("Try Again"),
                                ),
                              ],
                            );
                          },
                        );
                  }
                  
                },
                style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(darkcolor),
                    fixedSize: WidgetStateProperty.all<Size>(
                      Size(double.maxFinite, sc_height / 16),
                    )),
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Already have an account,",
                style: TextStyle(fontSize: 13),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                style: const ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                child: Text(
                  "Log in",
                  style:
                      TextStyle(color: darkcolor, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            SizedBox(
              height: sc_height / 10,
            ),
            const Text(
              "All rights reserved",
              style: TextStyle(
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ));
  }
}
