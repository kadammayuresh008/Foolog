import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'package:foolog/models/BlogModel.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  var index;
  var docnum;

  CommentPage({Key key,@required this.index,@required this.docnum}) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _commController = TextEditingController();

  @override
  Widget build(BuildContext context) {
          final BlogList = Provider.of<QuerySnapshot>(context);
          var commentsList = BlogList.docs[widget.index]["comments"];
          return BlogList==null?
          Center(
              child:CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
                backgroundColor: Colors.white,
                )):Scaffold(
              body: ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: commentsList[index]["cImage"] == ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(70.0),
                                  child: Image.asset(
                                    "assets/Images/DeafultProfileImage.png",
                                    height: 70.0,
                                    width: 70.0,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(70.0),
                                  child: Image.network(
                                    commentsList[index]["cImage"],
                                    height: 70.0,
                                    width: 70.0,
                                  ),
                                ),
                          radius: 20.0,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(commentsList[index]["cName"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(commentsList[index]["comment"].toString()),
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.favorite_border,
                                size: 20.0, color: Colors.black),
                            onPressed: null));
                  }),
              bottomSheet: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
                  controller: _commController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.cyan),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Colors.black,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                           await blogManagement().addComment(_commController.text,widget.docnum);
                          _commController.clear();
                          setState(() {});
                      },
                    ),
                    hintText: 'Add Comment',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ));
  }
}
