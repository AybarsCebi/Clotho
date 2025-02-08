import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:modaapp/AccountPage.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/MiniBlogDetail.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'package:modaapp/StoryPage.dart';
import 'constraints.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final pageBucket = PageStorageBucket();

class Post {
  String contenturl,
      outfitaccesories,
      outfitlower,
      outfitshoes,
      outfitupper,
      profilephotourl,
      username,
      id;
  int commentnumber, iconnumber, likenumber;
  bool isexpert, isfollow, islike, isicon;
  Post({
    required this.id,
    required this.commentnumber,
    required this.contenturl,
    required this.iconnumber,
    required this.isexpert,
    required this.isfollow,
    required this.islike,
    required this.likenumber,
    required this.outfitaccesories,
    required this.outfitlower,
    required this.outfitshoes,
    required this.outfitupper,
    required this.profilephotourl,
    required this.username,
    required this.isicon,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      commentnumber: doc['commentnumber'],
      iconnumber: doc['iconnumber'],
      isexpert: doc['isexpert'],
      likenumber: doc['likenumber'],
      outfitaccesories: doc['outfitaccesories'],
      outfitlower: doc['outfitlower'],
      outfitshoes: doc['outfitshoes'],
      outfitupper: doc['outfitupper'],
      profilephotourl: doc['profilephotourl'],
      username: doc['username'],
      contenturl: doc['contenturl'],
      isfollow: doc['isfollow'],
      islike: doc['islike'],
      isicon: doc['isicon'],
    );
  }
}

class Daily {
  String profilephotourl, username, dailyurl, id;

  Daily(
      {required this.id,
      required this.profilephotourl,
      required this.username,
      required this.dailyurl});

