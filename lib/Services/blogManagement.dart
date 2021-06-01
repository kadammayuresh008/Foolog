// import 'dart:html';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foolog/Screen/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';


class blogManagement{
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseStorage storage= FirebaseStorage.instance;
  final CollectionReference blog = FirebaseFirestore.instance.collection("/blog");


 dynamic uploadImage(PickedFile Image,BuildContext context)async{
   var file= File(Image.path);
  String filename= basename(Image.path);
  var image= await storage.ref().child(filename).putFile(file);
  return await image.ref.getDownloadURL();
  }

  StoreBlog(PickedFile image,String location,String caption,int price,BuildContext context)async{
    dynamic ImageUrl = await uploadImage(image,context);
    blog.add({
      'user_id':_auth.currentUser.uid,
      'user':_auth.currentUser.displayName,
      'location':location,
      'image':ImageUrl,
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
    });
  }

  Stream<QuerySnapshot> get Blog{
    return blog.snapshots();
  }


}