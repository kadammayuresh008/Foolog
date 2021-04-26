// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foolog/Screen/Home.dart';
import 'package:image_picker/image_picker.dart';


class blogManagement{
  FirebaseAuth _auth =FirebaseAuth.instance;
  final CollectionReference blog = FirebaseFirestore.instance.collection("/blog");

  StoreBlog(PickedFile image,String location,String caption,int price,context)=>{
    blog.add({
      'user_id':_auth.currentUser.uid,
      'user':_auth.currentUser.displayName,
      'image':image,
      'location':location,
      'caption':caption,
      'price':price,
      'likes':0,
    }).then((value){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((e){
      print(e);
    })
  };

  Stream<QuerySnapshot> get Blog{
    return blog.snapshots();
  }


}