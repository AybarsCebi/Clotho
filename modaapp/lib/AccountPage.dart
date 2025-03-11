import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'constraints.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentindex = 2;
  var pages = [HomePage(), ExplorePage(), AddPage(), AccountPage()];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;
  List<Map<String, dynamic>>? _userPosts;
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
      String? username = userDoc.get('username');  
      if (username != null) {
        QuerySnapshot postSnapshot = await _firestore
            .collection('all_posts')
            .where('username', isEqualTo: username)
            .get();

        List<Map<String, dynamic>> posts = postSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>?;
          _userPosts = posts;
        });

        debugPrint("Kullanıcı Postları: $_userPosts");
      }
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

  Future<void> cameraImageAndUpload() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File file = File(image.path);

      // Firebase Storage'a yükleme
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$fileName.jpg');
        await ref.putFile(file);

        String downloadURL = await ref.getDownloadURL();
        debugPrint("Fotoğraf yüklendi: $downloadURL");

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentReference userDoc =
              FirebaseFirestore.instance.collection('users').doc(user.uid);

          await userDoc.update({
            "posts": FieldValue.arrayUnion([downloadURL])
          });

          debugPrint("Fotoğraf Firestore'a eklendi!");
        } else {
          debugPrint("Kullanıcı giriş yapmamış.");
        }
      } catch (e) {
        debugPrint("Hata: $e");
      }
    }
  }

  Future<void> pickAndUploadImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    UploadTask? uploadTask;
    if (image != null) {
      File file = File(image.path);

      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final ref =
            FirebaseStorage.instance.ref().child('images/$fileName.jpg');
        await ref.putFile(file);
        final snapshot = await uploadTask!.whenComplete(() {});

        String downloadURL = await ref.getDownloadURL();
        debugPrint("Fotoğraf yüklendi: $downloadURL");

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentReference userDoc =
              FirebaseFirestore.instance.collection('users').doc(user.uid);

          await userDoc.update({
            "posts": FieldValue.arrayUnion([downloadURL])
          });

          debugPrint("Fotoğraf Firestore'a eklendi!");
        } else {
          debugPrint("Kullanıcı giriş yapmamış.");
        }
      } catch (e) {
        debugPrint("Hata: $e");
      }
    }
  }

  void testStorageConnection() {
    try {
      final storage = FirebaseStorage.instance;
      debugPrint("Firebase Storage bağlantısı başarılı: ${storage.app.name}");
    } catch (e) {
      debugPrint("Firebase Storage bağlantı hatası: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double sc_height = MediaQuery.of(context).size.height;
    double sc_width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bckgrd,
        floatingActionButton: SpeedDial(
          childrenButtonSize: Size(sc_width / 6, sc_width / 6),
          buttonSize: Size(sc_width / 6, sc_width / 6),
          elevation: 5.0,
          foregroundColor: bckgrd,
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: darkcolor,
          children: [
            SpeedDialChild(
              shape: CircleBorder(),
              foregroundColor: bckgrd,
              child: Icon(Icons.camera_alt),
              backgroundColor: darkcolor,
              onTap: () {
                cameraImageAndUpload();
              },
            ),
            SpeedDialChild(
              shape: CircleBorder(),
              foregroundColor: bckgrd,
              child: Icon(Icons.photo_library),
              backgroundColor: darkcolor,
              onTap: () {
                // Galeri açma işlemi burada olacak
                pickAndUploadImage(ImageSource.gallery);
              },
            ),
          ],
        ),
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
                        Text("${_userData!['postnumber'] ?? 0}\n Posts",
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
                            backgroundColor: WidgetStatePropertyAll(darkcolor),
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
                      crossAxisSpacing: sc_width / 200,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      children: (_userPosts ?? []).map<Widget>((post) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            post[
                                'postUrl'], 
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
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
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
