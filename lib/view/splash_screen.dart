

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qaviews/network/Utils.dart';
import 'package:qaviews/view/url_screen.dart';

import 'app_screen.dart';
import 'dashboard2.dart';
import 'filter_audio_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget
{
  final String token;
  SplashScreen(this.token);
  SplashState createState()=>SplashState();
}
class SplashState extends State<SplashScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/QAviews.png'),
              fit: BoxFit.contain,
            ),
          ),
        )
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _navigateUser();

  }

  _navigateUser() async {




    if(widget.token=='')
    {
      //change
      Timer(
          Duration(seconds: 2),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UrlScreen())));

    }
    else
    {

      String? role=await MyUtils.getSharedPreferences("role");

      if(role=="Client")
        {
          Timer(
              Duration(seconds: 2),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => FilterAudioScreen())));
        }
      else
        {
          Timer(
              Duration(seconds: 2),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen())));
        }



    }
  }
}
