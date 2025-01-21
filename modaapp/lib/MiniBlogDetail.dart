import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modaapp/constraints.dart';

class MiniBlogDetail extends StatefulWidget {
  int blognumber;
  MiniBlogDetail({super.key, required this.blognumber});

  @override
  State<MiniBlogDetail> createState() => _MiniBlogDetailState();
}

class _MiniBlogDetailState extends State<MiniBlogDetail> {
  Color bckgrd = Color.fromARGB(255, 235, 235, 235);
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 35,
                    icon: Icon(Icons.arrow_back_ios_sharp, color: darkcolor,)),
                Row(
                  children: [
                    CircleAvatar(
                            backgroundImage:
                                AssetImage('images/post${widget.blognumber}.jpg'),
                            radius: sc_height / 60,
                          ),
                  
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Text(
                        "${bloginfo().authors[widget.blognumber]}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 80, 80, 80)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: sc_height / 150),
            Text(
              bloginfo().titles[widget.blognumber],
              style: GoogleFonts.dancingScript(
                  fontWeight: FontWeight.bold, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: sc_height / 50,
            ),
            Image(
              image: AssetImage('images/miniblogpic${widget.blognumber}.jpg'),
              height: sc_height / 3,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Column(
                children: [
                  SizedBox(
                    height: sc_height / 50,
                  ),
                  Text(
                    bloginfo().details[widget.blognumber],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: sc_height / 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(bloginfo().dates[widget.blognumber]),
                    Text(
                      "${bloginfo().reads[widget.blognumber]} reads   ${bloginfo().reads[widget.blognumber]} likes",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 80, 80, 80)),
                    ),
                  ],),
                  
                  SizedBox(
                    height: sc_height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {
                            debugPrint("Liked the post");
                            setState(() {
                              liked = !liked;
                            });
                          },
                          icon: (liked == false)
                              ? Icon(
                                  Icons.favorite_outline_outlined,
                                  color: darkcolor,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {
                            debugPrint("Shared the post");
                          },
                          icon: Icon(
                            Icons.share,
                            color: darkcolor,
                          )),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {
                            debugPrint("Written comment about the post");
                          },
                          icon: Icon(
                            Icons.comment_outlined,
                            //color: Color.fromARGB(255, 105, 105, 105),
                            color: darkcolor,
                          )),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {
                            debugPrint("Saved the post");
                          },
                          icon: Image.asset('images/savedicon.png'), color: darkcolor,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
