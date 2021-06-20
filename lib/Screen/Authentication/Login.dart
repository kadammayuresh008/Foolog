import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:foolog/Services/SocketIo.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Home/Home.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Authentication/Signup.dart';
import "package:foolog/Services/auth.dart";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  String _error="";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
                height:MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment
                        .bottomCenter, // 10% of the width, so there are ten blinds.
                    colors: [
                      Colors.purple[600],
                      Colors.purple[500],
                      Colors.purple[400],
                      Colors.purple[300],
                      Colors.white,
                    ], // red to yellow
                    tileMode: TileMode.repeated,
                  ),
                ),
                // color:Colors.purple,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 150.0),
                      Text("Foolog",
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                          )),
                      SizedBox(height: 20.0),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator:(value){
                          if(value.isEmpty){
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator:(value){
                          if(value.isEmpty){
                            return "Password field cannot be empty.";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled:true,
                          errorStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.purple,
                          ),
                          hintText: 'Enter password',
                          hintStyle: TextStyle(
                            color: Colors.purple,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(_error,
                      style: TextStyle(color: Colors.red),),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        child: Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        // borderSide: BorderSide(width:1.0,
                        //     color:Colors.white,
                        //     ),
                        color: Colors.purple,
                        onPressed: () async{
                          if(_formKey.currentState.validate())
                            {
                              dynamic result= await AuthService().SignInWithEmailAndPassword(_email, _password);
                              if(result==null)
                                {
                                  setState(() {
                                    _error = "Invalid credentials";
                                  });
                                }
                              else{
                                SocketIo().connect();
                                Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Home()),
                                        );
                              }
                            }
                            //   var result = await FirebaseAuth.instance
                            //       .signInWithEmailAndPassword(
                            //       email: _email, password: _password);
                            //   if(result.user!=null)
                            //   {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => Home()),
                            //     );
                            //   }
                            //   else
                            //   {
                            //     print("Error");
                            //   }
                            // }
                          }),
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Home()),
                          // )
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              )),
                          FlatButton(onPressed:(){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Signup())
                            );
                          },
                            child:Text("Sign up",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 18.0,
                              )),)
                        ],
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}
