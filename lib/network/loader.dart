
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_theme.dart';


class Loader extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Container(
        child: Center(
          child:
          SizedBox(
            height: 130,
            width: 130,
            child: Lottie.asset('assets/loadar.json'),
          ),
        ),
      ),
    );
  }

}