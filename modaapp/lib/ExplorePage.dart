import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modaapp/AccountPage.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/Adv.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'package:modaapp/constraints.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentindex = 1;
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
        drawer: Drawer(
          backgroundColor: bckgrd,
          width: sc_width/3,
          child: ListView(
          padding: EdgeInsets.zero,
          children: [
            TextButton(onPressed: (){}, child: Text("For You", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("#cottonstyle", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("#oldmoney", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("octobersky", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("#parisianstyle", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("#cozygirl", style: TextStyle(color: darkcolor),)),
            TextButton(onPressed: (){}, child: Text("#darkacademia", style: TextStyle(color: darkcolor),)),
          ],
        ),
        ),
        backgroundColor: bckgrd,
        
        body: ExplorePageBody(sc_height, sc_width),
      ),
    );
  }

  Column ExplorePageBody(double sc_height, double sc_width) {
    return Column(
        children: [
          SizedBox(height: sc_height/60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  height: sc_height / 16,
                  width: sc_width * 8.5 / 10, //9.5
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 1,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 105, 105, 105),
                        ),
                        color: Colors.grey,
                        iconSize: 35,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Search",
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
              return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: darkcolor,
                    size: sc_width/15,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Icons:",
                style: TextStyle(color: Color.fromARGB(255, 138, 126, 18), fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sc_width / 50),
            child: SizedBox(
              height: sc_height / 10,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Constraints().usernames.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('images/post$index.jpg'),
                          radius: sc_width / 12,
                        ),
                        SizedBox(
                          width: sc_width / 30,
                        ),
                      ],
                    );
                  }),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      );
  }
}
