import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Home/CommentPage.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'package:provider/provider.dart';


class CommentPageProvider extends StatefulWidget {
  var docnum;
  var index;
  CommentPageProvider({Key key,@required this.index,@required this.docnum}) : super(key: key);

  @override
  _CommentPageProviderState createState() => _CommentPageProviderState();
}

class _CommentPageProviderState extends State<CommentPageProvider> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return StreamProvider<QuerySnapshot>.value(
      value:blogManagement().Blog,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              'Comments',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        body:CommentPage(index:widget.index,docnum: widget.docnum,)
      ),
    );
  }
}
