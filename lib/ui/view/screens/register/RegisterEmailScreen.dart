import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/core/constants/appColors.dart';
import 'package:instagram_clone/ui/components/editText/editText_input_decoration.dart';
import 'package:instagram_clone/ui/view/arguments/RegisterArguments.dart';

class RegisterEmailScreen extends StatefulWidget {
  @override
  _RegisterEmailScreenState createState() => new _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                width: width / 2.5,
                child: Image.asset('assets/img/profile-icon.png'),
              ),
              new Container(
                width: width / 1.15,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: new TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  tabs: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: new Text(
                        'TÉLÉPHONE',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: new Text(
                        'E-MAIL',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                width: width / 1.15,
                height: 80.0,
                child: new TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: width / 1.15,
                      height: 50.0,
                      child: new TextFormField(
                        decoration: editTextInputDecoration(
                            "téléphone", AppColors.grey300),
                        autofocus: false,
                        style: new TextStyle(fontFamily: "Poppins"),
                        cursorColor: AppColors.grey300,
                        keyboardType: TextInputType.phone,
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
                          controller: _emailController,
                          decoration: editTextInputDecoration(
                              "adresse email", AppColors.grey300),
                          autofocus: false,
                          style: new TextStyle(fontFamily: "Poppins"),
                          cursorColor: AppColors.grey300,
                          keyboardType: TextInputType.emailAddress
                          // validator: (_) {
                          //   return !state.isEmailValid ? 'Invalid Password' : null;
                          // },
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: width / 1.15,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/register-password',
                    arguments: RegisterArguments(_emailController.text),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(7.0)),
                  splashColor: Colors.blue,
                  hoverColor: Colors.blue,
                  focusColor: Colors.blue,
                  color: Colors.blue[500],
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Suivant',
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
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.grey[500],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: new RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Vous avez un compte ?',
                      style: new TextStyle(color: Colors.grey[600]),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Connectez-vous.',
                          style: new TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
