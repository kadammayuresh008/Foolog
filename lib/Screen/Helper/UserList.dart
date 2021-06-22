import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/UserSearchTile.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'file:///C:/Users/kadam/AndroidStudioProjects/foolog/lib/Screen/Profile/Profile.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_search_bar/flutter_search_bar.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  final  TextEditingController  _searchController = TextEditingController();
  bool _typing = false;
  String _query = "";
  final _auth = FirebaseAuth.instance;
  List<String> UserIdList;
  bool follow;

  // Future<void> getCurrentUserId() async {
  //   List<dynamic> CurrentUserDoc = await UserManagement().getCurrentUsername();
  //   print(CurrentUserDoc);
  //   setState(() {
  //     UserIdList = CurrentUserDoc[3];
  //   });
  //   print("UserIdList");
  //   print(UserIdList);
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userList= Provider.of<QuerySnapshot>(context);
    return userList==null?
    Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
        backgroundColor: Colors.white,
      ),
    )
        :Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            leading:IconButton(icon:Icon(Icons.arrow_back),
              onPressed: () {
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
                    BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.cyan, width: 1.0),
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
            itemBuilder:(BuildContext context,int Index)
            {
              follow=userList.docs[Index]["Followers"].contains(_auth.currentUser.uid)?false:true;
            if((userList.docs[Index]["username"].toString().toLowerCase()
                .contains(_query.toLowerCase()) ||
                userList.docs[Index]["bio"].toString().toLowerCase()
                    .contains(_query.toLowerCase()))
                && userList.docs[Index]["uid"]!=_auth.currentUser.uid)
            {
                return UserSearchTile(Index: Index,
                    userList: userList,follow:follow);
            }
            else{
              return Container();
            }
            }


    ),
          );
  }
}



