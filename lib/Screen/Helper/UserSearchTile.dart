import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/UserList.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Profile/Profile.dart';
import 'package:foolog/Services/usermanagement.dart';

class UserSearchTile extends StatefulWidget {
  int Index;
  QuerySnapshot userList;
  bool follow;

  UserSearchTile({Key key, @required this.Index, @required this.follow,@required this.userList})
      : super(key: key);

  @override
  _UserSearchTileState createState() => _UserSearchTileState();
}

class _UserSearchTileState extends State<UserSearchTile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile(uid:widget.userList.docs[widget.Index]["uid"],follow:widget.follow)),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child:widget.userList.docs[widget.Index]["proImage"]==""?Image.asset(
                "assets/Images/DeafultProfileImage.png",
                height: 80.0,
                width: 80.0,
              ):Image.network(
                widget.userList.docs[widget.Index]["proImage"],
              height: 80.0,
              width: 80.0,
            ),
            ),
            radius: 25.0,
          ),
          trailing: RaisedButton(
            elevation: 0.0,
            child: widget.follow? Text("Follow",
                        style: TextStyle(
                          color: Colors.black,
                        )):Text("Unfollow",
                        style: TextStyle(
                          color: Colors.black,
                        )),
            color:widget.follow
                    ? Colors.purple:Colors.white,
            splashColor: Colors.purpleAccent,
            onPressed: () {
              setState(() {
                // follow = !widget.follow;
                UserManagement().followUnfollow(
                    widget.userList.docs[widget.Index]["uid"], widget.follow);
              });
            },
          ),
          title: Text(
            widget.userList.docs[widget.Index]["username"],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
