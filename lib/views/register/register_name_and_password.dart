import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/app.dart';
import 'package:instagram_clone/bloc/authentication_bloc.dart';
import 'package:instagram_clone/bloc/authentication_event.dart';
import 'package:instagram_clone/components/editText/editText_input_decoration.dart';
import 'package:instagram_clone/user_repository.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/string.dart';
import 'package:instagram_clone/views/register/bloc/register_bloc.dart';
import 'package:instagram_clone/views/register/bloc/register_event.dart';
import 'package:instagram_clone/views/register/bloc/register_state.dart';

class RegisterNameAndPasswordStateless extends StatelessWidget {
  final UserRepository _userRepository;
  final String _email;

  RegisterNameAndPasswordStateless(
      {Key key,
      @required String email,
      @required UserRepository userRepository})
      : assert(email != null),
        assert(userRepository != null),
        _userRepository = userRepository,
        _email = email,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterNameAndPassword(
              email: _email, userRepository: _userRepository),
        ),
      ),
    );
  }
}

class RegisterNameAndPassword extends StatefulWidget {
  final String _email;
  final UserRepository _userRepository;

  RegisterNameAndPassword(
      {Key key,
      @required String email,
      @required UserRepository userRepository})
      : assert(email != null),
        assert(userRepository != null),
        _userRepository = userRepository,
        _email = email,
        super(key: key);

  @override
  _RegisterNameAndPasswordState createState() =>
      new _RegisterNameAndPasswordState(
          email: _email, userRepository: _userRepository);
}

class _RegisterNameAndPasswordState extends State<RegisterNameAndPassword> {
  String _email;
  UserRepository _userRepository;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated => _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  _RegisterNameAndPasswordState(
      {@required String email, @required UserRepository userRepository})
      : assert(email != null),
        assert(userRepository != null),
        _userRepository = userRepository,
        _email = email;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
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
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          //Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => App(
                  userRepository: _userRepository,
                ),
              ),
              (Route<dynamic> route) => false);
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
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
                        onPressed: () => {_onFormSubmitted()},
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
          email: _email,
          password: _passwordController.text,
          username: _usernameController.text),
    );
  }
}
