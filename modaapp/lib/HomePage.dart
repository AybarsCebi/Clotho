import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
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

  List<Map<String, dynamic>> homepage_posts = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  Future<void> _loadHomePagePosts() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();

      if (userDoc.exists) {
        List<dynamic> followingList = userDoc.get('following') ?? [];

        if (followingList.isNotEmpty) {
          QuerySnapshot postSnapshot = await _firestore
              .collection('all_posts')
              .where('username', whereIn: followingList)
              .get();

          // Belge kimliğini (id) veriye ekliyoruz
          List<Map<String, dynamic>> posts = postSnapshot.docs
              .map((doc) => {
                    ...doc.data() as Map<String, dynamic>,
                    'postId': doc.id, // Belge kimliğini ekledik
                  })
              .toList();

          setState(() {
            _userData = userDoc.data() as Map<String, dynamic>?;
            homepage_posts = posts;
          });

          debugPrint("Takip Edilen Kullanıcıların Postları: $homepage_posts");
        }
      }
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

  Future<void> updateLike(String postId, int index) async {
  try {
    DocumentReference postRef = _firestore.doc('all_posts/$postId');
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) return;

    // Kullanıcı adı bilgisi için kullanıcı verisini çek
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    String username = userDoc.get('username') ?? 'Anonim';

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(postRef);

      if (!snapshot.exists) return;

      int currentLikes = snapshot.get('likenumber') ?? 0;

      // Beğenilip beğenilmediğini kontrol et
      List<dynamic> likedByList = snapshot.get('likedby') ?? [];
      bool isLiked = likedByList.any((item) {
        if (item is Map<String, dynamic>) {
          return item['userId'] == userId;
        }
        return false;
      });

      if (isLiked) {
        // Mevcut kullanıcıyı "likedby" listesinden çıkar
        likedByList.removeWhere((item) {
          if (item is Map<String, dynamic>) {
            return item['userId'] == userId;
          }
          return false;
        });
        transaction.update(postRef, {
          'likenumber': currentLikes - 1,
          'likedby': likedByList,
        });

        // Local state'i güncelle
        setState(() {
          homepage_posts[index]['likenumber'] = currentLikes - 1;
          homepage_posts[index]['likedby'] = likedByList;
        });

      } else {
        // Yeni beğeni yap
        likedByList.add({'userId': userId, 'username': username});
        transaction.update(postRef, {
          'likenumber': currentLikes + 1,
          'likedby': likedByList,
        });

        // Local state'i güncelle
        setState(() {
          homepage_posts[index]['likenumber'] = currentLikes + 1;
          homepage_posts[index]['likedby'] = likedByList;
        });
      }
    });

    debugPrint("Beğeni güncellendi.");
  } catch (e) {
    debugPrint("Hata: $e");
  }
}


