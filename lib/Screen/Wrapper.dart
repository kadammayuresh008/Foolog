import 'package:flutter/material.dart';
import 'package:foolog/Screen/Home.dart';
import 'package:foolog/Screen/Login.dart';
import 'package:foolog/Screen/Signup.dart';
import 'package:foolog/models/User.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user==null) {
      return Login();
    } else {
      return Home();
    }
  }
}
