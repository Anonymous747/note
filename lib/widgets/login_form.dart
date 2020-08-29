import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/bloc/bloc_login/bloc.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/alert_dialogs.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class LoginForm extends StatefulWidget {
  // final UserRepository _userRepository;
  final int colorIndex;

  LoginForm({Key key, this.colorIndex}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  // UserRepository get _userRepository => widget._userRepository;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          _logInText("Account"),
                          _logInText("Login"),
                        ],
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: _height * 0.15),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  helperText: 'Accoun email'.toUpperCase(),
                                  helperStyle: TextStyle(
                                      fontSize: 13, color: Colors.white38),
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
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counter: InkWell(
                                  child: Text(
                                    "forgot?".toUpperCase(),
                                    style: TextStyle(color: Colors.white38),
                                  ),
                                  onTap: AlertDialogs(context).forgotPressed,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 20, color: Colors.white54),
                                helperText: 'Accoun Password'.toUpperCase(),
                                helperStyle: TextStyle(
                                    fontSize: 13, color: Colors.white38),
                              ),
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
                          ],
                        ),
                      ),
                      // Expanded(
                      Positioned(
                        bottom: 1,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            RaisedWhiteButton(
                              onPressed: _onFormSubmitted,
                              text: Text(
                                'Sign in'.toUpperCase(),
                                style: TextStyle(fontSize: 15),
                              ),
                              height: _height * 0.08,
                              textColor:
                                  listColor[widget.colorIndex].colors.last,
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Sign in with Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginWithGooglePressed(),
                                );
                              },
                            )
                            // FlatTransparentButton(
                            //   function: () {
                            //     BlocProvider.of<LoginBloc>(context).add(
                            //       LoginWithGooglePressed(),
                            //     );
                            //   },
                            //   text: Text(
                            //     'Sign in with Google',
                            //   ),
                            // ),
                          ],
                        ),
                      ),
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
}
