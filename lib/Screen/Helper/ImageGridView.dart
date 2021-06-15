import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foolog/Screen/Profile/ImageView.dart';
import 'package:foolog/Services/usermanagement.dart';


class ImageGridView extends StatefulWidget {
  var uid;

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
  ImageGridView({Key key, @required this.uid}) : super(key: key);
}

class _ImageGridViewState extends State<ImageGridView> {

  List<Map<String,dynamic>> Photos=[];
  bool _empty=false;

  Future<bool> IsFollowing()async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    List<dynamic> follow = await UserManagement().getCurrentUsername();
    return follow[3].contains(widget.uid)?true:false;
  }

  Future<List<String>> getImages() async{
    List<Map<String,dynamic>> Images = await UserManagement().getUserPhoto(widget.uid);
    setState(() {
      Photos=Images;
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    IsFollowing().then((value){
      print(value);
      if(value==true)
        {
          getImages();
          _empty=false;
        }
      else{
        setState(() {
          _empty=true;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _empty?Container(
      child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outlined,
            color:Colors.black,
            size:50.0),
            Text("Follow to view photos",
                style:TextStyle(
                  fontSize: 20,
                )),
          ],
        )
      ),
    ):Photos.length==0?Center(
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
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ImageView(
                            userId:Photos[index]["userId"],
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
