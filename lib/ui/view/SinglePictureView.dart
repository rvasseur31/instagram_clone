import 'package:flutter/material.dart';
import 'package:instagram_clone/core/models/Comment.dart';

class SinglePictureView {
  BuildContext context;
  String _userName;
  String _userLinkPicture;
  bool _isLiked;
  int _numberOfLike;
  List<Comment> _commentList;
  String _location;

  SinglePictureView(this.context, this._userName, this._userLinkPicture,
      this._location, this._isLiked, this._numberOfLike, this._commentList);

  Widget returnView() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 12.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _userName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor: 1.1,
                            ),
                            Text(_location),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.more_vert), onPressed: () => {}),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () => {}),
                      IconButton(
                          icon: Icon(Icons.message), onPressed: () => {}),
                      IconButton(icon: Icon(Icons.send), onPressed: () => {}),
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.turned_in_not), onPressed: () => {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Aimé par ${_numberOfLike.toString()} personnes'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => {},
                    child: Text("Voir les 7 commentaires"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
