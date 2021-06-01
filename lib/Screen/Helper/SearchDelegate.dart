import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Helper/UserList.dart';
import 'package:foolog/Services/usermanagement.dart';
import 'package:foolog/models/User.dart';
import 'package:provider/provider.dart';

class SearchAppBarDelegate extends StatefulWidget {
  @override
  _SearchAppBarDelegateState createState() => _SearchAppBarDelegateState();
}

class _SearchAppBarDelegateState extends State<SearchAppBarDelegate> {
  @override
  Widget build(BuildContext context) {
    final userList= Provider.of<QuerySnapshot>(context);
    // List<QueryDocumentSnapshot> TotUser=userList.docs.toList();
    // print(TotUser);
    return Scaffold(
        appBar: AppBar(
          title: Text("Explore"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: _SearchAppBarDelegate());
              },
            )
          ],
          backgroundColor: Colors.purple,
        ),
        body: UserList(),
    );
  }
}


class _SearchAppBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 30),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final userList= Provider.of<QuerySnapshot>(context);
    // List<QueryDocumentSnapshot> TotUser=userList.docs.toList();
    // print(TotUser);
    List<Item> items = [
  Item(title: 'apple'),
  Item(title: 'mango'),
  Item(title: 'banana'),
  Item(title: 'pineapple'),
  Item(title: 'orange'),
  Item(title: 'oranges'),
];
    List<Item> suggestionList = query.isEmpty
        ? items
        : items.where((element) => element.title.contains(query)).toList();
    return suggestionList.isEmpty
        ? Text("no result found")
        : ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].title),
          onTap: () {
            showResults(context);
          },
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

class Item {
  final String title;

  Item({@required this.title});
}


