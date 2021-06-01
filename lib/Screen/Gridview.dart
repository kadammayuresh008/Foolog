import 'package:flutter/material.dart';


class Gridview extends StatefulWidget {
  @override
  _GridviewState createState() => _GridviewState();
}

class _GridviewState extends State<Gridview> {


  List<String> images =[
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
    "assets/Images/Image2.jfif",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:GridView.count(
          crossAxisCount: 2,
          children: List.generate(images.length, (index) {
            return Image.asset(images[index]);
          }),
    ));
  }
}
