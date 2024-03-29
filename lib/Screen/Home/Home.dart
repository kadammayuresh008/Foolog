import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/BlogCard.dart';
import 'package:foolog/Screen/Helper/UserList.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Profile/Profile.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Chats/chats.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/AddBlog.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Search.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Widget __Story(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 0.0, 0.0),
      child: CircleAvatar(
            backgroundColor: Colors.cyan,
          child:CircleAvatar(
            backgroundColor: Colors.white,
            child:ClipRRect(
              borderRadius: BorderRadius.circular(70.0),
              child: Image.network(
                "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                height: 70.0,
                width:70.0,
              ),
            ),
            radius:35.0,
          ),
            radius:40.0,
          ),
    );
  }

  Widget _HorizontalScroller(){
    return Container(
      child:ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          __Story(),
          __Story(),
          __Story(),
          __Story(),
          __Story(),
          __Story(),

        ],
      ),
      color: Colors.white,
      width: double.infinity,
      height: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return StreamProvider<QuerySnapshot>.value(
      value:blogManagement().Blog,
      child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title:Text("Foolog"),
              actions: <Widget>[
                IconButton(icon:Icon(Icons.message,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      },
                    ),
      IconButton(icon:Icon(Icons.search,size: 30.0,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                    ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(uid:_auth.currentUser.uid)),
                    );
                  },
                  child:CircleAvatar(
                    backgroundColor: Colors.white,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                        height: 40.0,
                        width:70.0,
                      ),
                    ),
                    radius:20.0,
                  ),
                )
              ],
            ),
        body:BlogCard(),
        floatingActionButton: Container(
          height: 60.0,
          width:60.0,
          child: FloatingActionButton(
            child:Icon(Icons.add,size: 40.0,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBlog()),
              );
            },
            backgroundColor: Colors.cyan,
          ),
        ),
          ),
    );
  }
}


