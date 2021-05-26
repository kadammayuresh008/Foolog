import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:path/path.dart';


class Chatbox extends StatefulWidget {
  @override
  _ChatboxState createState() => _ChatboxState();
}


class _ChatboxState extends State<Chatbox> {
  @override

  final TextEditingController _msgcontroller = TextEditingController();


  //Widget for outgoing message
  Widget _buildOutgoingMessage(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 4, 4, 4),
      child: Container(
          width:250.0,
          decoration:BoxDecoration(
            color:Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child:Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                              height: 30.0,
                              width:30.0,
                            ),
                          ),
                          radius:15.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                            Text("Soul Travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),),
                      ]
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,8.0),
                child: Text("I Studied hard every day.Till my gardution which has resulted in back pain "
                    "and heachache sometimes. My height might not grow after this thing.",
                  style:TextStyle(
                    fontSize: 15.0,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,2.0,8.0,8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget>[
                    Text("12.08 pm"),
                  ],
                ),
              )
            ],
          )

      ),
    );
  }


  //widget for icoming meassage.
  Widget _buildIncomingMessage(){

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 150, 4),
      child: Container(
          width:250.0,
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                              height: 30.0,
                              width:30.0,
                            ),
                          ),
                          radius:15.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("Group Traveller",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18.0,
                          ),),
                      ]
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,8.0),
                child: Text("I Studied hard every day.Till my gardution which has resulted in back pain ",
                  style:TextStyle(
                    fontSize: 15.0,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,2.0,8.0,8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget>[
                    Text("12.08 pm"),
                  ],
                ),
              )
            ],
          )

      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(4.0,4.0,150.0,4.0),
    //   child: Container(
    //     width:250.0,
    //     decoration:BoxDecoration(
    //       color:Colors.white,
    //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
    //     ),
    //     child:Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: CircleAvatar(
    //                 backgroundColor: Colors.white,
    //                 child:ClipRRect(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                   child: Image.network(
    //                     "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
    //                     height:40.0,
    //                     width:40.0,
    //                   ),
    //                 ),
    //                 radius:20.0,
    //               ),
    //             ),
    //           ],
    //         ),
    //         Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //           children:[
    //             Text("Soul Travel",
    //             style: TextStyle(
    //             color: Colors.purple,
    //             fontSize: 16.0,
    //             ),),
    //             Text("I am a good Boy.",
    //             ),
    //           ]
    //         )
    //       ],
    //     )
    //   ),
    // );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_outlined,size: 30.0,),
        ),
        title:
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,8,0),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                      height: 50.0,
                      width:50.0,
                    ),
                  ),
                  radius:25.0,
                ),
            ),
            Text("Soul Travel"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
          child: Column(
            children: [
                  _buildIncomingMessage(),
                  _buildIncomingMessage(),
                  _buildOutgoingMessage(),
                  _buildOutgoingMessage(),
                  _buildIncomingMessage(),
                  _buildOutgoingMessage(),
              _buildIncomingMessage(),
                ],
              ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.purple,
          ),
          child: TextFormField(
            controller: _msgcontroller,
            decoration:const InputDecoration(
              hintText: "Enter Text",
              hintStyle: TextStyle(
                color:Colors.black,
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Icon(Icons.photo_sharp, color: Colors.black,),
              suffixIcon: Icon(Icons.send,color: Colors.black,),
            ) ,
          ),
          height: 60.0,
        ),
      ),
    );
  }
}
