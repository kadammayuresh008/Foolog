import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:foolog/Services/chatsManagement.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:foolog/models/MessageModel.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:giphy_picker/giphy_picker.dart';

class Chatbox extends StatefulWidget {
  var username;
  var proImage;
  var uid;

  Chatbox({Key key, this.username, this.proImage, this.uid}) : super(key: key);

  @override
  _ChatboxState createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  GiphyGif _gif;
  final TextEditingController _msgcontroller = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  List<Message> messageList = <Message>[];
  final _auth = FirebaseAuth.instance;
  String now =
      DateFormat("hh:mm").format(DateTime.now()); //To calculate current time
  bool _msgEmpty = true;
  IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
    getStoredMessages();
  }

  Future<List<dynamic>> getStoredMessages() async{
    List<dynamic> storedMessage = await chatsManagement().getMessage(_auth.currentUser.uid, widget.uid);
    List<Message> stored=[];
    for(var i=0;i<storedMessage.length;i++)
      {
        stored.add(Message(msg:storedMessage[i]["msg"],type:storedMessage[i]["type"],now:storedMessage[i]["now"]));
      }
    setState(() {
      messageList=stored;
    });
  }

  Future<dynamic> getCurrentUserId() async {
    List<dynamic> currentUserId =
        await UserManagement().getCurrentUsername(_auth.currentUser.uid);
    return currentUserId[3];
  }

  //to connect to socket io server
  void connect() async {
    socket =
        IO.io("https://arcane-thicket-78202.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    String currentUserId = await getCurrentUserId();
    socket.emit("signin", currentUserId);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["msg"]);
        Message message = Message(type: "destination", msg: msg["msg"],now:now);
        chatsManagement().addMessage( msg["targetId"],msg["SourceId"],message);
      });
    });
    print(socket.connected);
  }

  void setMessage(String type, dynamic msg) {
    Message message = Message(type: type, msg: msg,now:now);
    setState(() {
      messageList.add(message);
    });
    // _scrollController.animateTo(
    //   0.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
  }

  void sendMsg(dynamic msg, String SourceId, String targetId) {
    setMessage("source", msg);
    socket.emit("message", {
      "msg": msg,
      "SourceId": SourceId,
      "targetId": targetId,
    });
    Message message = Message(type: "source", msg: msg,now:now);
    if (messageList.length == 1) {
      chatsManagement().initiateChat(SourceId, targetId,message);
    } else {
      chatsManagement().addMessage(SourceId, targetId, message);
    }
  }

  //Widget for outgoing message
  Widget _buildOutgoingMessage(dynamic msg, String now) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 4, 4, 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                msg != null
                    ? msg.runtimeType == "GiphyGif"?Container(
                  child:GiphyImage.original(gif: msg,
                      height:150,
                      width:150),
                ):Text(
                        msg,
                        style:TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        msg,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                Text(now,
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //widget for icoming meassage.
  Widget _buildIncomingMessage(dynamic msg,String now) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 150, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                msg != null
                    ? msg.runtimeType == "GiphyGif"?Container(
                  child:GiphyImage.original(gif: msg,
                      height:150,
                      width:150),
                ):
                Text(
                        msg,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        "No message",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
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
        backgroundColor: Colors.cyan,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 30.0,
          ),
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: widget.proImage == ""
                      ? Image.asset(
                          "assets/Images/DeafultProfileImage.png",
                          height: 50.0,
                          width: 50.0,
                        )
                      : Image.network(
                          widget.proImage,
                          height: 50.0,
                          width: 50.0,
                        ),
                ),
                radius: 25.0,
              ),
            ),
            widget.username == null ? Text("") : Text(widget.username),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: ListView.builder(
          itemCount: messageList.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (messageList[index].type == "source") {
              return _buildOutgoingMessage(messageList[index].msg,messageList[index].now);
            } else {
              return _buildIncomingMessage(messageList[index].msg,messageList[index].now);
            }
            // return Text(messageList[messageList.length-index-1][msg]);
          },
        ),
      ),
      bottomSheet:_gif==null?Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child:Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.photo_sharp,
                  color: Colors.black,
                ),
                onPressed: () async {
                  // final gif = await GiphyPicker.pickGif(
                  //   context: context,
                  //   apiKey: 'kOr182gtnbgtDGgig3LwtqUjCfj5qO7h',
                  //   fullScreenDialog: false,
                  //   previewType: GiphyPreviewType.previewWebp,
                  //   decorator: GiphyDecorator(
                  //     showAppBar: false,
                  //     searchElevation: 4,
                  //     giphyTheme: ThemeData.dark().copyWith(
                  //       inputDecorationTheme: InputDecorationTheme(
                  //         border: InputBorder.none,
                  //         enabledBorder: InputBorder.none,
                  //         focusedBorder: InputBorder.none,
                  //         contentPadding: EdgeInsets.zero,
                  //       ),
                  //     ),
                  //   ),
                  // );
                  //
                  // if (gif != null) {
                  //   setState(() => _gif = gif);
                  // }
                },
              ),
              Flexible(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _msgEmpty = false;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: _msgcontroller,
                  decoration: const InputDecoration(
                    hintText: "Enter Text",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              _msgEmpty == false
                  ? IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        setState(() {
                          now = DateFormat("hh:mm").format(DateTime.now());
                          _msgEmpty = true;
                        });
                        String currentUserId = await getCurrentUserId();
                        sendMsg(_msgcontroller.text, currentUserId, widget.uid);
                        _msgcontroller.clear();
                      },
                    )
                  : Container(),
            ],
          ),
          height: 60.0,
        ),
      ) :Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.photo_sharp,
                color: Colors.black,
              ),
              onPressed: () async {
                final gif = await GiphyPicker.pickGif(
                  context: context,
                  apiKey: 'kOr182gtnbgtDGgig3LwtqUjCfj5qO7h',
                  fullScreenDialog: false,
                  previewType: GiphyPreviewType.previewWebp,
                  decorator: GiphyDecorator(
                    showAppBar: false,
                    searchElevation: 4,
                    giphyTheme: ThemeData.dark().copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                );

                if (gif != null) {
                  setState(() => _gif = gif);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: GiphyImage.original(gif: _gif,
                  height:150,
                  width:150),
                ),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: () async {
                setState(() {
                  now = DateFormat("hh:mm").format(DateTime.now());
                  _msgEmpty = true;
                });
                String currentUserId = await getCurrentUserId();
                sendMsg(_gif, currentUserId, widget.uid);
                setState(() {
                  _gif=null;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
