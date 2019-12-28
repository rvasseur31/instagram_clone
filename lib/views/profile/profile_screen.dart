import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/functions/generateViewProfileImage.dart';

import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  final String uid;
  ProfileView({Key key, @required this.uid}): super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState(uid: this.uid);
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  TabController _tabBarController;

  List<dynamic> myImagesInstagram = [];

  String uid;

  @override
  void initState() {
    super.initState();
    _tabBarController = new TabController(length: 2, vsync: this);
    getPictures();
  }

  _ProfileViewState({@required this.uid});

  Future<void> getPictures() async{
    const url = "https://instagram-clone-ynov.herokuapp.com/getPictures";
    var response = await http.post(
      Uri.encodeFull(url),
      body: jsonEncode(
        {"uid": uid, "archived": false}
      ),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      myImagesInstagram = json.decode(response.body)["json"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          appBar(),
          pictureAndUserCounter(myImagesInstagram.length),
          description(),
          btnUpdateProfil(),
          pictures(myImagesInstagram.length.toDouble())
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 10.0, left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => {print("Arrow down + username")},
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "rafivsr",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          Container(
            child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.menu),
              onPressed: () {
                print("Click menu icon");
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget pictureAndUserCounter(int numberOfPicture) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png"),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                numberOfPicture.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.5,
              ),
              Text("Publications")
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "223",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.5,
              ),
              Text("Abonnés")
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "260",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.5,
              ),
              Text("Abonnement")
            ],
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'rafivsr',
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.2,
              ),
              Text(
                "Made in Toulouse 🔴⚫",
                textScaleFactor: 1.1,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget btnUpdateProfil() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Modifier le profil",
                textScaleFactor: 1.1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(color: AppColors.grey300),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget pictures(double numberOfPicture) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 1.0),
          child: TabBar(
            controller: _tabBarController,
            indicatorColor: Colors.black,
            tabs: [
              Container(
                child: Icon(
                  Icons.grid_on,
                  color: Colors.black,
                  size: 35.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.assignment_ind,
                  color: Colors.black,
                  size: 35.0,
                ),
              )
            ],
          ),
        ),
        Container(
          height: (width / 3.05) * (numberOfPicture / 3 + 1),
          child: TabBarView(
            controller: _tabBarController,
            children: <Widget>[myPictures(numberOfPicture), Container()],
          ),
        ),
      ],
    );
  }

  Widget myPictures(double numberOfPicture) {
    return Column(
      children: GenerateViewProfileImage(
              myImagesInstagram, MediaQuery.of(context).size.width)
          .generateColors(),
    );
  }
}
