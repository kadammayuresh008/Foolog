import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTop extends StatefulWidget {
  @override
  _ProfileTopState createState() => _ProfileTopState();
}

class _ProfileTopState extends State<ProfileTop> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final userDetails = Provider.of<QuerySnapshot>(context);
    var username;
    for (var index = 0; index < userDetails.docs.length; index++) {
      var x = userDetails.docs[index]["uid"];
      if (x == _auth.currentUser.uid) {
        username = userDetails.docs[index]["username"];
      }
    }
      return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70.0),
                          child: Image.network(
                            "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                            height: 70.0,
                            width: 70.0,
                          ),
                        ),
                        radius: 40.0,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        username??"",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]
                ),
                Column(
                    children: <Widget>[
                      SizedBox(height: 10.0,),
                      Text(
                          "17", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0)),
                      Text(
                        "Post",
                      ),
                    ]
                ),
                Column(
                    children: <Widget>[
                      SizedBox(height: 10.0,),
                      Text(
                          "552", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0)),
                      Text(
                        "Follower",
                      ),
                    ]
                ),
                Column(
                    children: <Widget>[
                      SizedBox(height: 10.0,),
                      Text(
                          "600", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0)),
                      Text(
                        "Following",
                      ),
                    ]
                ),
              ],
            ),
          )
      );
    }
  }
