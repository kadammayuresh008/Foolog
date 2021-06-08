import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Chats/chats.dart';
import 'package:foolog/Screen/Helper/BlogCard.dart';
import 'package:foolog/Screen/Home/CommentPage.dart';
import 'package:foolog/Services/blogManagement.dart';


class ImageView extends StatefulWidget {
  var username;
  var location;
  var caption;
  var image;
  var likes;
  var comments;
  var heart;
  var index;


  ImageView({Key key,this.username,this.index,this.caption,this.location,this.likes,this.image,this.comments,this.heart}):
        super(key :key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool heart;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: Colors.purple,
        elevation:0.0,
      ),
      body:Container(
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
                                widget.username==null?Container():
                                Text(widget.username,
                                  style: TextStyle(fontSize:18.0,
                                    color: Colors.white,
                                  ),),
                                widget.location==null?Container():
                                Text(widget.location,
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
                          blogManagement().increLike(widget.index,widget.heart);
                        });
                      },
                      child: Container(
                        height:325,
                        width: double.infinity,
                        child:Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            Image.network(widget.image),
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
                                    widget.heart==false?
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
                                    child: Text(" ${widget.likes.length} likes",
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
                                    widget.username!=null?Text(
                                        widget.username,
                                        style:TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )):Container(),
                                    SizedBox(width:5.0),
                                    widget.caption==null?
                                    Flexible(
                                      child:Text("No caption"),
                                    ):Flexible(
                                      child:Text(widget.caption),
                                    ),
                                  ]
                              ),
                            ),
                            widget.comments.length==0?
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16,2,0,0),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap:(){
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => CommentPage(
                                            comments: widget.comments,
                                            index: widget.index,
                                          )),
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
                                          MaterialPageRoute(builder: (context) => CommentPage(
                                            comments: widget.comments,
                                            // index: index,
                                          )),
                                        );
                                      },
                                      child: Text("View ${widget.comments.length} Comments",
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
          ],),),
    );
  }
}
