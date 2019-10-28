import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_androidx/bloc/authentication_bloc.dart';
import 'package:instagram_clone_androidx/bloc/authentication_event.dart';
import 'package:instagram_clone_androidx/user_repository.dart';
import 'package:instagram_clone_androidx/utils/colors.dart';
import 'package:instagram_clone_androidx/views/login/bloc/login_bloc.dart';

import 'package:meta/meta.dart';

import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  List _language = ["Français", "English", "Español"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLanguage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentLanguage = _dropDownMenuItems[0].value;
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _language) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Echec de connexion'), Icon(Icons.error)],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Connexion...'), CircularProgressIndicator()],
              ),
            ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                width: width,
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: new DropdownButton(
                    value: _currentLanguage,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    width: width / 2,
                    child: Image.asset('assets/img/logo.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: width / 1.15,
                    height: 50.0,
                    child: new TextFormField(
                      controller: _emailController,
                      decoration: new InputDecoration(
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
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      cursorColor: AppColors.grey700,
                      obscureText: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: width / 1.15,
                    height: 50.0,
                    child: new TextFormField(
                      controller: _passwordController,
                      decoration: new InputDecoration(
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
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      cursorColor: AppColors.grey700,
                      obscureText: true,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Password' : null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: width / 1.15,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: _onFormSubmitted,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(7.0)),
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
                      child: new RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Infos de connexion oubliées ?',
                          style: new TextStyle(color: Colors.grey[600]),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Obtenez de l\'aide pour vous connecter.',
                              style: new TextStyle(
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
                          child: new Text(
                            ' OU ',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.grey[500]),
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
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoggingWithGooglePressed(),
                        );
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(7.0)),
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
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: Colors.grey[500],
                    )),
                    GestureDetector(
                      onTap: () => {print('Create account')},
                      child: new RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Vous n\'avez pas de compte ?',
                          style: new TextStyle(color: Colors.grey[600]),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Inscrivez-vous.',
                              style: new TextStyle(
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
        );
      }),
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

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoggingWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
