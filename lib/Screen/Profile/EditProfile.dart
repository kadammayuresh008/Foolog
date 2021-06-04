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

  String username;
  String bio;
  String Ogusername;
  String Ogbio;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editUsername = TextEditingController();
  final TextEditingController _editBio = TextEditingController();

  Future<String> getUserDetails() async{
    await UserManagement().getCurrentUsername().then((value) {
      setState(() {
        username=value[0];
        bio=value[1];
        // username=value;
      });
    });
  }


  Future<CameraDescription> camera()async{
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getUserDetails();
    camera();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.clear,
              color:Colors.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title:Text("Edit Profile",
        style:TextStyle(color: Colors.black)
        ),
        backgroundColor:Colors.white,
      ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:20.0),
            Align(
              alignment: AlignmentDirectional.center,
              child: Form(
                key:_formKey,
                child: Column(
                          children: [
                            _imageFile==null?Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200.0),
                                  child: Image.network(
                                    "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                                    height: 200.0,
                                    width: 200.0,
                                  ),
                                ),
                                radius: 100.0,
                              ),
                            ):Container(
                              child: Image.file(
                                  File(_imageFile.path)
                              ),
                              width: double.infinity,
                              height: 250,
                            ),
                            SizedBox(height:20.0),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget>[
                                    IconButton(icon: Icon
                                      (Icons.camera,
                                    color:Colors.purple),
                                        onPressed: () async {
                                          PickedFile GalleryFile = await _picker.getImage(
                                            source:ImageSource.camera,
                                          );
                                          setState(() {
                                            _imageFile = GalleryFile;
                                          });
                                    }
                                    ),
                                    IconButton(icon: Icon(Icons.photo,
                                        color:Colors.purple),
                                      onPressed: () async {
                                        PickedFile galleryFile = await _picker.getImage(
                                          source:ImageSource.gallery,
                                        );
                                        setState(() {
                                          _imageFile = galleryFile;
                                        });
                                        print("Your selected image is located at"+galleryFile.path);
                                      },
                                        ),
                                  ]
                              ),
                            ),],
                        ),
              ),
            ),
            SizedBox(height:10.0),
            //Take location
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8 ),
            child:Text(
              "Username",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:20,
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8 ),
              child: TextFormField(
                controller:_editUsername,
                onChanged: (value) {
                  setState(() {
                    if(value.isEmpty || value==Ogusername)
                    {username = Ogusername;}
                    else{username=value;
                    }
                  });
                },
                validator:(value)
                {
                  if(value.isEmpty)
                    {
                      return "Usernamefield cannot be empty";
                    }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: username,
                  hintStyle: TextStyle(
                    color:Colors.black,
                  ),
                  errorStyle: TextStyle(color:Colors.purple),
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
            //Take location
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8 ),
            child:Text(
              "Bio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:20,
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8 ),
              child: TextFormField(
                controller: _editBio,
                onChanged: (value) {
                  setState(() {
                    if(value.isEmpty || value==Ogbio)
                      {bio = Ogbio;}
                    else{bio=value;
                    }
                  });
                },
                validator:(value){
                  if(value.isEmpty)
                    {
                     return "Bio field cannot be empty";
                    }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color:Colors.purple),
                  hintText: bio,
                  hintStyle: TextStyle(
                    color:Colors.black,
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
                  child: Text('Edit',
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
                    print(username);
                    print(bio);
                    print(_imageFile.path);
                    // UserManagement().updateUserProfile(username, bio, _imageFile, context);
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
                },),
            ),
          ],
        )
      )
    );
  }
}
