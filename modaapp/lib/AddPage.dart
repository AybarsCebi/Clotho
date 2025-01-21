import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modaapp/AccountPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:modaapp/constraints.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  File? image;
  Future pickImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }
  int _currentindex = 2;
  var pages = [HomePage(), ExplorePage(), AddPage(), MiniBlogPage(), AccountPage()];
  Color bckgrd = Color.fromARGB(255, 235, 235, 235);
  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return SafeArea(child: Scaffold(
      backgroundColor: bckgrd,
      body: AddPageBody(sc_width, sc_height),
      /*bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          height: 55,
          backgroundColor: bckgrd,
          color: darkcolor,
          items: <Widget>[
            Icon(Icons.home_filled, size: 27, color: bckgrd,),
            Icon(Icons.search, size: 27, color: bckgrd,),
            Icon(Icons.add, size: 17, color: bckgrd,),
            Icon(Icons.library_books, size: 27, color: bckgrd,),
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
    ));
  }

  Column AddPageBody(double sc_width, double sc_height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,    
      children: [
        Padding(
          padding: const EdgeInsets.only(left:100),
          child: TextButton(onPressed: pickImageCamera, child: Text("Add image from camera", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(Color.fromARGB(255, 105, 105, 105)),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(sc_width/2, sc_height / 16),
                    )),),
        ),
                  SizedBox(height: sc_height/200,),
        Padding(
          padding: const EdgeInsets.only(left:100),
          child: TextButton(onPressed: pickImageGallery, child: Text("Add image from gallery", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(Color.fromARGB(255, 105, 105, 105)),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(sc_width/2, sc_height / 16),
                    )),),
        ),
      ],
    );
  }
}