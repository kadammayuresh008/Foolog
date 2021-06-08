import 'package:flutter/material.dart';
import 'package:foolog/Screen/Profile/ImageView.dart';
import 'package:foolog/Services/usermanagement.dart';


class ImageGridView extends StatefulWidget {
  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {

  List<Map<String,dynamic>> Photos=[];


  Future<List<String>> getImages() async{
    List<Map<String,dynamic>> Images = await UserManagement().getCurrentUserPhoto();
    setState(() {
      Photos=Images;
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    getImages();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Photos.length==0?Center(
      child:Text(
        "No Post",
        style:TextStyle(
          fontSize: 30,
        )
      ),
    ):GridView.builder(
        itemCount:Photos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0.2,
        mainAxisSpacing: 0.2,
      ),
        itemBuilder: (BuildContext context, int index){
        return
          GestureDetector(
              onTap: (){
                print("pressed $index");
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ImageView(
                            index:Photos[index]["index"],
                            username: Photos[index]["username"],
                            caption: Photos[index]["caption"],
                            location: Photos[index]["location"],
                            likes: Photos[index]["likes"],
                            image:Photos[index]["image"],
                            comments: Photos[index]["comments"],
                            heart:Photos[index]["heart"],
                          ))
                        );
              },
              child:Image.network(Photos[index]["image"])
          );
      },
      );
  }
}
