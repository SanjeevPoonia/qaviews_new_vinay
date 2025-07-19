
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_theme.dart';
import '../widgets.dart';
import 'app_screen.dart';
import 'login_screen.dart';

class UrlScreen extends StatefulWidget {
  const UrlScreen({super.key});

  @override
  UrlState createState() => UrlState();
}

class UrlState extends State<UrlScreen> {
  bool isObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var codeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double marginBottom = 50.0;
    return Container(
      color: AppTheme.themeColor,
      child: SafeArea(
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bacground.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                   // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: screenHeight/3.5),
                        width: 250,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/QAviews.png'),

                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        height: 50.0, // Set the height of the container
                        margin: EdgeInsets.symmetric(horizontal: 50.0), // Add left and right margin
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Border radius
                        ),
                        child: TextFormField(
                          validator: checkCodeValidator,
                          controller: codeController,
                          decoration: InputDecoration(
                            hintText: 'Enter code',
                            border: InputBorder.none, // Remove the default TextField border
                            contentPadding: EdgeInsets.all(10.0), // Adjust inner padding
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                         _submitHandler();
                        },
                        child: Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 50),
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppTheme.buttonColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 50,
                            child: const Center(
                              child: Text('Next',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            )),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Image.asset(
                          'assets/Qdegrees.png', // Replace with your image path
                          width: 150, // Set the desired width
                          height: 40, // Set the desired height
                        ),

                      ),
                    ],

                  ),
              ),
            ),
          )),
    );
  }
  void _submitHandler() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    validateUser();
  }


 /* Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => AppScreen()),
  (Route<dynamic> route) => false);*/

  String? checkCodeValidator(String? value) {
    if (value!.length < 2) {
      return 'Unique Code is required';
    }
    return null;
  }
  validateUser() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var requestModel = {
      "unique_client_code": codeController.text,
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('getClient', requestModel, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);

    if (responseJSON['status'] == 1) {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);
      MyUtils.saveSharedPreferences(
          'unique_code', codeController.text);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AppScreen()),
              (Route<dynamic> route) => false);
    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }
  }
}