Future<void> updateIcon(String postId, int index) async {
  try {
    DocumentReference postRef = _firestore.doc('all_posts/$postId');
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) return;

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    String username = userDoc.get('username') ?? 'Anonim';

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(postRef);

      if (!snapshot.exists) return;

      int currentIcons = snapshot.get('iconnumber') ?? 0;

      List<dynamic> iconbyList = snapshot.get('iconby') ?? [];
      bool isIcon = iconbyList.any((item) {
        if (item is Map<String, dynamic>) {
          return item['userId'] == userId;
        }
        return false;
      });

      if (isIcon) {
        // Mevcut kullanıcıyı "likedby" listesinden çıkar
        iconbyList.removeWhere((item) {
          if (item is Map<String, dynamic>) {
            return item['userId'] == userId;
          }
          return false;
        });
        transaction.update(postRef, {
          'iconnumber': currentIcons - 1,
          'iconby': iconbyList,
        });

        // Local state'i güncelle
        setState(() {
          homepage_posts[index]['iconnumber'] = currentIcons - 1;
          homepage_posts[index]['iconby'] = iconbyList;
        });

      } else {
        // Yeni beğeni yap
        iconbyList.add({'userId': userId, 'username': username});
        transaction.update(postRef, {
          'iconnumber': currentIcons + 1,
          'iconby': iconbyList,
        });

        // Local state'i güncelle
        setState(() {
          homepage_posts[index]['iconnumber'] = currentIcons + 1;
          homepage_posts[index]['iconby'] = iconbyList;
        });
      }
    });

    debugPrint("Icon güncellendi.");
  } catch (e) {
    debugPrint("Hata: $e");
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
    //const AddPage(),
    //const MiniBlogPage(),
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
    _loadHomePagePosts();
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

  RefreshIndicator homepageposts(double sc_width, double sc_height) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _loadHomePagePosts();
        });
      },
      child: homepage_posts.isEmpty
          ? Center(
              child: Text("Takip ettiğiniz kişilerin gönderisi bulunamadı."))
          : ListView.builder(
              key: const PageStorageKey<String>('homepage'),
              itemCount: homepage_posts.length,
              itemBuilder: (context, index) {
                return Center(
                    child: Column(
                  children: [
                    SizedBox(height: sc_height / 100),
                    Container(
                      width: sc_width * 0.94,
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
                                (_userData?['profilepic'] != null)
                                    ? _userData!['profilepic']
                                    : blank_profile_url),
                            //AssetImage("images/ticklogo.png"),
                            radius: sc_height / 70,
                          ),
                          SizedBox(
                            width: sc_width / 50,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                            ),
                            child: Text(
                              homepage_posts[index]['username'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          /*TextButton(
                              onPressed: () {
                              },
                              style: const ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                    Colors.transparent),
                              ),
                              child: Text("Follow")      
                            )*/
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        homepage_posts[index]['postUrl'] ?? ""),
                                    //image: AssetImage("images/ticklogo.png"),
                                    fit: BoxFit.cover)),
                            width: (MediaQuery.of(context).size.width) *
                                0.94, //eskisi 9.5
                            height: (MediaQuery.of(context).size.height) * 0.65,
                            child: FilledButton(
                              onPressed: () {},
                              onLongPress: () {},
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(sc_width * 8.2 / 10,
                              sc_height / 6, 0, 0), //eskisi 8
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
                                    final postId =
                                        homepage_posts[index]['postId'];
                                    if (postId != null && postId is String) {
                                      updateLike(postId, index);
                                    } else {
                                      debugPrint("Geçersiz veya boş Post ID!");
                                    }
                                  },
                                  icon: Icon(
                                    homepage_posts[index]['likedby']?.any(
                                                (item) =>
                                                    item is Map<String,
                                                        dynamic> &&
                                                    item['userId'] ==
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid) ??
                                            false
                                        ? Icons
                                            .favorite 
                                        : Icons
                                            .favorite_border, 
                                    color: homepage_posts[index]['likedby']
                                                ?.any((item) =>
                                                    item is Map<String,
                                                        dynamic> &&
                                                    item['userId'] ==
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid) ??
                                            false
                                        ? Colors.red // Beğenilmişse kırmızı
                                        : Colors.white, // Beğenilmemişse beyaz
                                  ),
                                ),
                                Text(
                                  homepage_posts[index]['likenumber']
                                          ?.toString() ??
                                      '0',
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
                                  homepage_posts[index]['comments']
                                      .length
                                      .toString(),
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
                                    final postId =
                                        homepage_posts[index]['postId'];
                                    if (postId != null && postId is String) {
                                      updateIcon(postId, index);
                                    } else {
                                      debugPrint("Geçersiz veya boş Post ID!");
                                    }
                                  },
                                  icon: Icon(
                                    homepage_posts[index]['iconby']?.any(
                                                (item) =>
                                                    item is Map<String,
                                                        dynamic> &&
                                                    item['userId'] ==
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid) ??
                                            false
                                        ? Icons
                                            .star
                                        : Icons
                                            .star_border, 
                                    color: homepage_posts[index]['iconby']
                                                ?.any((item) =>
                                                    item is Map<String,
                                                        dynamic> &&
                                                    item['userId'] ==
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid) ??
                                            false
                                        ? Colors.yellow // Beğenilmişse kırmızı
                                        : Colors.white, // Beğenilmemişse beyaz
                                  ),
                                  
                                ),
                                Text(
                                  homepage_posts[index]['iconnumber']
                                          ?.toString() ??
                                      '0',
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
                                                homepage_posts[index]['detail'],
                                                style:
                                                    GoogleFonts.dancingScript(
                                                        fontSize: 24,
                                                        color: darkcolor)),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: const ButtonStyle(
                                                overlayColor:
                                                    WidgetStatePropertyAll(
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
                        SizedBox(height: sc_height / 100),
                      ],
                    ),
                    Divider(
                      thickness: 0.8,
                    ),
                  ],
                ));
              },
            ),
    );
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
