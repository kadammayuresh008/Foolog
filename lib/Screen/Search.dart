import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';

import 'Helper/UserList.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query="";
  @override



  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: UserManagement().UserDetails,
      child: Scaffold(
        appBar: AppBar(
          leading:IconButton(
             icon:Icon(
               Icons.search,
               color: Colors.purple,
             ),
            onPressed: (){
               // TextCardField();
            },
          ),
          backgroundColor: Colors.grey[100],
        ),
        body:UserList(),
      ),
    );
  }
}
