import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foolog/Screen/Profile/Profile.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:image_picker/image_picker.dart';

class UserManagement{
  final CollectionReference CurrUserDetails = FirebaseFirestore.instance.collection("user");

  StoreNewUser(user,username,context){
    FirebaseFirestore.instance.collection('user').add({
      'email':user.email,
      'uid':user.uid,
      'username':username,
      'bio':"",
      'proImage':"",
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

  Future<List<String>> getCurrentUsername() async{
    FirebaseAuth _auth =FirebaseAuth.instance;
    final  dynamic user= await FirebaseFirestore.instance.collection("/user")
        .where("uid",isEqualTo:_auth.currentUser.uid).get();
    List<String> userdetails=[
      user.docs[0]["username"],
      user.docs[0]["bio"],
      user.docs[0]["proImage"],
      user.docs[0]["uid"],
    ];
    return userdetails;
  }

  Future<List<String>> getCurrentUserPhoto() async{
    FirebaseAuth _auth =FirebaseAuth.instance;
    final  dynamic user= await FirebaseFirestore.instance.collection("/blog")
        .where("user_id",isEqualTo:_auth.currentUser.uid).get();
    List<String> Images=[];
    for(var i =0;i<user.docs.length;i++)
    {Images.add(user.docs[i]["image"]);}
    return Images;
  }

  Future<void> updateUserProfile(String username,String bio,PickedFile image,String ProImage,BuildContext context) async {
    dynamic ImageUrl;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final  dynamic user= await FirebaseFirestore.instance.collection("/user")
        .where("uid",isEqualTo:_auth.currentUser.uid).get();
    final DocumentReference<Map<String, dynamic>> User=FirebaseFirestore.instance.collection('/user')
        .doc(user.docs[0].id);
    if(image!=null)
      {
        ImageUrl = await blogManagement().uploadImage(image,context);
      }
    User.update({
      'username':username,
      'bio':bio,
      'proImage': image==null?ProImage:ImageUrl,
    }).then((value){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    }).catchError((e){
      print(e);
    });
  }
  
}



