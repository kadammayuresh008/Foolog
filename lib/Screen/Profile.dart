import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Gridview.dart';
import 'package:foolog/Screen/Login.dart';
import 'package:foolog/Services/Auth.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget __GalleryRow()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Image.asset("assets/Images/Image2.jfif",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
          Image.asset("assets/Images/Image2.jfif",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
          Image.asset("assets/Images/Image2.jfif",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget __ProfileTop(){
    return Container(
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Column(
                children:<Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(70.0),
                      child: Image.network(
                        "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                        height: 70.0,
                        width:70.0,
                      ),
                    ),
                    radius:40.0,
                  ),
                  SizedBox(height:5.0),
                  Text(
                    "Soul Travel",
                      style:TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]
            ),
            Column(
              children:<Widget>[
                SizedBox(height: 10.0,),
            Text(
                  "17",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              Text(
                  "Post",
              ),
        ]
            ),
            Column(
                children:<Widget>[
                  SizedBox(height: 10.0,),
                  Text(
                      "552",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
                  Text(
                    "Follower",
                  ),
                ]
            ),
            Column(
                children:<Widget>[
                  SizedBox(height: 10.0,),
                  Text(
                      "600",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
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

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          leading:IconButton(icon:Icon(Icons.arrow_back),
            onPressed: () {
              print("Back");
              Navigator.pop(context);
            },),
          title:Text("Profile"),
          actions: [
            IconButton(icon:Icon(Icons.menu), onPressed: () async{
              await AuthService().Signout();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login())
              );
            })
          ],
        ),
      body:
      Column(
        children:<Widget>[
          __ProfileTop(),
          Row(
              mainAxisAlignment:MainAxisAlignment.center,
            children:<Widget>[
              ButtonTheme(
                minWidth: 350.0,
                child: OutlineButton(
                child:Text('Edit Profile',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                highlightedBorderColor:Colors.white,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },),),
            ],
          ),
          // ListView(
          //   scrollDirection: Axis.vertical,
          //   children:<Widget>[
          //             __GalleryRow(),
          //             __GalleryRow(),
          //             __GalleryRow(),
          //             __GalleryRow(),
          //             __GalleryRow(),
          //             __GalleryRow(),
          //           ],
          //     )
      // Row(
      //   children:<Widget>[
      //     IconButton(
      //         icon:Icon(Icons.grid_on_outlined),
      //         iconSize: 30.0,
      //     ),
      //     IconButton(
      //         icon:Icon(Icons.image_outlined),
      //         iconSize: 30.0,
      //     ),
      //   ]
      // ),
      //     SingleChildScrollView(
      //       child:Gridview(),
      //     ),
    ],
      )
    );
  }
}
