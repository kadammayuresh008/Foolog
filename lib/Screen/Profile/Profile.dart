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
                    // actions: [
                    //   IconButton(icon:Icon(Icons.menu), onPressed: () async{
                    //     await AuthService().Signout();
                    //     Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => Login())
                    //     );
                    //   })
                    // ],
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
        endDrawer: Drawer(
          child:ListView(
            children:<Widget>[
              ListTile(
                leading:Icon(Icons.settings,
                    color:Colors.black),
                title:Text("Setting"),
              ),
              ListTile(
                onTap: () async{
                    await AuthService().Signout();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login())
                    );
                  },
                leading:Icon(Icons.exit_to_app,
                    color:Colors.black,
                ),
                title:Text("Signout"),
              ),
            ]
          )
        ),
    )
    );
  }
}
