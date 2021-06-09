import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Authentication/Login.dart';
import 'package:foolog/Services/usermanagement.dart';
import "package:foolog/Services/auth.dart";
import 'package:foolog/models/UserModel.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _username;
  String _email;
  String _password;
  String _cpassword;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
           height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment
                    .bottomRight, // 10% of the width, so there are ten blinds.
                colors: [
                  Colors.purple[800],
                  Colors.purple[600],
                  Colors.purple[400],
                  Colors.purple[200],
                  Colors.white,
                ], // red to yellow
                tileMode: TileMode.repeated,
              ),
            ),
            width: double.infinity,
            child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    // CircleAvatar(
                    //   backgroundColor: Colors.purple[500],
                    //   radius:50,
                    //   child:Image.asset("assets/Images/Icon.png",
                    //   height:200.0,
                    //   width: 200.0,),
                    // ),
                    // SizedBox(height:5.0),
                    Text("Foolog",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontFamily:'Pacifico',
                          color: Colors.white,
                        )),
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      validator:(value){
                        if(value.isEmpty)
                          {
                            return "Username field cannot be empty.";
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled:true,
                        errorStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        hintText: 'Enter Username',
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                        //Do something with the user input.
                      },
                      validator:(value){
                        if(value.isEmpty)
                        {
                          return "Email field cannot be empty.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled:true,
                        errorStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email_sharp,
                          color: Colors.purple,
                        ),
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                        setState(() {
                          _password = value;
                        });
                      },
                      validator:(value){
                        if(value.isEmpty)
                        {
                          return "Password field cannot be empty.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled:true,
                        errorStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.purple,
                        ),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                        setState(() {
                          _cpassword = value;
                        });
                      },
                      validator:(value){
                        if(value.isEmpty)
                        {
                          return "Confirm password field cannot be empty.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled:true,
                        errorStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.purple,
                        ),
                        hintText: 'Confirm password',
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text('Signup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Colors.purple,
                      onPressed: () async{
                        if(_formKey.currentState.validate())
                          {
                            Users result = await AuthService().CreateUserWithEmailandPassword(_email,_password);
                            if(result==null)
                              {
                                print("Error in creating user.");
                              }
                            else{
                              UserManagement().StoreNewUser(result,_username,context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Home()),
                              // );
                              // print(result.user);
                            }
                            // FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //     email: _email, password: _password)
                            //     .then((signedInUser) {
                            //   // print(signedInUser.user.displayName);
                            //   // setState(() {
                            //   //   var x= signedInUser.user.displayName.toString();
                            //   //   x=_username;
                            //   // });
                            //   // print(signedInUser.user.displayName);
                            //   //    signedInUser.user.displayName=_username;
                            //
                            // }).catchError((e) {
                            //   print(e);
                            // });
                          }
                      },
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
                        FlatButton(onPressed:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login())
                          );
                        },
                          child:Text("Login",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 18.0,
                              )),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
      )),
    );
  }
}
