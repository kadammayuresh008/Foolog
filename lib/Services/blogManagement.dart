// import 'dart:html';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class blogManagement{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference blog =
      FirebaseFirestore.instance.collection("/blog");

  dynamic uploadImage(PickedFile Image, BuildContext context) async {
    var file = File(Image.path);
    String filename = basename(Image.path);
    var image = await storage.ref().child(filename).putFile(file);
    return await image.ref.getDownloadURL();
  }

  StoreBlog(PickedFile image, String location, String caption,
      BuildContext context) async {
    final CollectionReference newuser =
        await FirebaseFirestore.instance.collection("/user");
    final dynamic user =
        await newuser.where("uid", isEqualTo: _auth.currentUser.uid).get();
    dynamic ImageUrl = await uploadImage(image, context);
    blog.add({
      'user_id': _auth.currentUser.uid,
      'user': user.docs[0]["username"],
      'location': location,
      'image': ImageUrl,
      'caption': caption,
      'likes': [],
      'comments': [],
    }).then((value) async {
      await newuser
          .doc(user.docs[0].id)
          .update({"Post": FieldValue.increment(1)});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  Stream<QuerySnapshot> get Blog {
    return blog.snapshots();
  }

  //To increment the like
  void increLike(String index, bool heart) {
    String user_id = _auth.currentUser.uid;
    if (heart == false) {
      blog.doc(index).update({
        'likes': FieldValue.arrayRemove([user_id])
      });
    } else {
      blog.doc(index).update({
        'likes': FieldValue.arrayUnion([user_id])
      });
    }
  }

// To add comment
  Future<void> addComment(String comment, String index) async {
    final int like = 100;
    final String Time = "9.04pm";
    final CollectionReference newuser =
        await FirebaseFirestore.instance.collection("/user");
    final dynamic user =
        await newuser.where("uid", isEqualTo: _auth.currentUser.uid).get();
    blog.doc(index).update({
      'comments': FieldValue.arrayUnion([
        {
          "comment": comment,
          "cName": user.docs[0]["username"],
          "cImage": user.docs[0]["proImage"],
          "clikes": like,
          "cTime": Time,
        }
      ])
    });
  }

  //to delete user Post
  void deletePost(String index) async {
    await blog.doc(index).delete();
  }



  //to Edit the user Post
  void EditPost(String index, String caption, String location,context) async {
    await blog.doc(index).update({
      "caption": caption,
      "location": location,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    ).catchError((e)=>print(e));
  }

}
