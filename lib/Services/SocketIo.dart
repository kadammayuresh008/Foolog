import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Services/chatsManagement.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:foolog/models/MessageModel.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIo{
  IO.Socket socket;
  String now = DateFormat("hh:mm").format(DateTime.now()); //To calculate current time
  final _auth=FirebaseAuth.instance;

  //to connect to socket io server
  void connect() async {
    socket =
        IO.io("https://arcane-thicket-78202.herokuapp.com/", <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false,
        });
    socket.connect();
    String currentUserId = await getCurrentUserId();
    socket.emit("signin", currentUserId);
    socket.onConnect((data) {
      print("Connected");
    });
  }


  Future<dynamic> getCurrentUserId() async {
    List<dynamic> currentUserId =
    await UserManagement().getCurrentUsername(_auth.currentUser.uid);
    return currentUserId[3];
  }



}