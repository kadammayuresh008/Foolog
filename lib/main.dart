import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Login.dart';
import 'package:foolog/Screen/Signup.dart';
// import 'package:flutter_app/Screen/Home.dart';
// import 'package:flutter_app/Screen/chats.dart';
// import 'package:flutter_app/Screen/Signup.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:foolog/Screen/Wrapper.dart';
import 'package:foolog/Services/auth.dart';
import 'package:foolog/models/User.dart';
import 'package:provider/provider.dart';

CameraDescription firstCamera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // firstCamera = cameras.first;
  // print("Camera decription");
  // print(firstCamera);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value:AuthService().user,
      child: MaterialApp(
        title: "Foolog",
        home: Wrapper(),
      ),
    );
  }
}
