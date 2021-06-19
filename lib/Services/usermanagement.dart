import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foolog/Screen/Profile/Profile.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:image_picker/image_picker.dart';

class UserManagement {
  final CollectionReference CurrUserDetails =
      FirebaseFirestore.instance.collection("user");

  StoreNewUser(user, username, context) {
    FirebaseFirestore.instance.collection('user').add({
      'email': user.email,
      'uid': user.uid,
      'username': username,
      'bio': "",
      'proImage': "",
      'Followers': [],
      'Following': [],
      'Post': 0,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  Stream<QuerySnapshot> get UserDetails {
    return CurrUserDetails.snapshots();
  }

  Future<List<dynamic>> getCurrentUsername(String uid) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final dynamic user = await FirebaseFirestore.instance
        .collection("/user")
        .where("uid", isEqualTo: uid)
        .get();
    List<dynamic> userdetails = [
      user.docs[0]["username"],
      user.docs[0]["bio"],
      user.docs[0]["proImage"],
      user.docs[0]["uid"],
      user.docs[0]["Following"],
      user.docs[0]["Followers"],
    ];
    return userdetails;
  }

  Future<List<Map<String, dynamic>>> getUserPhoto(String uid) async {
    // FirebaseAuth _auth = FirebaseAuth.instance;
    final dynamic user = await FirebaseFirestore.instance
        .collection("/blog")
        .where("user_id", isEqualTo: uid)
        .get();
    List<Map<String, dynamic>> Images = [];
    for (var i = 0; i < user.docs.length; i++) {
      print(user.docs[i].id);
      Images.add({
        "userId": user.docs[i]["user_id"],
        "index": user.docs[i].id,
        "image": user.docs[i]["image"],
        "username": user.docs[i]["user"],
        "caption": user.docs[i]["caption"],
        "likes": user.docs[i]["likes"],
        "location": user.docs[i]["location"],
        "comments": user.docs[i]["comments"],
      });
    }
    return Images;
  }

  //to Update user Profile
  Future<void> updateUserProfile(String username, String bio, PickedFile image,
      String ProImage, BuildContext context) async {
    dynamic ImageUrl;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final dynamic user = await FirebaseFirestore.instance
        .collection("/user")
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get();
    final DocumentReference<Map<String, dynamic>> User =
        FirebaseFirestore.instance.collection('/user').doc(user.docs[0].id);
    if (image != null) {
      ImageUrl = await blogManagement().uploadImage(image, context);
    }
    User.update({
      'username': username,
      'bio': bio,
      'proImage': image == null ? ProImage : ImageUrl,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(uid:_auth.currentUser.uid)),
      );
    }).catchError((e) {
      print(e);
    });
  }

  //to Follow and Unfollow user
  Future<void> followUnfollow(String followUid, bool follow) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference user =
        await FirebaseFirestore.instance.collection("/user");
    final dynamic followPer =
        await user.where("uid", isEqualTo: followUid).get();
    final dynamic followingPer =
        await user.where("uid", isEqualTo: _auth.currentUser.uid).get();
    String followerUid = _auth.currentUser.uid; //Uid of Person going to Follow
    String followerId = followingPer.docs[0].id; //id of current user docs
    String followingId =
        followPer.docs[0].id; //Id of Person docs who is followed
    String followingUid =
        followPer.docs[0]["uid"]; //Uid of Person who is followed
    if (follow == true) {
      //to added/count the follower
      await user.doc(followingId).update({
        "Followers": FieldValue.arrayUnion([followerUid])
      }).catchError((e) {
        print(e);
      });

      //to add/count the following
      await user.doc(followerId).update({
        "Following": FieldValue.arrayUnion([followingUid])
      }).catchError((e) {
        print(e);
      });
    } else {
      //to remove/count the follower
      await user.doc(followingId).update({
        "Followers": FieldValue.arrayRemove([followerUid])
      }).catchError((e) {
        print(e);
      });

      //to remove/count the following
      await user.doc(followerId).update({
        "Following": FieldValue.arrayRemove([followingUid])
      }).catchError((e) {
        print(e);
      });
    }
  }
}



