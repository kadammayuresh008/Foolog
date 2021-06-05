import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Chats/Chatbox.dart';
import 'package:provider/provider.dart';


class Chatlist extends StatefulWidget {
  @override
  _ChatlistState createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {

  final _auth = FirebaseAuth.instance;
  @override

  Widget __ChatTile( String chatHolder,String lastMess,String ImagePath){
    return Container(
        child:InkWell(
          splashColor: Colors.black,
          highlightColor: Colors.purple,
          child: GestureDetector(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chatbox()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        ImagePath,
                        height: 100.0,
                        width:100.0,
                      ),
                    ),
                    radius:35.0,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Text(chatHolder,
                          style:TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          )),
                      SizedBox(width:20.0),
                      Text(lastMess),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget build(BuildContext context) {
    final list= Provider.of<QuerySnapshot>(context);
    return list==null?
    Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
        backgroundColor: Colors.white,
      ),
    ):ListView.builder(
        itemCount: list.docs.length,
        itemBuilder: (context,index)
        {
          return list.docs[index]["uid"]==_auth.currentUser.uid?
              Container() :
               __ChatTile(list.docs[index]["username"],
              "Hello, want to invest some money",
              list.docs[index]["proImage"]);
        });
  }
}
