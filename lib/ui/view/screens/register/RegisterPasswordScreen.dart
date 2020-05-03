import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/appColors.dart';
import 'package:instagram_clone/core/constants/appStrings.dart';
import 'package:instagram_clone/core/provider/userRepository.dart';
import 'package:instagram_clone/core/utils/GlobalUtils.dart';
import 'package:instagram_clone/root.dart';
import 'package:instagram_clone/ui/components/editText/editText_input_decoration.dart';
import 'package:instagram_clone/ui/view/arguments/RegisterArguments.dart';
import 'package:provider/provider.dart';

class RegisterPasswordScreen extends StatefulWidget {
  RegisterPasswordScreen({Key key}) : super(key: key);

  @override
  _RegisterPasswordScreenState createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool get isPopulated => _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final RegisterArguments arguments =
        ModalRoute.of(context).settings.arguments;
    final userRepository = Provider.of<UserRepository>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NOM ET MOT DE PASSE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: new TextFormField(
                    controller: _usernameController,
                    decoration: editTextInputDecoration(
                        "Prénom et nom", AppColors.grey300),
                    autofocus: false,
                    style: new TextStyle(fontFamily: "Poppins"),
                    cursorColor: AppColors.grey300,
                    keyboardType: TextInputType.text,
                    // validator: (_) {
                    //   return !state.isEmailValid ? 'Invalid Password' : null;
                    // },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: new TextFormField(
                    controller: _passwordController,
                    decoration: editTextInputDecoration(
                        "Mot de passe", AppColors.grey300),
                    autofocus: false,
                    style: new TextStyle(fontFamily: "Poppins"),
                    cursorColor: AppColors.grey300,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    // validator: (_) {
                    //   return !state.isEmailValid ? 'Invalid Password' : null;
                    // },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      _scaffoldKey.currentState
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Inscription...'),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      if (await userRepository.register(
                          arguments.email, _passwordController.text)) {
                        GlobalUtils().resetAndOpenPage(context, Root());
                      } else {
                        _scaffoldKey.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Echec lors de l\'inscription'),
                                  Icon(Icons.error),
                                ],
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7.0)),
                    splashColor: Colors.blue,
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                    color: Colors.blue[500],
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Continuer',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              AppStrings.contactSyncRegisterExplication,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _registering() async {}

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
