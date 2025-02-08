import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Post{
  String contenturl, outfitaccesories, outfitlower, outfitshoes, outfitupper, profilephotourl, username;
  double commentnumber, iconnumber, likenumber;
  bool isexpert, isfollow;
  Post(this.commentnumber, this.contenturl, this.iconnumber, this.isexpert, this.isfollow, this.likenumber, this.outfitaccesories, this.outfitlower, this.outfitshoes, this.outfitupper, this.profilephotourl, this.username);
}

class HomePagePostModel{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Post> homepageposts=[];
  Future<List<Post>> fetchHomepagePosts() async{
    var allposts=await _firestore.collection('homepageposts').get();
    homepageposts=allposts.docs.map((e) {
      final postData=e.data();
      final res=Post(postData['commentnumber'], postData['contenturl'].toString(), postData['iconnumber'], 
      postData['isexpert'], postData['isfollow'], postData['likenumber'], postData['outfitaccesories'].toString(), 
      postData['outfitlower'].toString(), postData['outfitshoes'].toString(), postData['outfitupper'].toString(), 
      postData['profilephotourl'].toString(), postData['username'].toString());
      return res;
    }).toList();
    return homepageposts;
  }
}

Future<void> addUserToFirebase(String username, String email, String uid) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'followers': [],
      'following': [],
      'posts': [],
      'dailies': [],
      'saved': [],
      'profilepic': "",
      'personalDescription': "ilk hesap"
    });
    debugPrint("✅ Kullanıcı Firestore'a başarıyla eklendi.");
  } catch (e) {
    debugPrint("❌ Firestore'a eklenirken hata oluştu: $e");
  }
}

