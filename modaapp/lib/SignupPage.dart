import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modaapp/BottomNavigationBar.dart';
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

  Widget SingupInput(String text){
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),),
                    labelText: text,
                  ),
                ),
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    Color bckgrd = Color.fromARGB(255, 235, 235, 235);

    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    int quoteindex = Random().nextInt(welcomequotes().quotes.length);
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
              style:
                  GoogleFonts.dancingScript(color: darkcolor, fontSize: 35),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: Colors.grey,
              indent: sc_width/5,
              endIndent: sc_width/5,
              thickness: 1,
            ),
            Text("Follow, create, inspire. \nJust fashion",
            style: GoogleFonts.aboreto(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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
              height: sc_height/40,
            ),
            SingupInput('Name'),
            SingupInput('Lastname'),
            SingupInput('Username'),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 60, sc_width / 9, 0),
              child: SizedBox(
                height: sc_height / 16,
                child: TextField(
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
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    sc_width / 9, sc_height / 60, sc_width / 9, 0),
                child: SizedBox(
                  height: sc_height / 11.5,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    initialCountryCode: 'TR',
                    onChanged: (phone) {
                      debugPrint(phone.completeNumber);
                    },
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sc_width / 9, sc_height / 80, sc_width / 9, 0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Menu(),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text("Welcome", style: GoogleFonts.dancingScript(fontSize: 30, color: darkcolor),),
                          content: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(welcomequotes().quotes[quoteindex],
                                style: GoogleFonts.dancingScript(fontSize: 24, color: darkcolor)),
                          ),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "Continue",
                                style: GoogleFonts.dancingScript(fontSize: 23, color: darkcolor),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                },
                style: ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(darkcolor),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(double.maxFinite, sc_height / 16),
                    )),
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account,", style: TextStyle(fontSize: 13),),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                style: const ButtonStyle(
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                            ),
                child: Text("Log in", style: TextStyle(color: darkcolor, fontWeight: FontWeight.bold),),
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
