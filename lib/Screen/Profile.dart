import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Gridview.dart';
import 'package:foolog/Screen/Login.dart';
import 'package:foolog/Services/Auth.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';
import 'package:foolog/Screen/Helper/ProfileTop.dart';


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


  @override

  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value:UserManagement().UserDetails,
      child: Scaffold(
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
              ProfileTop(),
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
              ),],
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
        )),
    );
  }
}
