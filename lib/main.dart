import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qaviews/utils/app_modal.dart';
import 'package:qaviews/view/splash_screen.dart';
/*
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
*/

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token=prefs.getString('auth_key')??'';
  print(token);
   if(token!='')
   {
     AppModel.setTokenValue(token.toString());
     AppModel.setLoginToken(true);
   }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  runApp( MyApp(token.toString()));
}

class MyApp extends StatelessWidget {

  final String token;
  MyApp(this.token);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QAViews',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      //debugShowCheckedModeBanner: false,
      home:SplashScreen(token),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
