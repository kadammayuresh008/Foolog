import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:foolog/Services/blogManagement.dart';

class CommentPage extends StatefulWidget {
  var comments;
  var index;
  CommentPage({Key key,this.comments,this.index}):super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _commController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.purple,
          title:Text(
            'Comments',
            style:TextStyle(
              color: Colors.white,
            ),
          )
      ),
      body:
      ListView.builder(
              itemCount: widget.comments.length,
              itemBuilder: (context,index)
              {
                return ListTile(
                  leading:CircleAvatar(
                    backgroundColor: Colors.white,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(70.0),
                      child: Image.network(
                        "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                        height: 70.0,
                        width:70.0,
                      ),
                    ),
                    radius:20.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Travel Soul",
                      style:TextStyle(
                      fontWeight: FontWeight.bold,
                  )),
                      Text(widget.comments[index]),
                    ],
                  ),
                  trailing: IconButton(
                      icon:Icon(Icons.favorite_border,
                      size: 20.0,
                      color:Colors.black),
                      onPressed: null)
                );
              }
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.fromLTRB(16,0,16,0),
            child: TextFormField(
              controller: _commController,
              decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.purple),
                prefixIcon: IconButton(
                  icon:Icon(
                    Icons.comment,
                    color: Colors.black,
                  ),
                ),
                suffixIcon:IconButton(
                  icon: Icon(
                    Icons.send,
                    color:Colors.black,
                  ),
                  onPressed: (){
                    setState(() {
                      blogManagement().addComment(_commController.text,widget.index);
                      _commController.clear();
                    });
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => super.widget));
                  },
                ) ,
                hintText: 'Add Comment',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
    );
  }
}


