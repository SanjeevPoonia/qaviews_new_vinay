

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

import '../utils/app_theme.dart';
import '../widgets.dart';
import 'login_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<AppScreen> {
  bool isObscure = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: AppTheme.themeColor,
      child: SafeArea(
          child: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bacground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                 crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight/4),
                        width: 250,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/QAviews.png'),

                          ),
                        ),
                      ),
                  SizedBox(height: 200.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                    },
                    child: Container(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppTheme.buttonColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 50,
                        child: const Center(
                          child: Text('Get Started',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        )),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Qdegrees.png'),

                      ),
                    ),
                  ),
                ],

              )
            ),
          )),
    );
  }

}