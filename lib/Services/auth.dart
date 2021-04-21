import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foolog/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Future GetCurrentUser() async{
  //   final dynamic curUser = _auth.currentUser;
  //   final dynamic blogUser = await FirebaseFirestore.instance.collection("/user")
  //       .where("uid",isEqualTo: curUser.uid);
  //   print(blogUser);
  //   // final dynamic UserList =blogUser.snapshots();
  //   // print(UserList);
  //   for(var doc in blogUser.snapshots())
  //     {
  //       print(doc);
  //     }
  //   // print(blogUser);
  // }


  // create user obj on firebase user
  Users _userFromFirebaseUser(dynamic user){
    return user!=null? Users(email:user.email,uid:user.uid):null;
  }

  Stream<Users> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Create User with emal and password

  Future CreateUserWithEmailandPassword(String email,String password) async{
    try{
      final dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final dynamic user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //SignIn wth email and password
  Future SignInWithEmailAndPassword(String email,String password) async{
    try {
      final dynamic result = await  _auth.signInWithEmailAndPassword(email: email, password: password);
      final dynamic user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

//Signout
Future<void> Signout() async{
  try{
    await _auth.signOut();
  }
  catch(e)
  {
    print(e.toString());
  }
}
}