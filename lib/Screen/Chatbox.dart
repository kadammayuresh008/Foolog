import "package:flutter/material.dart";


class Chatbox extends StatefulWidget {
  @override
  _ChatboxState createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  @override
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
        child:Text("Mayuresh"),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.purple,
          ),
          child:Row(
            children: <Widget>[
              // TextField(),
              IconButton(icon: Icon(Icons.send,color: Colors.white,)
                  , onPressed: (){})
            ],
          ),
          height: 60.0,
        ),
      ),
    );
  }
}
