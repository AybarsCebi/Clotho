import 'package:flutter/material.dart';
import 'constraints.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _currentindex = 0;
  late String picname;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.message)),
            ),
          ],
          title: const Text("Fashion App"),
          backgroundColor: Colors.purple[600],
          centerTitle: false,
        ),
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height:10),
                  User(username: Constraints().usernames[index],),
                  const SizedBox(height: 5,),
                  Post(picname: 'images/post${index}.jpg',),
                  const SizedBox(height:5),
                  const PostFunc(),
                  const CommentArea(),
                  const SizedBox(height:20),
                ],
              ),
            );
          },
          
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple[200],
          currentIndex: _currentindex,
          onTap: (int newindex) {
            setState(() {
              _currentindex = newindex;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: const Icon(Icons.home_filled),
                backgroundColor: Colors.purple[600]),
            BottomNavigationBarItem(
                label: 'Discover',
                icon: const Icon(Icons.search),
                backgroundColor: Colors.purple[600]),
            BottomNavigationBarItem(
                label: 'Add',
                icon: const Icon(Icons.add),
                backgroundColor: Colors.purple[600]),
            BottomNavigationBarItem(
                label: 'Blog',
                icon: const Icon(Icons.library_books),
                backgroundColor: Colors.purple[600]),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: const Icon(Icons.account_circle_sharp),
                backgroundColor: Colors.purple[600]),
          ],
        ),
      ),
    );
  }
}

class User extends StatelessWidget {
  User({required this.username, super.key});
  late String username;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Icon(Icons.account_circle_rounded, color: Colors.black,),
            SizedBox(width: 10,),
            Text(username),
          ],
        ),
      ),
    );
  }
}


class Post extends StatelessWidget {
  Post({required this.picname,
    super.key,
  });
  late String picname;
  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    image:
                        DecorationImage(image: AssetImage(picname), fit: BoxFit.fill)),
                width: (MediaQuery.of(context).size.width) * 9.5 / 10,
                height: (MediaQuery.of(context).size.height) * 7 / 10,
              ) ;
  }
}

class PostFunc extends StatelessWidget {
  const PostFunc({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        splashRadius: 10,
                        iconSize: 25,
                        onPressed:() {},
                        icon: const Icon(Icons.favorite),
                        color: Colors.white,
                        focusColor: Colors.red,
                      ),
                      Text("53.281"),
                      IconButton(
                        splashRadius: 10,
                        iconSize: 25,
                        onPressed: (){},
                        icon: const Icon(Icons.comment),
                        color: Colors.blue,
                      ),
                      
                      IconButton(
                        splashRadius: 10,
                        iconSize: 25,
                        onPressed: (){},
                        icon: const Icon(Icons.star),
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              );
  }
}


class CommentArea extends StatelessWidget {
  const CommentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
    child: Container(
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5),
      ),
      width: (MediaQuery.of(context).size.width)*9.5/10,
      height: (MediaQuery.of(context).size.height)/ 10,
      child: const Align(alignment: Alignment.center, child: Text("COMMENT AREA"),),
    ),);
  }
}