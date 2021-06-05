import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
// import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class Chatbox extends StatefulWidget {
  @override
  _ChatboxState createState() => _ChatboxState();
}


class _ChatboxState extends State<Chatbox> {
  final TextEditingController _msgcontroller = TextEditingController();
  final List<Widget> message= <Widget>[];
  String now = DateFormat("hh:mm").format(DateTime.now()); //To calculate current time
  bool _msgEmpty=true;
  IO.Socket socket;



  @override
  void initState(){
    super.initState();
    connect();
  }

  //to connect to socket io server
  void connect(){
    socket = IO.io("http://192.168.0.106:5000",<String,dynamic>
    {
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
    socket.emit("/test","Hello world");
  }

  //Widget for outgoing message
  Widget _buildOutgoingMessage(String msg){

    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 4, 4, 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
              decoration:BoxDecoration(
                color:Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(msg,
                            style:TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,),
                          Text(now,
                          style:TextStyle(
                            color:Colors.white,
                          )),
                        ],
                      ),
                    ),
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children:<Widget>[
                  //         Text(now,
                  //         style:TextStyle(
                  //           color:Colors.white,
                  //         )),
                  //       ],
                  //     ),
                  //   )
                  // ],
                // ),

        ),
      ),
    );
  }


  //widget for icoming meassage.
  Widget _buildIncomingMessage(){

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 150, 4),
      child: Align(
        alignment:Alignment.centerLeft,
        child: Container(
            decoration:BoxDecoration(
              color:Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("hi my name is bakaa. How are u doing?",
                    style:TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,),
                  Text("12.08 pm"),
                ],
              ),
            ),

        ),
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

    //to add message to string
    void _addmessage(String msg,List<Widget> message){
      if(message.length==0)
        {
          setState(() {
            message.insert(0, _buildIncomingMessage());
            message.insert(1, _buildOutgoingMessage(msg));
          });
        }
      else {
        setState(() {
          message.insert(0, _buildOutgoingMessage(msg));
        });
      }
      // print(message);
    }

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: ListView.builder(
                    itemCount:message.length,
                    itemBuilder: (BuildContext context,int index)
                  {
                    return message[message.length-index-1];
                  },
                ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.purple,
          ),
          child: Row(
            children: [
              IconButton(
                icon:Icon(Icons.photo_sharp, color: Colors.white,),
                onPressed: (){
                  print("gallery Pressed");
                },
              ),
              Flexible(
                child: TextFormField(
                  onChanged: (value){
                    setState(() {
                      _msgEmpty=false;
                    });
                  },
                  style:TextStyle(
                    color:Colors.white,
                  ),
                  // validator: (value){
                  //   if(value.isEmpty)
                  //     {
                  //       setState(() {
                  //         _msgEmpty=true;
                  //       });
                  //     }
                  // },
                  controller: _msgcontroller,
                  decoration:const InputDecoration(
                    hintText: "Enter Text",
                    hintStyle: TextStyle(
                      color:Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    // prefixIcon: Icon(Icons.photo_sharp, color: Colors.black,),
                    // suffixIcon: Icon(Icons.send,color: Colors.black,),
                  ) ,
                ),
              ),
              _msgEmpty==false?IconButton(
                icon:Icon(Icons.send,color: Colors.white,),
                onPressed: (){
                  setState(() {
                    now= DateFormat("hh:mm").format(DateTime.now());
                    _msgEmpty=true;
                  });
                  _addmessage(_msgcontroller.text,message);
                  _msgcontroller.clear();
                  // print(now);
                  // print("Send");
                },
              ):Container(),
            ],
          ),
          height: 60.0,
        ),
      ),
    );
  }
}
