import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final String uid;

  HomeView({Key key, @required this.uid}) : super(key: key);

  createState() => _HomeViewState(uid: uid);
}

class _HomeViewState extends State<HomeView> {
  final String uid;

  _HomeViewState({@required this.uid});

  @override
  Widget build(BuildContext context) {
      // return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.exit_to_app),
      //       onPressed: () {
      //         BlocProvider.of<AuthenticationBloc>(context).add(
      //           LoggedOut(),
      //         );
      //       },
      //     )
      //   ],
      // ),
      // body: 
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $uid')),
        ],
      );
  }
}