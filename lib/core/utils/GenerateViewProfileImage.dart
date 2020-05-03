import 'package:flutter/material.dart';

class GenerateViewProfileImage {
  List<dynamic> picturesToShow;
  double width;
  double numberOfPicture;

  GenerateViewProfileImage(List<dynamic> picturesToShow, double width) {
    this.picturesToShow = picturesToShow;
    this.width = width;
    this.numberOfPicture = picturesToShow.length.toDouble();
  }

  List<Widget> generateColors() {
    int j = 0;
    List<Widget> pictureList = [];
    for (var i = 0;
        i < double.parse((numberOfPicture / 3 - 0.3).toStringAsFixed(0));
        i++) {
      pictureList.add(
        Container(
          margin: EdgeInsets.only(bottom: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(picturesToShow[j]["url"]),
                  ),
                ),
                width: width / 3.05,
                height: width / 3.05,
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(picturesToShow[j + 1]["url"]),
                  ),
                ),
                width: width / 3.05,
                height: width / 3.05,
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(picturesToShow[j + 2]["url"]),
                  ),
                ),
                width: width / 3.05,
                height: width / 3.05,
              ),
            ],
          ),
        ),
      );
      j += 3;
    }
    List<Widget> lastLineOfPicture = [];
    for (var i = 0; i < numberOfPicture % 3; i++) {
      lastLineOfPicture.add(
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(picturesToShow[j]["url"]),
            ),
          ),
          width: width / 3.05,
          height: width / 3.05,
        ),
      );
      j += 1;
    }
    if ((numberOfPicture % 3) != 0) {
      for (var i = 0; i < 3 - (numberOfPicture % 3); i++) {
        lastLineOfPicture.add(
          Container(
            color: Colors.transparent,
            width: width / 3.05,
            height: width / 3.05,
          ),
        );
      }
    }
    pictureList.add(
      Container(
        margin: EdgeInsets.only(bottom: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: lastLineOfPicture,
        ),
      ),
    );

    return pictureList;
  }
}
