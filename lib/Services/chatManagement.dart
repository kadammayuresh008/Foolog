
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatManagement{
  
  final CollectionReference chat = FirebaseFirestore.instance.collection("/user");
  final _auth= FirebaseAuth.instance;
  
  // void retreiveUser()async{
  //   final Stream<QuerySnapshot<Object>> chatUser = await chat.snapshots();
  //   for(var i=0;i<chatUser.length;i++)
  //     {
  //
  //     }
  // //   chat.snapshots().forEach((element) {
  // //     print(element.docs);
  // //   });
  // // }
  
}