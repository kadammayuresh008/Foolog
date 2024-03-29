import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/ChatList.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Chats/Chatbox.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value:UserManagement().UserDetails,
      child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.cyan,
         leading:IconButton(icon:Icon(Icons.arrow_back),
           onPressed: () {
             Navigator.pop(context);
           },),
         title:Text("Chats"),
             actions: [
               IconButton(icon:Icon(Icons.search), onPressed: (){
                 // UserManagement().UserDetails();
       })
         ],
       ),
          body:Chatlist(),
      ),
    );
  }
}
