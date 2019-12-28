import 'package:flutter/material.dart';
import 'package:instagram_clone/stateful_wrapper.dart';
import 'package:instagram_clone/views/home_page.dart';
import 'package:instagram_clone/views/pick_image_and_added_to_firebase.dart';
import 'package:instagram_clone/views/profile/profile_screen.dart';

enum TabItem { HOME, ADD_PICTURE, PROFILE }

class AuthenticatedApp extends StatefulWidget {
  final String uid;

  AuthenticatedApp({Key key, @required this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AuthenticatedAppState(uid: this.uid);
}

class AuthenticatedAppState extends State<AuthenticatedApp> {
  String uid;

  TabItem _currentTab = TabItem.HOME;

  Map<TabItem, StatefulWidget> _navigatorKeys;

  Map<TabItem, dynamic> _tabNames = {
    TabItem.HOME: {"icon": Icons.home, "title": "Home"},
    TabItem.ADD_PICTURE: {
      "icon": Icons.add_circle_outline,
      "title": "Add picture"
    },
    TabItem.PROFILE: {"icon": Icons.person, "title": "Profile"},
  };

  List<BottomNavigationBarItem> _generateBottomNavigationBar() {
    List<BottomNavigationBarItem> widgets = [];
    for (TabItem tabItem in TabItem.values) {
      widgets.add(BottomNavigationBarItem(
        icon: new Icon(_tabNames[tabItem]["icon"]),
        title: new Text(_tabNames[tabItem]["title"]),
      ));
    }
    return widgets;
  }

  AuthenticatedAppState({@required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentTab.index,
        items: _generateBottomNavigationBar(),
      ),
      body: StatefulWrapper(
        onInit: () => setState(() {
          _navigatorKeys = {
            TabItem.HOME: HomeView(
              uid: this.uid,
            ),
            TabItem.ADD_PICTURE: PickImageAndAddedToFirebase(
              uid: this.uid,
            ),
            TabItem.PROFILE: ProfileView(uid: this.uid),
          };
        }),
        child: _navigatorKeys[_currentTab],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentTab = TabItem.values[index];
    });
  }
}
