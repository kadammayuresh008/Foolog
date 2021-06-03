import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foolog/Screen/Home.dart';
import 'package:foolog/models/User.dart';

class UserManagement{
  final CollectionReference CurrUserDetails = FirebaseFirestore.instance.collection("user");

  StoreNewUser(user,username,context){
    FirebaseFirestore.instance.collection('user').add({
      'email':user.email,
      'uid':user.uid,
      'username':username,
      'Followers':0,
      'Following':0,
      'Post':0,
    }).then((value){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((e)
    {
      print(e);
    });

  }

  Stream<QuerySnapshot> get UserDetails{
    return CurrUserDetails.snapshots();
  }



}