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
                        widget.comments[index]["cImage"],
                        height: 70.0,
                        width:70.0,
                      ),
                    ),
                    radius:20.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.comments[index]["cName"].toString(),
                      style:TextStyle(
                      fontWeight: FontWeight.bold,
                  )),
                      Text(widget.comments[index]["comment"].toString()),
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


