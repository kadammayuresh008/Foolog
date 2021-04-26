import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Payment.dart';
import 'package:foolog/Screen/SplashScreen.dart';
import 'package:foolog/Screen/chats.dart';
import 'package:provider/provider.dart';


class BlogCard extends StatefulWidget {
  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget __Text(String caption,String location,String likes,String image,String price){
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
                        Text("Soul Travel",
                          style: TextStyle(fontSize:20.0,
                            color: Colors.white,
                          ),),
                      ],
                    ),
                    color: Colors.purple,
                    width: 900,
                    height: 60,
                  ),
                  Container(
                    height:325,
                    width: double.infinity,
                    child:Carousel(
                      boxFit: BoxFit.cover,
                      images: [
                        Image.asset(image),
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
                  // Image.asset("assets/Images/Image2.jfif",
                  //   width: double.infinity,
                  //   height:325,
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                    child:Column(
                        children:<Widget>[
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children:<Widget> [
                              Row(
                                children:[
                                  IconButton(icon:Icon(Icons.favorite_border,
                                      size: 30.0,
                                      color:Colors.black),
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
                              IconButton(icon:Icon(Icons.payment,
                                  size: 30.0,
                                  color:Colors.black),
                                  onPressed:(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => paymentIntegrations()),
                                    );
                                  }),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget> [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
                                  child: Text(" $likes likes",
                                      style:TextStyle(
                                          color:Colors.black
                                      )),
                                ),
                              ]
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,0,0,0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:<Widget> [
                                  Text(
                                      "Soul Travel",
                                      style:TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,2,0,0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:<Widget> [
                                  Text(
                                      "Rs.",
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.purple,
                                        fontSize: 25.0,
                                      )),
                                  SizedBox(width:5.0),
                                  price==null?
                                  Flexible(
                                    child:Text("0",
                                        style:TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:Colors.purple,
                                          fontSize: 25.0,
                                        )),
                                  ):Flexible(
                                    child:Text(price, style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:Colors.purple,
                                      fontSize: 25.0,
                                    )),
                                  ),
                                ]
                            ),
                          ),

                          // Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children:<Widget> [
                          //       Padding(
                          //         padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                          //         child: Text("View all 500 comments.",
                          //             style:TextStyle(
                          //                 color:Colors.grey
                          //             )),
                          //       ),
                          //     ]
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(16,0,0,0),
                          //   child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children:<Widget> [
                          //         Text(
                          //             "Soul Travel",
                          //             style:TextStyle(
                          //               color:Colors.black,
                          //               fontWeight: FontWeight.bold,
                          //             )),
                          //         SizedBox(width:5.0),
                          //         Text(
                          //             "Jobs fill your pockets, adventures fill your soul.",
                          //             style:TextStyle(
                          //                 color:Colors.black
                          //             )),
                          //       ]
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(16,0,0,0),
                          //   child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children:<Widget> [
                          //         Text(
                          //             "Soul Travel",
                          //             style:TextStyle(
                          //               color:Colors.black,
                          //               fontWeight: FontWeight.bold,
                          //             )),
                          //         SizedBox(width:5.0),
                          //         Text(
                          //             "Jobs fill your pockets, adventures fill your soul.",
                          //             style:TextStyle(
                          //                 color:Colors.black
                          //             )),
                          //       ]
                          //   ),
                          // ),
                        ]
                    ),
                    color: Colors.white,
                    width: 900,
                    height: 120,
                  ),
                  SizedBox(height:15.0),
                ]
            ),),
        ],),);
  }

  Widget build(BuildContext context) {
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
      return __Text(BlogList.docs[index]["caption"],
                    BlogList.docs[index]["location"],
                    BlogList.docs[index]["likes"],
                    BlogList.docs[index]["image"],
                    BlogList.docs[index]["price"],
      );
    });
  }
}