  factory Daily.fromDocument(DocumentSnapshot doc) {
    return Daily(
        id: doc.id,
        dailyurl: doc['dailyurl'],
        profilephotourl: doc['profilephotourl'],
        username: doc['username']);
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Post> HomePagePosts = [];
  List<Daily> HomePageDailies = [];

  Future<List<Post>> fetchHomepagePosts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('homepageposts').get();
      HomePagePosts =
          snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      print("Fetched posts: ${HomePagePosts.length}");
      return HomePagePosts;
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  Future<List<Daily>> fetchHomepageDailies() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('homepagedailies').get();
      HomePageDailies =
          snapshot.docs.map((doc) => Daily.fromDocument(doc)).toList();
      print("Fetched dailies: ${HomePageDailies.length}");
      return HomePageDailies;
    } catch (e) {
      print("Error fetching dailies: $e");
      return [];
    }
  }

  updatelike(String contentid, int num, bool durum) async {
    if (durum == false) {
      await _firestore
          .doc('homepageposts/${contentid}')
          .update({'likenumber': num + 1, 'islike': true});
    } else {
      await _firestore
          .doc('homepageposts/${contentid}')
          .update({'likenumber': num - 1, 'islike': false});
    }
  }

  updateicon(String contentid, int num, bool durum) async {
    if (durum == false) {
      await _firestore
          .doc('homepageposts/$contentid')
          .update({'iconnumber': num + 1, 'isicon': true});
    } else {
      await _firestore
          .doc('homepageposts/$contentid')
          .update({'iconnumber': num - 1, 'isicon': false});
    }
  }

  updatefollow(String contentid, bool durum) async {
    if (durum == false) {
      await _firestore
          .doc('homepageposts/$contentid')
          .update({'isfollow': true});
    } else {
      await _firestore
          .doc('homepageposts/$contentid')
          .update({'isfollow': false});
    }
  }

  bool saved = false;

  var pages = [
    HomePage(),
    const ExplorePage(),
    const AddPage(),
    const MiniBlogPage(),
    const AccountPage()
  ];

  Widget unlike = const Icon(
    Icons.favorite_border_outlined,
    color: Colors.white,
  );
  Widget like = const Icon(
    Icons.favorite,
    color: Colors.red,
  );

  @override
  void initState() {
    super.initState();
    fetchHomepagePosts();
    fetchHomepageDailies();
  }

  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: bckgrd,
          /*drawer: Drawer(
            width: sc_width / 3.8,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10, // total number of items
              itemBuilder: (context, index) {
                return SizedBox(
                  width: sc_width / 4.2,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoryPage(account: index),
                        ),
                      );
                    },
                    child: Container(
                      //width: double.infinity,
                      height: sc_width / 4.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/post$index.jpg'),
                            fit: BoxFit.cover),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),*/
          appBar: AppBar(
            toolbarHeight: sc_height / 18,
            automaticallyImplyLeading: false,
            elevation: 2,
            title: Text(
              "Clotho",
              style:
                  GoogleFonts.dancingScript(color: Colors.black, fontSize: 38),
            ),
            /*leading: Builder(builder: (context) {
              return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: darkcolor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),*/
            backgroundColor: bckgrd,
            centerTitle: true,
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(
                      icon: Text(
                    "Homepage",
                    style: TextStyle(fontSize: 16),
                  )),
                  Tab(
                      icon: Text(
                    "Daily",
                    style: TextStyle(fontSize: 16),
                  )),
                ]),
          ),
          body: PageStorage(
            bucket: pageBucket,
            child: TabBarView(children: [
              homepageposts(sc_width, sc_height),
              homepagedailys(sc_width, sc_height),
            ]),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Post>> homepageposts(double sc_width, double sc_height) {
    return FutureBuilder<List<Post>>(
        future: fetchHomepagePosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchHomepagePosts();
              });
            },
            child: ListView.builder(
              key: const PageStorageKey<String>('homepage'),
              itemCount: HomePagePosts.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: sc_height / 100),
                      Padding(
                        padding: EdgeInsets.fromLTRB(sc_width / 35, 0,
                            sc_width / 35, 0), //eskisi sc_width/40
                        child: Container(
                          height: sc_height / 20,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 200, 200, 200),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: sc_width / 30,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    HomePagePosts[index].profilephotourl),
                                //AssetImage("images/ticklogo.png"),
                                radius: sc_height / 70,
                              ),
                              SizedBox(
                                width: sc_width / 50,
                              ),
                              TextButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  HomePagePosts[index].username,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Image(
                                  image: AssetImage("images/ticklogo.png"),
                                  width: 15),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    updatefollow(HomePagePosts[index].id,
                                        HomePagePosts[index].isfollow);
                                  });
                                },
                                style: const ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                ),
                                child: (HomePagePosts[index].isfollow == false)
                                    ? const Text(
                                        "Follow",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : const Text(
                                        "Following",
                                        style: TextStyle(color: Colors.black),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Stack(children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        HomePagePosts[index].contenturl),
                                    //image: AssetImage("images/ticklogo.png"),
                                    fit: BoxFit.cover)),
                            width: (MediaQuery.of(context).size.width) *
                                9.4 /
                                10, //eskisi 9.5
                            height:
                                (MediaQuery.of(context).size.height) * 6.4 / 10,
                            child: FilledButton(
                              onPressed: () {},
                              onLongPress: () {
                                setState(() {
                                  updatelike(
                                      HomePagePosts[index].id,
                                      HomePagePosts[index].likenumber,
                                      HomePagePosts[index].islike);
                                });
                              },
                              child: null,
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                    Colors.transparent),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(sc_width * 8.5 / 10,
                              sc_height / 100, 0, 0), //eskisi 8
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                saved = !saved;
                              });
                            },
                            icon: SizedBox(
                              height: sc_width / 12,
                              child: Image.asset(
                                'images/savedicon.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        /*Padding(                                                       //play button
                        padding: EdgeInsets.fromLTRB(
                            sc_width * 3.5 / 10, sc_height / 4, 0, 0), //eskisi 8
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              saved = !saved;
                            });
                          },
                          icon: Icon(Icons.play_circle),
                          iconSize: sc_width / 5,
                        ),
                      ),*/

                        /*Padding(padding: EdgeInsets.fromLTRB(sc_width/40, sc_height*5.8/10, 0, 0),
                        child: Container(
                          width: sc_width*7.5/10,
                          height:sc_height*5/100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(55, 0, 0, 0),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text("     ################", style: TextStyle(color: Colors.white),),
                        ),
                      ),*/

                        Padding(
                          padding: EdgeInsets.fromLTRB(sc_width * 8.2 / 10,
                              sc_height / 6.6, 0, 0), //eskisi 8
                          child: Container(
                            width: sc_width / 8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(55, 0, 0, 0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                    splashRadius: 10,
                                    iconSize: 25,
                                    onPressed: () {
                                      setState(() {
                                        updatelike(
                                            HomePagePosts[index].id,
                                            HomePagePosts[index].likenumber,
                                            HomePagePosts[index].islike);
                                      });
                                    },
                                    icon: (HomePagePosts[index].islike == true)
                                        ? like
                                        : unlike),
                                Text(
                                  HomePagePosts[index].likenumber.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(
                                  height: sc_height / 45,
                                ),
                                IconButton(
                                  splashRadius: 10,
                                  iconSize: 25,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        // Beveled yerine Rounded kullanabilirsin
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: double
                                              .infinity, // Genişliği ekran genişliği kadar yap
                                          height: sc_height /
                                              2, // Mevcut yüksekliği koru
                                          padding: EdgeInsets.all(
                                              16), // İç boşluk ekleyerek düzenli görünmesini sağla
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start, // İçerikleri sola hizala
                                            children: [
                                              Center(
                                                // Başlığı ortalamak için Center widget kullan
                                                child: Text(
                                                  "Comments",
                                                  style: TextStyle(
                                                    color: darkcolor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "#cottonfashion #blueshirt #explore",
                                                style: TextStyle(
                                                    color: darkcolor,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "#cottonfashion #blueshirt #explore",
                                                style: TextStyle(
                                                    color: darkcolor,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.comment_outlined,
                                    color: Colors.white,
                                  ),
                                  color: Colors.black,
                                ),
                                Text(
                                  HomePagePosts[index].commentnumber.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(
                                  height: sc_height / 45,
                                ),
                                IconButton(
                                  splashRadius: 10,
                                  iconSize: 25,
                                  onPressed: () {
                                    setState(() {
                                      updateicon(
                                          HomePagePosts[index].id,
                                          HomePagePosts[index].iconnumber,
                                          HomePagePosts[index].isicon);
                                    });
                                  },
                                  icon: (HomePagePosts[index].isicon == false)
                                      ? const Icon(
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 228, 219, 54),
                                        ),
                                  color: Colors.black,
                                ),
                                Text(
                                  HomePagePosts[index].iconnumber.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(
                                  height: sc_height / 45,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text(
                                            "Outfit",
                                            style: GoogleFonts.dancingScript(
                                                fontSize: 30, color: darkcolor),
                                          ),
                                          content: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                                "Üst: ${HomePagePosts[index].outfitupper}\nAlt: ${HomePagePosts[index].outfitlower}\nAyakkabı: ${HomePagePosts[index].outfitshoes}\nAksesuar: ${HomePagePosts[index].outfitaccesories}",
                                                style:
                                                    GoogleFonts.dancingScript(
                                                        fontSize: 24,
                                                        color: darkcolor)),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: const ButtonStyle(
                                                overlayColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.transparent),
                                              ),
                                              child: Text(
                                                "Continue",
                                                style:
                                                    GoogleFonts.dancingScript(
                                                        fontSize: 23,
                                                        color: darkcolor),
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
                                  icon: const Icon(Icons.tag,
                                      color: Colors.white),
                                  iconSize: 30,
                                  splashRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /*Padding(
                        padding:
                            EdgeInsets.fromLTRB(sc_width / 50, sc_height*60/100, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(55, 0, 0, 0),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          height: sc_height/15,
                          width: sc_width*9.1/10,
                          
                          child: Padding(
                            padding: const EdgeInsets.only(left:5, top: 8),
                            child: Text("#streetstyle#cottonstyle#suit",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),*/
                      ]),
                      /*Padding(                                                     //comment part
                        padding: EdgeInsets.fromLTRB(sc_width / 35, 0,
                            sc_width / 35, 0), //eskisi sc_width/40
                        child: Container(
                          height: sc_height / 20,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 200, 200, 200),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16))),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Caption: At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt",
                              overflow: TextOverflow
                                  .ellipsis, // Metin sığmazsa "..." ekleyecek
                              maxLines: 2, // Metin kaç satıra kadar sığacak
                              
                              style: TextStyle(
                                  fontSize: 13), // Metin boyutunu ayarlamak için
                            ),
                          ),
                        )),*/
                      SizedBox(height: sc_height / 100),
                      Divider(
                        thickness: 1,
                        height: sc_height / 80,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  FutureBuilder<List<Daily>> homepagedailys(double sc_width, double sc_height) {
    return FutureBuilder(
      future: fetchHomepageDailies(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchHomepageDailies();
              });
            },
            child: ListView.builder(
              itemCount: HomePageDailies.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      sc_width / 50, sc_width / 50, sc_width / 50, 0),
                  child: Container(
                    height: sc_height / 7.5,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 220, 220, 220),
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image:
                                NetworkImage(HomePageDailies[index].dailyurl),
                            fit: BoxFit.cover,
                            opacity: 0.5)),
                    //decoration: BoxDecoration(color: Colors.yellow, borderRadius:BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryPage(
                                username: HomePageDailies[index].username,
                                dailyurl: HomePageDailies[index].dailyurl,
                                profilephotourl:
                                    HomePageDailies[index].profilephotourl),
                          ),
                        );
                        Timer(const Duration(seconds: 3), () {
                          Navigator.pop(context);
                        });
                      },
                      title: Column(
                        children: [
                          CircleAvatar(
                            radius: sc_height / 20,
                            backgroundImage: NetworkImage(
                                HomePageDailies[index].profilephotourl),
                          ),
                          Text(
                            HomePageDailies[index].username,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ));
      },
    );
  }
}













/*BottomNavigationBar(
          fixedColor: Colors.black,
          currentIndex: _currentindex,
          onTap: (int newindex) {
            setState(() {
              _currentindex = newindex;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => pages[_currentindex],
                ),
              );
            });
          },
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: const Icon(
                  Icons.home_filled,
                  color: Colors.black,
                ),
                backgroundColor: bckgrd),
            BottomNavigationBarItem(
                label: 'Explore',
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                backgroundColor: bckgrd),
            BottomNavigationBarItem(
                label: 'Add',
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: bckgrd),
            BottomNavigationBarItem(
                label: 'Minilog',
                icon: const Icon(
                  Icons.library_books,
                  color: Colors.black,
                ),
                backgroundColor: bckgrd),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: const Icon(
                  Icons.account_circle_sharp,
                  color: Colors.black,
                ),
                backgroundColor: bckgrd),
          ],
        )*/