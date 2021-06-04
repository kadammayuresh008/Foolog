import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Profile/EditProfile.dart';
import 'package:provider/provider.dart';



class ProfileTop extends StatefulWidget {
  @override
  _ProfileTopState createState() => _ProfileTopState();
}

class _ProfileTopState extends State<ProfileTop> {
  @override
  Widget build(BuildContext context){
    final _auth = FirebaseAuth.instance;
    final userDetails = Provider.of<QuerySnapshot>(context);
    var username;
    String bio;
    int Followers;
    int Following;
    int Posts;

    if(userDetails==null){
      return Center(
          child: CircularProgressIndicator()
      );
    }
    for (var index = 0; index < userDetails.docs.length; index++) {
      var x = userDetails.docs[index]["uid"];
      if (x == _auth.currentUser.uid) {
        username = userDetails.docs[index]["username"];
        bio =userDetails.docs[index]["bio"];
        Followers=userDetails.docs[index]["Followers"];
        Following=userDetails.docs[index]["Following "];//if shows error see the spacing after Following word.
        Posts=userDetails.docs[index]["Post"];
      }
      else{
        continue;
      }
    }
      return userDetails==null?CircularProgressIndicator():Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(140.0),
                          child: Image.network(
                            "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                            height: 140.0,
                            width: 140.0,
                          ),
                        ),
                        radius: 70.0,
                      ),
                      SizedBox(height: 5.0),
                      Column(
                        children: [
                          Text(
                            username??"",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            bio??"",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                            Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0,),
                                  Text(
                                      Posts.toString(), style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25.0,
                                    color: Colors.white,
                                  )),
                                  Text(
                                    "Post",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                            ),
                            Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0,),
                                  Text(
                                      Followers.toString(), style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25.0)),
                                  Text(
                                    "Follower",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                            ),
                            Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0,),
                                  Text(
                                      Following.toString(), style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25.0)),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                        children:<Widget>[
                          ButtonTheme(
                            minWidth: 100.0,
                            child: OutlineButton(
                            child:Text('Edit Profile',
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:Colors.white,
                                )),
                            highlightedBorderColor:Colors.white,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProfile()),
                              );
                            },),),
                        ],
                    ),
                     ),
              ],
            ),
          )
      );
    }
  }
