import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/widgets/account_btn.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, opacity: 0.5),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Login Failure'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSubmitting) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Logging In...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (state.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedIn());
              //navigation to home page if the user authenticated
              // Navigator.of(context).push(FadeRoute(page: HomePage()));
              Navigator.of(context).pushAndRemoveUntil(
                  FadeRoute(page: HomePage()), ModalRoute.withName('hp'));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[],
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            _logInText("Account"),
                            _logInText("Login"),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(),
                      // ),
                      Expanded(
                        flex: 2,
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 20, color: Colors.white54)),
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              style: TextStyle(color: Colors.white),
                              autocorrect: false,
                              validator: (_) {
                                return !state.isEmailValid
                                    ? 'Invalid Email'
                                    : null;
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child:
                                  _textUnderForm("account email".toUpperCase()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 20, color: Colors.white54)),
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isPasswordValid
                                    ? 'Invalid Password'
                                    : null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: _textUnderForm(
                                        "account password".toUpperCase())),
                                FlatButton(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "forgot?".toUpperCase(),
                                    style: TextStyle(color: Colors.white38),
                                  ),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: RaisedWhiteButton(
                                    onPressed: _onFormSubmitted,
                                    text: Text(
                                      'Sign in'.toUpperCase(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    height: _height * 0.07,
                                    textColor: Colors.black54,
                                    // isLoginButtonEnabled(state)
                                    //     ? _onFormSubmitted
                                    //     : null,
                                    // color: Color.fromRGBO(249, 161, 154, 1),
                                  ),
                                ),
                                FlatTransparentButton(
                                  function: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginWithGooglePressed(),
                                    );
                                  },
                                  text: Text(
                                    'Sign in with Google',
                                  ),
                                ),
                                // CreateAccountButton(
                                //     userRepository: _userRepository),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginEmailChanged() {
    _loginBloc.add(
      LoginEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Widget _logInText(String text) {
    return Opacity(
        opacity: 0.05,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 50, letterSpacing: 2, fontWeight: FontWeight.bold),
        ));
  }

  Widget _textUnderForm(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.white38),
    );
  }
}
