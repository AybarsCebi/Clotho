import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'constraints.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentindex = 4;
  var pages = [
    HomePage(),
    ExplorePage(),
    AddPage(),
    MiniBlogPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);

    return SafeArea(
        child: Scaffold(
      backgroundColor: bckgrd,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sc_height / 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "@username",
                style: TextStyle(fontSize: 18),
              ),
            ),
                
            SizedBox(
              height: sc_height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: sc_height / 14,
                  backgroundImage: const AssetImage('images/clothoapp.png'),
                ),
                Text(
                  "218\n Followers",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "18\n Contents",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "175\n Followings",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: sc_height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                  },
                  child: Text("Follow"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(darkcolor),
                      foregroundColor: MaterialStatePropertyAll(bckgrd),
                      overlayColor: MaterialStatePropertyAll(Colors.black),
                      fixedSize: MaterialStatePropertyAll(
                          Size(sc_width / 3, sc_height / 30))),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Message"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(darkcolor),
                      foregroundColor: MaterialStatePropertyAll(bckgrd),
                      overlayColor: MaterialStatePropertyAll(Colors.black),
                      fixedSize: MaterialStatePropertyAll(
                          Size(sc_width / 3, sc_height / 30))),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text(
                            "@username",
                            style: TextStyle(fontSize: 20, color: darkcolor),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  "Height: 175",
                                ),
                                Text(
                                  "Weight: 54",
                                ),
                                Text(
                                  "Size: S",
                                ),
                                Text(
                                  "Horoscope: Sagittarius",
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "Continue",
                                style:
                                    TextStyle(fontSize: 20, color: darkcolor),
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
                  child: Icon(Icons.info),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(darkcolor),
                      foregroundColor: MaterialStatePropertyAll(bckgrd),
                      overlayColor: MaterialStatePropertyAll(Colors.black),
                      fixedSize: MaterialStatePropertyAll(
                          Size(sc_width / 10, sc_height / 30))),
                ),
              ],
            ),

            /*GridView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(height: sc_height/2, width: sc_width/4, color: Colors.amber,);
                  },
                  itemCount: 13,
                ),*/
            
            GridView.count(
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              children: List.generate(
                14,
                (index) => Container(
                  //height: sc_height/2,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
