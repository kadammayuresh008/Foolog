import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  String username;
  String bio;
  String Ogusername;
  String Ogbio;
  String ProImage;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _editUsername = TextEditingController();
  TextEditingController _editBio = TextEditingController();

  Future<String> getUserDetails() async {
    await UserManagement()
        .getCurrentUsername(_auth.currentUser.uid)
        .then((value) {
      setState(() {
        Ogusername = value[0];
        Ogbio = value[1];
        ProImage = value[2];
        _editUsername = TextEditingController(text:Ogusername);
        _editBio = TextEditingController(text:Ogbio);
        // username=value;
      });
    });
  }

  Future<CameraDescription> camera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    camera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.cyan,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.center,
              child: Form(
                key: _formKey,
                child: Container(
                  decoration:BoxDecoration(
                    color:Colors.cyan,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      _imageFile == null
                          ? Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200.0),
                                  child: Image.network(
                                    ProImage,
                                    height: 200.0,
                                    width: 200.0,
                                  ),
                                ),
                                radius: 100.0,
                              ),
                            )
                          : Container(
                              child: Image.file(File(_imageFile.path)),
                              width: double.infinity,
                              height: 250,
                            ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.camera, color: Colors.white),
                                  onPressed: () async {
                                    PickedFile GalleryFile =
                                        await _picker.getImage(
                                      source: ImageSource.camera,
                                    );
                                    setState(() {
                                      _imageFile = GalleryFile;
                                    });
                                  }),
                              IconButton(
                                icon: Icon(Icons.photo, color: Colors.white),
                                onPressed: () async {
                                  PickedFile galleryFile = await _picker.getImage(
                                    source: ImageSource.gallery,
                                  );
                                  setState(() {
                                    _imageFile = galleryFile;
                                  });
                                  print("Your selected image is located at" +
                                      galleryFile.path);
                                },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            //Take location
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                "Username",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextFormField(
                controller:_editUsername,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Username field cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.black,),
                  fillColor: Colors.cyan,
                  filled:true,
                  errorStyle: TextStyle(color: Colors.cyan),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            //Take location
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                "Bio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextFormField(
                controller: _editBio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bio field cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.assignment,color: Colors.black,),
                  fillColor: Colors.cyan,
                  filled:true,
                  errorStyle: TextStyle(color: Colors.cyan),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child:CircleAvatar(
                radius:30.0,
                backgroundColor: Colors.cyan,
                child:IconButton(icon: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 30.0,
                ), onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    if (_imageFile == null) {
                      UserManagement().updateUserProfile(
                          _editUsername.text, _editBio.text, _imageFile, ProImage, context);
                    } else {
                      UserManagement().updateUserProfile(
                          _editUsername.text, _editBio.text, _imageFile, ProImage, context);
                    }
                    // _scaffoldKey.currentState.showSnackBar(
                    //     new SnackBar(
                    //       content: new Text('Your Blog has been Added.',
                    //           style:TextStyle(
                    //             color:Colors.white,
                    //           )),
                    //       action: SnackBarAction(
                    //         label: 'ok',
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => Home()),
                    //           );
                    //         },
                    //       ),
                    //       backgroundColor: Colors.green.withOpacity(0.8),
                    //     )
                    // );
                  }
                }),
              ),
            ),
            // Center(
            //   child: RaisedButton(
            //     child: Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: Text('Edit',
            //           style: TextStyle(
            //             color: Colors.white,
            //           )),
            //     ),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: new BorderRadius.circular(10.0)),
            //     hoverColor: Colors.cyan,
            //     highlightColor: Colors.cyan,
            //     highlightElevation: 0.5,
            //     color: Colors.cyan,
            //     onPressed: () {
            //       if (_formKey.currentState.validate()) {
            //         if (_imageFile == null) {
            //           UserManagement().updateUserProfile(
            //               _editUsername.text, _editBio.text, _imageFile, ProImage, context);
            //         } else {
            //           UserManagement().updateUserProfile(
            //               _editUsername.text, _editBio.text, _imageFile, ProImage, context);
            //         }
            //         // _scaffoldKey.currentState.showSnackBar(
            //         //     new SnackBar(
            //         //       content: new Text('Your Blog has been Added.',
            //         //           style:TextStyle(
            //         //             color:Colors.white,
            //         //           )),
            //         //       action: SnackBarAction(
            //         //         label: 'ok',
            //         //         onPressed: () {
            //         //           Navigator.push(
            //         //             context,
            //         //             MaterialPageRoute(builder: (context) => Home()),
            //         //           );
            //         //         },
            //         //       ),
            //         //       backgroundColor: Colors.green.withOpacity(0.8),
            //         //     )
            //         // );
            //       }
            //     },
            //   ),
            // ),
          ],
        )));
  }
}
