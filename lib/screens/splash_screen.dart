import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_splash_screen/begining_bloc.dart';
import 'package:note/bloc/bloc_splash_screen/begining_event.dart';
import 'package:note/bloc/bloc_splash_screen/begining_state.dart';
import 'package:note/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BeginingBloc>(context).add(BeginingStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LogoWidget(),
      ),
    );
  }
}
