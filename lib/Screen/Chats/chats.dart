import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Chats/Chatbox.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Widget __ChatList(){
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
                      "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
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
                    Text("Soul Travel",
                    style:TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                )),
                    SizedBox(width:20.0),
                    Text("Hi, I liked your food blog keep up the work."),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.purple,
       leading:IconButton(icon:Icon(Icons.arrow_back),
         onPressed: () {
           print("Back");
           Navigator.pop(context);
         },),
       title:Text("Chats"),
           actions: [
             IconButton(icon:Icon(Icons.search), onPressed: (){
     })
       ],
     ),
        body:ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index)
        {
          return __ChatList();
        })
    );
  }
}
