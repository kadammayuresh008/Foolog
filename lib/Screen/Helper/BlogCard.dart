import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home/CommentPageProvider.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/CommentPage.dart';
// import 'package:foolog/Screen/SplashScreen.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Chats/chats.dart';
import 'package:foolog/Services/blogManagement.dart';
// import 'package:foolog/Services/usermanagement.dart';
import 'package:provider/provider.dart';


class BlogCard extends StatefulWidget {
  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget __Text(int num,dynamic index,String username,String caption,String location,String likes,String image,List<dynamic> comments,bool heart){
    return Container(
      child:Column(
        children:
        <Widget>[
          Container(
            child:Column(
                children:<Widget>[
                  Container(
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              username==null?Container():
                              Text(username,
                                style: TextStyle(fontSize:18.0,
                                  color: Colors.white,
                                ),),
                              location==null?Container():
                              Text(location,
                                style: TextStyle(fontSize:15.0,
                                  color: Colors.white,
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    color: Colors.purple,
                    width: 900,
                    height: 60,
                  ),
                  GestureDetector(
                    onDoubleTap:(){
                      setState(() {
                        heart = !heart;
                        blogManagement().increLike(index,heart);
                      });
                    },
                    child: Container(
                      height:325,
                      width: double.infinity,
                      child:Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          Image.network(image),
                        ],
                        autoplay: false,
                        // animationCurve: Curves.fastOutSlowIn,
                        //  animationDuration: Duration(milliseconds: 1000),
                        dotSize: 4.0,
                        indicatorBgPadding: 6.0,
                        dotBgColor: Colors.transparent,
                        dotColor: Colors.purple,
                        dotIncreasedColor: Colors.purple,
                      ),),
                  ),
                  Container(
                    child:Column(
                        children:<Widget>[
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children:<Widget> [
                              Row(
                                children:[
                                  heart==false?
                                  IconButton(icon:Icon(Icons.favorite_border,
                                      size: 30.0,
                                      color:Colors.black),
                                      onPressed: null):IconButton(icon:Icon(Icons.favorite_sharp,
                                      size: 30.0,
                                      color:Colors.red),
                                      onPressed: null),
                                  IconButton(icon:Icon(Icons.message,
                                      size: 30.0,
                                      color:Colors.black),
                                      onPressed:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Chat()),
                                        );
                                      }
                                  ),
                                ],),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget> [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
                                  child: Text(" $likes likes",
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ]
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,0,0,0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:<Widget> [
                                  username!=null?Text(
                                      username,
                                      style:TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )):Container(),
                                  SizedBox(width:5.0),
                                  caption==null?
                                  Flexible(
                                    child:Text("No caption"),
                                  ):Flexible(
                                    child:Text(caption),
                                  ),
                                ]
                            ),
                          ),
                          comments.length==0?
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16,2,0,0),
                            child:Row(
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                            GestureDetector(
                            onTap:(){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CommentPageProvider(index:num,docnum:index)),
                            );
                            },
                            child: Text("No Comments",
                            style:TextStyle(
                            color:Colors.grey
                            ))
                            ),
                            ],
                            ),
                            ):Padding(
                            padding: const EdgeInsets.fromLTRB(16,2,0,0),
                            child:Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => CommentPageProvider(index:num,docnum:index)),
                                      );
                                    },
                                  child: Text("View ${comments.length} Comments",
                                      style:TextStyle(
                                          color:Colors.grey
                                      ))
                                ),
                              ],
                            ),
                    ),

                        ]),

                    color: Colors.white,
                    width: 900,
                    height: 105,
                  ),
                  SizedBox(height:15.0),
                ]
            ),),
        ],),);
  }

  Widget build(BuildContext context) {
    FirebaseAuth _auth =FirebaseAuth.instance;
    final BlogList = Provider.of<QuerySnapshot>(context);
    return BlogList==null?
    Center(
        child:CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
      backgroundColor: Colors.white,
    ))
        : ListView.builder(
        itemCount: BlogList.docs.length,
        itemBuilder: (BuildContext context,int index)
    {
      return __Text(
                    index,
                    BlogList.docs[index].id,
                    BlogList.docs[index]["user"],
                    BlogList.docs[index]["caption"],
                    BlogList.docs[index]["location"],
                    BlogList.docs[index]["likes"].length.toString(),
                    BlogList.docs[index]["image"],
                    BlogList.docs[index]["comments"],
                    BlogList.docs[index]["likes"].contains(_auth.currentUser.uid),
      );
    });
  }
}


