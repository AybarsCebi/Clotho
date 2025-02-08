import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  int _currentindex = 3;
  var pages = [HomePage(), ExplorePage(), AddPage(), AccountPage()];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>?;
        });
        debugPrint("Posts: ${_userData?['posts']}");
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double sc_height = MediaQuery.of(context).size.height;
    double sc_width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bckgrd,
        body: _userData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sc_height / 50),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        _userData!['username'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: sc_height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: sc_height / 14,
                          backgroundImage: _userData!['profilepic'] != null &&
                                  _userData!['profilepic'].isNotEmpty
                              ? NetworkImage(_userData!['profilepic'])
                              : AssetImage("images/clothoapp.png")
                                  as ImageProvider,
                        ),
                        Text(
                            "${(_userData!['followers']?.length ?? 0)}\n Followers",
                            textAlign: TextAlign.center),
                        Text("${_userData!['posts']?.length ?? 0}\n Posts",
                            textAlign: TextAlign.center),
                        Text(
                            "${_userData!['following']?.length ?? 0}\n Followings",
                            textAlign: TextAlign.center),
                      ],
                    ),
                    SizedBox(height: sc_height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: logOut,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(darkcolor),
                            foregroundColor: WidgetStatePropertyAll(bckgrd),
                          ),
                          child: Text("Log Out"),
                        ),
                      ],
                    ),
                    Divider(
                      color: darkcolor,
                      thickness: 0.5,
                    ),
                    GridView.count(
                      mainAxisSpacing: sc_width/100,
                      crossAxisSpacing: sc_width/100,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      children:
                          (_userData!['posts'] ?? []).map<Widget>((photoUrl) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            photoUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print(
                                  "Resim yüklenemedi: $error"); // Hata mesajı ekleme
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
