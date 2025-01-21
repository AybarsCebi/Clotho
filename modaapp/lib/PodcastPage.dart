import 'package:flutter/material.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogDetail.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'package:modaapp/constraints.dart';
import 'package:palette_generator/palette_generator.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({super.key});

  @override
  State<PodcastPage> createState() => _MiniBlogPageState();
}

class _MiniBlogPageState extends State<PodcastPage> {
  int _currentindex = 3;
  var pages = [
    HomePage(),
    ExplorePage(),
    AddPage(),
    MiniBlogPage(),
    LoginPage()
  ];
  Color bckgrd = Color.fromARGB(255, 235, 235, 235);
  Color gold = Color.fromARGB(255, 175, 168, 42);
  bool mini = false;
  List<PaletteColor> podcastcolors = [];
  List<String> blogimages = [
    "miniblogpic0.jpg",
    "miniblogpic1.jpg",
    "miniblogpic2.jpg",
    "miniblogpic3.jpg"
  ];
  _updatecolors() async {
    for (String img in blogimages) {
      final PaletteGenerator generator =
          await PaletteGenerator.fromImageProvider(AssetImage('images/$img'));
    }
  }
  bool podcaststart=false;

  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          splashColor: Colors.transparent,
          splashRadius: 1,
          visualDensity: VisualDensity.standard,
          icon: const Icon(Icons.add_circle_outlined),
          iconSize: 55,
          color: Colors.black,
          onPressed: () {
            /*showDialog(
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
            );*/
          },
        ),
        backgroundColor: bckgrd,
        body: Center(
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
                                leading: IconButton(
                                  icon: (podcaststart==false)?Icon(Icons.play_arrow_rounded):Icon(Icons.stop),
                                  color: gold,
                                  iconSize: 45,
                                  onPressed: () {
                                    setState(() {
                                      podcaststart=!podcaststart;
                                    });
                                    debugPrint("Podcast will start");
                                  },
                                ),
                                title: Text(
                                  podcastinfo().titles[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                  image: AssetImage(
                                      'images/miniblogpic$index.jpg'),
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
          )),
        
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }
}