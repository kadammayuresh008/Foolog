import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Profile/EditProfile.dart';
// import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Profile/Gridview.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Authentication/Login.dart';
import 'package:foolog/Services/Auth.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';
import 'package:foolog/Screen/Helper/ProfileTop.dart';

import '../Helper/ImageGridView.dart';


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
          Image.network(
            "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
            width: 125,
            height:110,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }


  @override

  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value:UserManagement().UserDetails,
      child:UserManagement().UserDetails==null?Center(
        child:CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
          backgroundColor: Colors.white,
        ),
      ):
      Scaffold(
            appBar:  PreferredSize(
              preferredSize: Size.fromHeight(360.0),
              child: Stack(
                children: [
                  AppBar(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: ProfileTop(),
                  ),
                ],
              ),
            ),
          body:Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageGridView(),
              ),
          // SingleChildScrollView(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children:<Widget>[
          //       Row(
          //           mainAxisAlignment:MainAxisAlignment.center,
          //         children:<Widget>[
          //           ButtonTheme(
          //             minWidth: 350.0,
          //             child: OutlineButton(
          //             child:Text('Edit Profile',
          //                 style:TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                 )),
          //             highlightedBorderColor:Colors.white,
          //             color: Colors.white,
          //             onPressed: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) => EditProfile()),
          //               );
          //             },),),
          //         ],
          //       ),
              // SizedBox(height:20.0),
              //   __GalleryRow(),
              //   __GalleryRow(),
              //   __GalleryRow(),
              //   __GalleryRow(),
              //   __GalleryRow(),
              //   __GalleryRow(),
              //   ImageGridView(),
              //   Row(
              //     mainAxisAlignment:MainAxisAlignment.center,
              //     children:<Widget>[
              //       ButtonTheme(
              //         minWidth: 350.0,
              //         child: OutlineButton(
              //           child:Text('Edit Profile',
              //               style:TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               )),
              //           highlightedBorderColor:Colors.white,
              //           color: Colors.white,
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => EditProfile()),
              //             );
              //           },),),
              //     ],
              //   ),
              // ],
        //       // ListView(
        //       //   scrollDirection: Axis.vertical,
        //       //   children:<Widget>[
        //       //             __GalleryRow(),
        //       //             __GalleryRow(),
        //       //             __GalleryRow(),
        //       //             __GalleryRow(),
        //       //             __GalleryRow(),
        //       //             __GalleryRow(),
        //       //           ],
        //       //     )
        //   // Row(
        //   //   children:<Widget>[
        //   //     IconButton(
        //   //         icon:Icon(Icons.grid_on_outlined),
        //   //         iconSize: 30.0,
        //   //     ),
        //   //     IconButton(
        //   //         icon:Icon(Icons.image_outlined),
        //   //         iconSize: 30.0,
        //   //     ),
        //   //   ]
        //   // ),
        //   //     SingleChildScrollView(
        //   //       child:Gridview(),
        //   //     ),
        // ],
        //   )
      //   ),
      //     )
      // ),
    )
    );
  }
}
