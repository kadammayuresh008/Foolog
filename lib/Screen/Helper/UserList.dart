import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final userList= Provider.of<QuerySnapshot>(context);
    return userList==null?
    Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
        backgroundColor: Colors.white,
      ),
    )
        :ListView.builder(
      itemCount: userList.docs.length,
        itemBuilder:(BuildContext context,int Index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.network(
                  "https://i.pinimg.com/originals/d5/45/a2/d545a2343d19f3ce8af9e9aa52dd3fce.jpg",
                  height: 80.0,
                  width:80.0,
                ),
              ),
              radius:25.0,
            ),
            trailing: RaisedButton(
              elevation:0.0,
              child: Text(
                "Follow",
                  style:TextStyle(
                  color:Colors.black,
              )
              ),
              color: Colors.purple,
              splashColor: Colors.purpleAccent,
              onPressed: () {},
            ),
            title: Text(userList.docs[Index]["username"],
            style: TextStyle(
                fontWeight: FontWeight.bold,
            ),),
          ),
        );
        }
    );
  }
}



