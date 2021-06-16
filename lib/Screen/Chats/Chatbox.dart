import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:foolog/Services/usermanagement.dart';
import 'package:foolog/models/MessageModel.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class Chatbox extends StatefulWidget {
  var username;
  var proImage;
  var uid;


  Chatbox({Key key,this.username,this.proImage,this.uid}): super(key: key);

  @override
  _ChatboxState createState() => _ChatboxState();
}


class _ChatboxState extends State<Chatbox> {
  final TextEditingController _msgcontroller = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  final List<Message> messageList = <Message>[];
  final _auth=FirebaseAuth.instance;
  String now = DateFormat("hh:mm").format(DateTime.now()); //To calculate current time
  bool _msgEmpty=true;
  IO.Socket socket;



  @override
  void initState(){
    super.initState();
    connect();
  }

  Future<dynamic> getCurrentUserId() async {
    List<dynamic> currentUserId= await UserManagement().getCurrentUsername(_auth.currentUser.uid);
    return currentUserId[3];
  }

  //to connect to socket io server
  void connect() async{
    socket = IO.io("https://arcane-thicket-78202.herokuapp.com/",<String,dynamic>
    {
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    String currentUserId = await getCurrentUserId();
    socket.emit("signin",currentUserId);
    socket.onConnect((data){
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination",msg["msg"]);
      }
      );
    });
    print(socket.connected);
  }

  void setMessage(String type,String msg)
  {
    Message message = Message(type:type,msg:msg);
    setState(() {
      messageList.add(message);
    });
    // _scrollController.animateTo(
    //   0.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
  }

  void sendMsg(String msg,String SourceId,String targetId){
    setMessage("source",msg);
    socket.emit("message",{"msg":msg, "SourceId":SourceId, "targetId":targetId,});
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
                          msg!=null?Text(msg,
                            style:TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,):
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
        ),
      ),
    );
  }


  //widget for icoming meassage.
  Widget _buildIncomingMessage(String msg){

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
                  msg!=null?Text(msg,
                style:TextStyle(
                  fontSize: 16.0,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,):
                  Text("No message",
                    style:TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,),
                  Text(now),
                ],
              ),
            ),

        ),
      ),
    );
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
                    child: widget.proImage==""?Image.asset(
                      "assets/Images/DeafultProfileImage.png",
                      height: 50.0,
                      width:50.0,
                    ):Image.network(
                      widget.proImage,
                      height: 50.0,
                      width:50.0,
                    )
                    ,
                  ),
                  radius:25.0,
                ),
            ),
            widget.username==null?Text("") : Text(widget.username),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: ListView.builder(
                    itemCount:messageList.length,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context,int index)
                  {
                    if(messageList[index].type=="source")
                      {
                       return _buildOutgoingMessage(messageList[index].msg);
                      }
                    else{
                      return _buildIncomingMessage(messageList[index].msg);
                    }
                    // return Text(messageList[messageList.length-index-1][msg]);
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
                  ) ,
                ),
              ),
              _msgEmpty==false?IconButton(
                icon:Icon(Icons.send,color: Colors.white,),
                onPressed: () async {
                  setState(() {
                    now= DateFormat("hh:mm").format(DateTime.now());
                    _msgEmpty=true;
                  });
                  String currentUserId = await getCurrentUserId();
                  sendMsg(_msgcontroller.text,currentUserId,widget.uid);
                  _msgcontroller.clear();
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
