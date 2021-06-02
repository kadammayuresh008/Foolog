import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/UserSearchTile.dart';
import 'package:foolog/Screen/Profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  final  TextEditingController  _searchController = TextEditingController();
  bool _typing = false;
  String _query = "";

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
        :Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            leading:IconButton(icon:Icon(Icons.arrow_back),
              onPressed: () {
                print("Back");
                Navigator.pop(context);
              },),
            title:TextFormField(
              onChanged:(value){
                setState(() {
                  _typing = true;
                  _query=_searchController.text;
                });
              },
              style:TextStyle(
                color:Colors.white,
              ),
              controller:_searchController,
              maxLines: 1,
              decoration: InputDecoration(
                 // prefixIcon:Icon(
                 //   Icons.person,
                 //   color: Colors.white,
                 // ),
                  suffixIcon:Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
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
                  hintText: 'Search Friends!!!',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )
              ),
            ),
            actions: [
              _typing==true?
              IconButton(icon:Icon(Icons.clear),
                  onPressed: (){
                setState(() {
                  _typing = false;
                });
                _searchController.clear();
              }):Container(),
            ],
          ),

          body:userList.docs.length==0?
        Container(
          child: Center(
          child:Text(
            "Such username does not exist.",
          )))
          :ListView.builder(
              itemCount: userList.docs.length,
            itemBuilder:(BuildContext context,int Index){
            if(userList.docs[Index]["username"].toString().toLowerCase()
                .contains(_query.toLowerCase()))
            {
                return UserSearchTile(Index: Index,userList: userList,);
            }
            else{
              return Container();
            }
            }


    ),
          );
  }
}



