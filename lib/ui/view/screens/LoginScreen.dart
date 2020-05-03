import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/appColors.dart';
import 'package:instagram_clone/core/provider/userRepository.dart';
import 'package:instagram_clone/ui/view/screens/register/RegisterEmailScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List _language = ["Français", "English", "Español"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLanguage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentLanguage = _dropDownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String city in _language) {
      items.add(DropdownMenuItem(value: city, child: Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.0),
              width: width,
              height: 50.0,
              child: Align(
                alignment: Alignment.center,
                child: DropdownButton(
                  value: _currentLanguage,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: width / 2,
                  child: Image.asset('assets/img/logo.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.grey700, width: 1.0),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                            color: AppColors.grey700, width: 1.0),
                      ),
                      filled: true,
                      hintText:
                          "Numéro de téléphone, e-mail ou nom d'utilisateur",
                      fillColor: Colors.grey[200],
                    ),
                    autofocus: false,
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                    cursorColor: AppColors.grey700,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.grey700, width: 1.0),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                            color: AppColors.grey700, width: 1.0),
                      ),
                      filled: true,
                      hintText: "Mot de passe",
                      fillColor: Colors.grey[200],
                    ),
                    autofocus: false,
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                    cursorColor: AppColors.grey700,
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => userRepository.signIn(
                        _emailController.text, _passwordController.text),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    splashColor: Colors.blue,
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                    color: Colors.blue[500],
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Connexion',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  child: GestureDetector(
                    onTap: () => {print("Forgot password/account")},
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Infos de connexion oubliées ?',
                        style: TextStyle(color: Colors.grey[600]),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Obtenez de l\'aide pour vous connecter.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.grey[500],
                      )),
                      Container(
                        width: width / 8,
                        child: Text(
                          ' OU ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey[500],
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width / 1.15,
                  height: 50.0,
                  child: RaisedButton.icon(
                    onPressed: () => userRepository.signIn(
                        _emailController.text, _passwordController.text),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    splashColor: Colors.blue,
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                    color: Colors.blue[500],
                    icon: Container(
                      width: 20.0,
                      height: 20.0,
                      child: Image.asset('assets/img/facebook-logo.png'),
                    ),
                    label: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Se connecter en tant que Raphaël Vsr',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.grey[500],
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterEmailScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Vous n\'avez pas de compte ?',
                        style: TextStyle(color: Colors.grey[600]),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Inscrivez-vous.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentLanguage = selectedCity;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
