import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:foolog/Screen/Home.dart";
import 'package:camera/camera.dart';
import 'package:foolog/Screen/Payment.dart';
import 'package:foolog/Services/blogManagement.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:image_picker/image_picker.dart';

CameraDescription firstCamera;


Future<CameraDescription> camera()async{
final cameras = await availableCameras();
final firstCamera = cameras.first;
return firstCamera;
}



class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _location;
  String _caption;
  int _price;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("AddBlog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key:_formKey,
        child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Take Image
              Text(
                "Images",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
              Container(
                child:_imageFile==null?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child:Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Add from gallery',
                            style:TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      shape:RoundedRectangleBorder(
                          borderRadius:new BorderRadius.circular(10.0)),
                      hoverColor: Colors.purple,
                      highlightElevation: 0.5,
                      color: Colors.purple,
                      onPressed: () async {
                        PickedFile GalleryFile = await _picker.getImage(
                          source:ImageSource.gallery,
                        );
                        setState(() {
                          _imageFile = GalleryFile;
                        });
                        print("Your selected image is located at"+GalleryFile.path);
                      },
              ),
                    RaisedButton(
                      child:Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Add using camera',
                            style:TextStyle(
                              color: Colors.white,
                            )),
                      ),
                        shape:RoundedRectangleBorder(
                            borderRadius:new BorderRadius.circular(10.0)),
                      hoverColor: Colors.purple,
                      highlightElevation: 0.5,
                      color: Colors.purple,
                      onPressed: () async {
                              PickedFile GalleryFile = await _picker.getImage(
                              source:ImageSource.camera,
                              );
                              setState(() {
                              _imageFile = GalleryFile;
                              });
                              print("Your selected image is located at"+GalleryFile.path);}
                      ),
                  ]
                ):Image.file(File(_imageFile.path),
                  width:double.infinity,
                ),
                width: double.infinity,
                height: 250,
              ),
              SizedBox(height:10.0),
              //Take location
              Text(
                "Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _location=value;
                    });
                  },
                  validator:(value){
                    if(value.isEmpty)
                      {
                        return "Location field cannot be empty";
                      }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color:Colors.purple),
                    prefixIcon: Icon(
                      Icons.place_sharp,
                      color: Colors.purple,
                    ),
                    hintText: 'Add Location',
                    hintStyle:TextStyle(
                      color:Colors.purple,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              //Take caption/Info
              Text(
                "Caption",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _caption=value;
                    });
                  },
                  validator:(value){
                    if(value.isEmpty)
                    {
                      return "Caption field cannot be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color:Colors.purple),
                    prefixIcon: Icon(
                      Icons.closed_caption,
                      color: Colors.purple,
                    ),
                    hintText: 'Add Caption',
                    hintStyle:TextStyle(
                      color:Colors.purple,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Text(
                "Price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _price= value as int;
                    });
                  },
                  validator:(value){
                    if(value.isEmpty)
                    {
                      return "Price field cannot be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color:Colors.purple),
                    prefixIcon: Icon(
                      Icons.money,
                      color: Colors.purple,
                    ),
                    hintText: 'Add Price',
                    hintStyle:TextStyle(
                      color:Colors.purple,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height:10.0),
              Center(
                child: RaisedButton(
                  child:Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Add Post',
                        style:TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  shape:RoundedRectangleBorder(
                      borderRadius:new BorderRadius.circular(10.0)),
                  hoverColor: Colors.purple,
                  highlightColor: Colors.purple,
                  highlightElevation: 0.5,
                  color: Colors.purple,
                  onPressed: () {
                    if(_formKey.currentState.validate())
                      {
                        blogManagement().StoreBlog(_imageFile,_location,_caption,_price,context);
                        _scaffoldKey.currentState.showSnackBar(
                            new SnackBar(
                              content: new Text('Your Blog has been Added.',
                                  style:TextStyle(
                                    color:Colors.white,
                                  )),
                              action: SnackBarAction(
                                label: 'ok',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              backgroundColor: Colors.green.withOpacity(0.8),
                            )
                        );
                      }
                  },),
              ),
            ],
          )
        ),
        ),
      ),
    );
  }
}



// class SnackBarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           final snackBar = SnackBar(
//             content: Text('Yay! A SnackBar!'),
//             action: SnackBarAction(
//               label: 'ok',
//               onPressed: () {
//                 // Some code to undo the change.
//               },
//             ),
//           );
//
//           // Find the ScaffoldMessenger in the widget tree
//           // and use it to show a SnackBar.
//         },
//         child: Text('Show SnackBar'),
//       ),
//     );
//   }
// }