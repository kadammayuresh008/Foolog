import 'package:flutter/material.dart';
import 'package:foolog/Services/usermanagement.dart';


class ImageGridView extends StatefulWidget {
  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {

  List<String> Photos=[];


  Future<List<String>> getImages() async{
    List<String> Images = await UserManagement().getCurrentUserPhoto();
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
    return GridView.builder(
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
              },
              child:Image.network(Photos[index])
          );
      },
      );
  }
}
