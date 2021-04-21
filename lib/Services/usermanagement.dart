import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foolog/Screen/Home.dart';

class UserManagement{
  StoreNewUser(user,username,context){
    FirebaseFirestore.instance.collection('/user').add({
      'email':user.email,
      'uid':user.uid,
      'username':username,
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
}