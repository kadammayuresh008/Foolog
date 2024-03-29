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
  var uid;
  bool follow;

  @override
  _ProfileState createState() => _ProfileState();

  Profile({Key key, @required this.uid, @required this.follow}) : super(key: key);
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    // print("widget_uid "+widget.uid);
    return StreamProvider<QuerySnapshot>.value(
      value:UserManagement().UserDetails,
      child:UserManagement().UserDetails==null?Center(
        child:CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
          backgroundColor: Colors.white,
        ),
      ):
      Scaffold(
            appBar:  PreferredSize(
              preferredSize: Size.fromHeight(390.0),
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.cyan,
                    leading:IconButton(icon:Icon(Icons.arrow_back),
                      onPressed: () {
                        print("Back");
                        Navigator.pop(context);
                      },),
                    title:Text("Profile"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: ProfileTop(uid:widget.uid,follow:widget.follow),
                  ),
                ],
              ),
            ),
          body:Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageGridView(uid:widget.uid),
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
