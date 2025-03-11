import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    //MiniBlogPage(),
    AccountPage()
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>>? _explorePosts;

  Future<void> _loadExplorePosts() async {
    QuerySnapshot postSnapshot =
        await _firestore.collection('all_posts').get();

    List<Map<String, dynamic>> posts = postSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    setState(() {
      _explorePosts = posts;
    });

    debugPrint("Explore Posts: $_explorePosts");
  }

  @override
  void initState() {
    super.initState();
    _loadExplorePosts();
  }

  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: bckgrd,
          width: sc_width / 3,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "For You",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "#cottonstyle",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "#oldmoney",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "octobersky",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "#parisianstyle",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "#cozygirl",
                    style: TextStyle(color: darkcolor),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "#darkacademia",
                    style: TextStyle(color: darkcolor),
                  )),
            ],
          ),
        ),
        backgroundColor: bckgrd,
        body: _explorePosts == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: sc_height / 60,
                    ),
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
                                size: sc_width / 15,
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
                    GridView.count(
                      mainAxisSpacing: sc_width / 100,
                      crossAxisSpacing: sc_width / 100,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: Random().nextDouble()*0.1 + 0.6,
                      children: (_explorePosts ?? []).map<Widget>((post) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            post['postUrl'],
                            fit: BoxFit.cover,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint("Resim yüklenemedi: $error");
                              return Container(
                                color: Colors.grey,
                                child: const Icon(Icons.broken_image,
                                    color: Colors.white),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
