import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modaapp/BottomNavigationBar.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/SignupPage.dart';
import 'package:modaapp/constraints.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late Animation<double> logo_opacity;
  late AnimationController controllerlogo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerlogo=AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    logo_opacity=Tween<double>(begin: 0, end: 1).animate(controllerlogo);
    controllerlogo.forward();
  }
  Widget LoginInput(String text) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return Padding(
      padding:
          EdgeInsets.fromLTRB(sc_width / 9, sc_height / 60, sc_width / 9, 0),
      child: SizedBox(
        height: sc_height / 16,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: text,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bckgrd = Color.fromARGB(255, 230, 230, 230); //235
    Color gold= Color.fromARGB(255, 175, 168, 42);
    
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    int quoteindex = Random().nextInt(welcomequotes().quotes.length);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bckgrd,
        body: Center(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: sc_height / 25,
              ),
              FadeTransition(
                opacity: logo_opacity,
                child: Image(
                  height: sc_height/3,
                  image: AssetImage('images/clothologo.png'),
                ),
              ),
              SizedBox(
                height: sc_height / 20,
              ),
              FadeTransition(
                opacity: logo_opacity,
                child: Text(
                  "Welcome",
                  style: GoogleFonts.dancingScript(
                      color: Colors.black, fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
              FadeTransition(
                opacity: logo_opacity,
                child: LoginInput('Username or email')),
              FadeTransition(
                opacity: logo_opacity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      sc_width / 9, sc_height / 80, sc_width / 9, 0),
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
              ),
              FadeTransition(
                opacity: logo_opacity,
                child: Padding(
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
                    child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
                  ),
                ),
              ),
              FadeTransition(
                opacity: logo_opacity,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Don't you have an account,",
                    style: TextStyle(fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text("Sign up", style: TextStyle(color: darkcolor, fontWeight: FontWeight.bold),),
                    style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    ),
                  ),
                ]),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
