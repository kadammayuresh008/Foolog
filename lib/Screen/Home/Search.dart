import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';
import '../Helper/UserList.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query="";

  @override

  Widget TextCardField(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.purple,
          ),
          Text("Mayuresh"),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value:UserManagement().UserDetails,
      child: Scaffold(
          body:UserList(),
      ),
    );
  }
}

