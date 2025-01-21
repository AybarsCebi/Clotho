import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/constraints.dart';

class StoryPage extends StatefulWidget{
  String username, dailyurl, profilephotourl;
  StoryPage({
    super.key, 
    required this.dailyurl,
    required this.profilephotourl,
    required this.username
    });

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>  with TickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);

    

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkcolor,
        body: Column(
          children: [
            Stack(
              children: [
                
                LinearProgressIndicator(
                  minHeight: sc_height/200,
                  color: Colors.blue,
                  backgroundColor: bckgrd,
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                          ),
                Column(   
                  children: [
                  Padding(
                  padding: EdgeInsets.fromLTRB(0, sc_height/200,
                      0, 0), //eskisi sc_width/40
                  child: Container(
                    height: sc_height / 20,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 220, 220, 220),
                        ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: sc_width/80,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.profilephotourl),
                          radius: sc_height / 70,
                        ),
                        SizedBox(
                          width: sc_width/200,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                          ),
                          child: Text(
                            widget.username,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),

                Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: sc_height*91/100,
                  child: Image(image: NetworkImage(widget.dailyurl), fit: BoxFit.cover,)),
                  ),
                ],)
                /*Padding(
                padding: EdgeInsets.fromLTRB(sc_width/40, sc_height/5, sc_width/40,0),
                child: Image(image: AssetImage("images/post${widget.account}.jpg")),
                  ),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(sc_width / 40, sc_height*15/100,
                      sc_width / 40, 0), //eskisi sc_width/40
                  child: Container(
                    height: sc_height / 20,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 220, 220, 220),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('images/post${widget.account}.jpg'),
                          radius: sc_height / 70,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                          ),
                          child: Text(
                            Constraints().usernames[widget.account],
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
