import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
           icon:Icon(
             Icons.search,
             color: Colors.purple,
           ),
          onPressed: (){

          },
        ),
        backgroundColor: Colors.grey[100],
      ),
      body:SingleChildScrollView(

    )
    );
  }
}
