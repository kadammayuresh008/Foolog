import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Profile/Profile.dart';
import 'package:foolog/Services/usermanagement.dart';


class UserSearchTile extends StatefulWidget {
  int Index;
  QuerySnapshot userList;

  UserSearchTile({Key key,@required this.Index,@required this.userList}):super(key: key);

  @override
  _UserSearchTileState createState() => _UserSearchTileState();
}

class _UserSearchTileState extends State<UserSearchTile> {

  bool follow=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                height: 80.0,
                width: 80.0,
              ),
            ),
            radius: 25.0,
          ),
          trailing: RaisedButton(
            elevation: 0.0,
            child: follow?
            Text(
                "Follow",
                style: TextStyle(
                  color: Colors.black,
                )
            ):Text(
                "Unfollow",
                style: TextStyle(
                  color: Colors.black,
                )
            ),
            color: follow?Colors.purple:Colors.white,
            splashColor: Colors.purpleAccent,
            onPressed: () {
              setState(() {
                UserManagement().followUnfollow(widget.userList.docs[widget.Index]["uid"],follow);
                follow=!follow;
                print(follow);
              });
            },
          ),
          title: Text(widget.userList.docs[widget.Index]["username"],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
        ),
      ),
    );;
  }
}
