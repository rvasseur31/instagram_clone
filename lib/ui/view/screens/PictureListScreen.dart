import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/view/SinglePictureView.dart';

class PictureListScreen extends StatefulWidget {
  PictureListScreen({Key key}) : super(key: key);

  @override
  _PictureListScreenState createState() => _PictureListScreenState();
}

class _PictureListScreenState extends State<PictureListScreen> {

  SinglePictureView singlePictureView;
  

  @override
  Widget build(BuildContext context) {
    singlePictureView = new SinglePictureView(context, "rafivsr", null, "Everglades National Park", false, 5, null);
    return Container(
       child: singlePictureView.returnView(),
    );
  }
}