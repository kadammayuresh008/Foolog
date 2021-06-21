import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Chats/chats.dart';
import 'package:foolog/Screen/Helper/BlogCard.dart';
import 'package:foolog/Screen/Home/CommentPage.dart';
import 'package:foolog/Screen/Profile/Profile.dart';
import 'package:foolog/Services/blogManagement.dart';


class ImageView extends StatefulWidget {
  var userId;
  var username;
  var location;
  var caption;
  var image;
  var likes;
  var comments;
  var heart;
  var index;
  var docnum;


  ImageView({Key key,this.index,this.userId,this.username,this.docnum,this.caption,this.location,this.likes,this.image,this.comments,this.heart, user_id}):
        super(key :key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool heart;
  String _caption;
  String _location;
  final _auth = FirebaseAuth.instance;
  TextEditingController _editCaption=TextEditingController();
  TextEditingController _editLocation=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _editCaption=TextEditingController(text:widget.caption);
      _editLocation=TextEditingController(text:widget.location);
      heart=widget.heart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: Colors.cyan,
        elevation:0.0,
      ),
      body:SingleChildScrollView(
        child: Container(
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
                        color: Colors.cyan,
                        width: 900,
                        height: 60,
                      ),
                      GestureDetector(
                        onDoubleTap:(){
                          setState(() async {
                           await blogManagement().increLike(widget.docnum.toString(),!widget.heart);
                            setState(() {
                              heart=!heart;
                            });
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
                            dotColor: Colors.cyan,
                            dotIncreasedColor: Colors.cyan,
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
                                          print("No commments");
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
                                            index: widget.index,
                                            docnum: widget.docnum,
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
                      widget.userId==_auth.currentUser.uid?Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color:Colors.cyan,
                          elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            SizedBox(height:10.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: TextFormField(
                                controller: _editCaption,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator:(value){
                                  if(value.isEmpty)
                                  {
                                    return "Caption field cannot be empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled:true,
                                  errorStyle: TextStyle(color:Colors.white),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                    color: Colors.cyan,
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: TextFormField(
                                controller: _editLocation,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator:(value){
                                  if(value.isEmpty)
                                  {
                                    return "Caption field cannot be empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled:true,
                                  errorStyle: TextStyle(color:Colors.white),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                    color: Colors.cyan,
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:BorderSide(color: Colors.cyan, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height:5.0),
                             CircleAvatar(
                               radius:22.0,
                               backgroundColor: Colors.white,
                               child:IconButton(icon: Icon(
                                 Icons.done,
                                 color: Colors.cyan,
                                 size: 22.0,
                               ), onPressed: () async{
                                 await blogManagement().EditPost(widget.docnum.toString(), _editCaption.text, _editLocation.text,context);
                                 _editCaption.clear();
                                 _editLocation.clear();
                               }),
                             ),
                            SizedBox(height:10.0),
                            ]
                          )
                        ),
                      ):
                      Container(),
                      widget.userId==_auth.currentUser.uid?Center(
                        child: CircleAvatar(
                          radius:25.0,
                          backgroundColor: Colors.cyan,
                          child:IconButton(icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 25.0,
                          ), onPressed: ()async{
                            await blogManagement().deletePost(widget.docnum.toString());
                            Navigator.pop(context);
                            Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>Profile()));
                          }),
                        ),
                      ):Container(),
                    ]
                ),),
            ],),),
      ),
    );
  }
}
