import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/BlogCard.dart';
import 'package:foolog/Screen/Payment.dart';
import 'package:foolog/Screen/chats.dart';
import 'package:foolog/Screen/Profile.dart';
import 'package:foolog/Screen/AddBlog.dart';
import 'package:foolog/Screen/Search.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Widget __Story(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 0.0, 0.0),
      child: CircleAvatar(
            backgroundColor: Colors.purple,
          child:CircleAvatar(
            backgroundColor: Colors.white,
            child:ClipRRect(
              borderRadius: BorderRadius.circular(70.0),
              child: Image.network(
                "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                height: 70.0,
                width:70.0,
              ),
            ),
            radius:35.0,
          ),
            radius:40.0,
          ),
    );
  }

  Widget _HorizontalScroller(){
    return Container(
      child:ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          __Story(),
          __Story(),
          __Story(),
          __Story(),
          __Story(),
          __Story(),

        ],
      ),
      color: Colors.white,
      width: double.infinity,
      height: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value:blogManagement().Blog,
      child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title:Text("Foolog"),
              actions: <Widget>[
                IconButton(icon:Icon(Icons.message,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      },
                    ),
      IconButton(icon:Icon(Icons.search,size: 30.0,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                    ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child:CircleAvatar(
                    backgroundColor: Colors.white,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                        height: 40.0,
                        width:70.0,
                      ),
                    ),
                    radius:20.0,
                  ),
                )
              ],
            ),
            // body:StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection('/blog').snapshots(),
            //   builder: (context,snapshots)
            //   {
            //     if(snapshots.hasData)
            //       // ignore: missing_return
            //       {
            //         // ignore: missing_return
            //         return __Text();
            //       }
            //     else{
            //       CircularProgressIndicator();
            //     }
            //   },
            // ),
        body:BlogCard(),
         //    body:SingleChildScrollView(
         //        child:
         //        Column(
         //          children:<Widget>[
         //            __Text(),
         //            __Text(),
         //            __Text(),
         //            __Text(),
         //          ],
         //        )
         //    ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          height: 60.0,
          width:60.0,
          child: FloatingActionButton(
            child:Icon(Icons.add,size: 40.0,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBlog()),
              );
            },
            backgroundColor: Colors.purple,
          ),
        ),
          ),
    );
  }
}
