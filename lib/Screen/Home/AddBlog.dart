import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'package:camera/camera.dart';
// import 'package:foolog/Screen/Payment.dart';
import 'package:foolog/Services/blogManagement.dart';
// import 'package:foolog/Services/usermanagement.dart';
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
  // int _price;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius:30.0,
                          backgroundColor: Colors.cyan,
                          child:IconButton(icon: Icon(
                            Icons.photo,
                            color: Colors.white,
                            size: 30.0,
                          ), onPressed: () async {
                            PickedFile galleryFile = await _picker.getImage(
                              source:ImageSource.gallery,
                            );
                            setState(() {
                              _imageFile = galleryFile;
                            });
                            print("Your selected image is located at"+galleryFile.path);
                          },
                          ),
                        ),
                        SizedBox(width:5.0),
                        CircleAvatar(
                          radius:30.0,
                          backgroundColor: Colors.cyan,
                          child:IconButton(icon: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 30.0,
                          ), onPressed: () async {
                            PickedFile GalleryFile = await _picker.getImage(
                              source:ImageSource.camera,
                            );
                            setState(() {
                              _imageFile = GalleryFile;
                            });
                            print("Your selected image is located at"+GalleryFile.path);}
                          ),
                        ),
                      ],
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
                    fillColor: Colors.cyan,
                    filled:true,
                    errorStyle: TextStyle(color:Colors.cyan),
                    prefixIcon: Icon(
                      Icons.place_sharp,
                      color: Colors.black,
                    ),
                    hintText: 'Add Location',
                    hintStyle:TextStyle(
                      color:Colors.black,
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
                    errorStyle: TextStyle(color:Colors.cyan),
                    fillColor: Colors.cyan,
                    filled:true,
                    prefixIcon: Icon(
                      Icons.closed_caption,
                      color: Colors.black,
                    ),
                    hintText: 'Add Caption',
                    hintStyle:TextStyle(
                      color:Colors.black,
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
              SizedBox(height:10.0),
              Center(
                child:CircleAvatar(
                  radius:30.0,
                  backgroundColor: Colors.cyan,
                  child:IconButton(icon: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30.0,
                  ), onPressed: () {
                    if(_formKey.currentState.validate())
                    {
                      blogManagement().StoreBlog(_imageFile,_location,_caption,context);
                    }
                  }),
                ),
              ),
              SizedBox(height:10.0),
            ],
          )
        ),
        ),
      ),
    );
  }
}


