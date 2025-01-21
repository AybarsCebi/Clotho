import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modaapp/AccountPage.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/Adv.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogDetail.dart';
import 'package:modaapp/constraints.dart';
import 'package:modaapp/PodcastPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MiniBlogPage extends StatefulWidget {
  const MiniBlogPage({super.key});

  @override
  State<MiniBlogPage> createState() => _MiniBlogPageState();
}

class _MiniBlogPageState extends State<MiniBlogPage> {
  int _currentindex = 3;
  var pages = [
    HomePage(),
    ExplorePage(),
    AddPage(),
    MiniBlogPage(),
    AccountPage()
  ];
  Color bckgrd = Color.fromARGB(255, 235, 235, 235);
  Color gold = Color.fromARGB(255, 175, 168, 42);
  bool mini = true;
  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);

    return SafeArea(
      child: Scaffold(
        /*floatingActionButton: IconButton(
          splashColor: Colors.transparent,
          splashRadius: 1,
          visualDensity: VisualDensity.standard,
          icon: const Icon(Icons.add_circle_outlined),
          iconSize: 55,
          color: Colors.black,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Add your Miniblog"),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Title",
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Miniblog",
                              icon: Icon(Icons.library_books),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text("Press"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),*/
        backgroundColor: bckgrd,
        
        body: MiniblogPageContents(sc_height: sc_height, sc_width: sc_width),
        /*bottomNavigationBar: CurvedNavigationBar(
        index: 3,
        height: 55,
        backgroundColor: bckgrd,
        color: darkcolor,
        items: <Widget>[
          Icon(Icons.home_filled, size: 27, color: bckgrd,),
          Icon(Icons.search, size: 27, color: bckgrd,),
          Icon(Icons.add, size: 27, color: bckgrd,),
          Icon(Icons.library_books, size: 17, color: bckgrd,),
          Icon(Icons.account_circle_sharp, size: 27, color: bckgrd,),
        ],
        onTap: (newindex) {
          //Handle button tap
          setState(() {
            _currentindex = newindex;

            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => pages[_currentindex],
              ),
            );
          });
        },
      )*/
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
                label: 'Miniblog',
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
      ),
    );
  }

  
}

class MiniblogPageContents extends StatelessWidget {
  const MiniblogPageContents({
    super.key,
    required this.sc_height,
    required this.sc_width,
  });

  final double sc_height;
  final double sc_width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, sc_height / 60, 0, 0),
            child: SizedBox(
              height: sc_height / 16,
              width: sc_width * 9.5 / 10,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashRadius: 1,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    color: Colors.grey,
                    iconSize: 35,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Search",
                ),
              ),
            ),
          ),
          SizedBox(
            height: sc_height / 60,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bloginfo().authors.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            sc_width / 40, 0, sc_width / 40, 0),
                        child: Container(
                          height: sc_height / 8,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 220, 220, 220),
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/miniblogpic$index.jpg'),
                                  fit: BoxFit.cover,
                                  opacity: 0.20)),
                          //decoration: BoxDecoration(color: Colors.yellow, borderRadius:BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MiniBlogDetail(blognumber: index),
                                ),
                              );
                            },
                            leading: Image(
                              width: sc_height / 12,
                              height: sc_height / 10,
                              image: AssetImage('images/miniblogpic$index.jpg'),
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              bloginfo().titles[index],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Author: ${bloginfo().authors[index]}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 80, 80, 80),
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              bloginfo().reads[index].toString() + " reads",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sc_height / 160,
                      ),
                      /*Divider(
                        height: 15,
                        color: Colors.black,
                      ),*/
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class PodcastPageContents extends StatelessWidget {
  PodcastPageContents({
    super.key,
    required this.sc_height,
    required this.sc_width,
  });
  final double sc_height;
  final double sc_width;

  @override
  Widget build(BuildContext context) {
    Color gold = Color.fromARGB(255, 175, 168, 42);
    return Center(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, sc_height / 60, 0, 0),
          child: SizedBox(
            height: sc_height / 16,
            width: sc_width * 9.5 / 10,
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  splashRadius: 1,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  color: Colors.grey,
                  iconSize: 35,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: "Search podcast",
              ),
            ),
          ),
        ),
        SizedBox(
          height: sc_height / 60,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: podcastinfo().voices.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          sc_width / 40, 0, sc_width / 40, 0),
                      child: Container(
                        height: sc_height / 8,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 220, 220, 220),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image:
                                    AssetImage('images/miniblogpic$index.jpg'),
                                fit: BoxFit.cover,
                                opacity: 0.20)
                                ),
                        //decoration: BoxDecoration(color: Colors.yellow, borderRadius:BorderRadius.circular(10)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MiniBlogDetail(blognumber: index),
                              ),
                            );
                          },
                          leading: IconButton(
                            icon: Icon(Icons.play_arrow_rounded),
                            color: Colors.black,
                            iconSize: 45,
                            onPressed: () {
                              debugPrint("Podcast will start");
                            },
                          ),
                          title: Text(
                            podcastinfo().titles[index],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Recorder: ${podcastinfo().voices[index]}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 80, 80, 80),
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Image(
                            width: sc_height / 12,
                            height: sc_height / 10,
                            image: AssetImage('images/miniblogpic$index.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sc_height / 160,
                    ),
                    /*Divider(
                            height: 15,
                            color: Colors.black,
                          ),*/
                  ],
                );
              }),
        ),
      ],
    ));
  }
}

/*automaticallyImplyLeading: false,
                  elevation: 2,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              mini = true;
                              debugPrint(mini.toString());
                            });
                          },
                          child: (mini == true)
                              ? const Text(
                                  "Miniblog",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                )
                              : const Text(
                                  "Miniblog",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16),
                                )),
                      //SizedBox(width: sc_width/6,),
                      const VerticalDivider(
                        thickness: 5,
                        color: Colors.black,
                      ),
                      //SizedBox(width: sc_width/6,),
                      TextButton(
                          style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PodcastPage(),
                              ),
                            );
                            setState(() {
                              mini = false;
                              debugPrint(mini.toString());
                            });
                          },
                          child: (mini == false)
                              ? const Text(
                                  "Podcast",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                )
                              : const Text(
                                  "Podcast",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16),
                                )),
                    ],
                  ),
                  backgroundColor: bckgrd,
                  actions: [],),*/