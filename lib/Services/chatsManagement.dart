import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foolog/models/MessageModel.dart';

class chatsManagement{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage =FirebaseStorage.instance;

  final CollectionReference chats = FirebaseFirestore.instance.collection("Chats");


  void initiateChat(String sourceId,String targetId, Message msg){
    chats.add({
      "sourceId":sourceId,
      "targetId":targetId,
      "Messages":[
        {"msg":msg.msg,
        "type":msg.type,
        "now":msg.now,//for time of message
        }
        ],
    }).then((value) =>print(value)).catchError((e){
      print(e);
    });
  }
  
  void addMessage(String sourceId,String targetId,Message msg) async{
    final dynamic chatList = await chats.where("sourceId",isEqualTo:sourceId)
        .where("targetId",isEqualTo:targetId).get();
    chats.doc(chatList.docs[0].id).update({
      "Messages":FieldValue.arrayUnion([
        {"msg":msg.msg,
        "type":msg.type,
          "now":msg.now,
        }])
    });
  }

  Future<List<dynamic>> getMessage(String sourceId,String targetId)async{
    final dynamic chatList = await chats.where("sourceId",isEqualTo:sourceId)
        .where("targetId",isEqualTo:targetId).get();
    return chatList.docs[0]["Messages"];
  }
}