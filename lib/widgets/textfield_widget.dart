import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class TextFieldShow extends StatelessWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  final String? Function(String?)? validator;
  var controller;

  TextFieldShow(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          validator: validator != null ? validator : null,
          controller: controller != null ? controller : null,
          style: const TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              //contentPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 13, 5),
              //prefixIcon: fieldIC,
              suffix: fieldIC,
              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldDisabled extends StatelessWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  final String? Function(String?)? validator;
  var controller;

  TextFieldDisabled(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          cursorHeight: 28,
          enabled: false,
          validator: validator != null ? validator : null,
          controller: controller != null ? controller : null,
          style: const TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              // contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5),
              //prefixIcon: fieldIC,
              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldNumber extends StatelessWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  final String? Function(String?)? validator;
  var controller;

  TextFieldNumber(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            transform: Matrix4.translationValues(5.0, 15, 0.0),
            child: Text("Mobile Number",style:  TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
            )),
          ),
          
          
          TextFormField(
              cursorHeight: 22,
              validator: validator != null ? validator : null,
              controller: controller != null ? controller : null,
              maxLength: 10,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 15.0,
                height: 1.6,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(3.0, 19.5, 0.0, 0),
                  prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 30),
                  prefixIcon:
                      Padding(
                          padding: EdgeInsets.only(left: 5,top: 20,right: 2),child: Text('+91',style: const TextStyle(
                        fontSize: 15.0,
                        height: 1.6,
                        color: Colors.black,
                      ))),
                  errorMaxLines: 2)),
        ],
      ),
    );
  }
}

class TextFieldShow2 extends StatelessWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldShow2(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: fieldIC,
              ),
              // contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5),
              //  prefixIcon: fieldIC,

              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldAddress extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldAddress(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      this.validator});

  TextFieldState createState() => TextFieldState();
}

class TextFieldState extends State<TextFieldAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              // contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5),
              //prefixIcon: fieldIC,

              labelText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
class TextFieldFeedBack extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldFeedBack(
      {required this.labeltext,
        required this.fieldIC,
        required this.suffixIc,
        this.controller,
        this.validator});

  TextFieldStateFeedBack createState() => TextFieldStateFeedBack();
}

class TextFieldStateFeedBack extends State<TextFieldFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          maxLines: 3,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border:
              OutlineInputBorder(
                borderSide:
                const BorderSide(
                  width: 1,
                  color: Colors.grey,
                  style:
                  BorderStyle.none,
                ),
                borderRadius:
                BorderRadius
                    .circular(4.0),
              ),
              filled: true,
              fillColor: AppTheme.lightgrayColor,
             // border: InputBorder.none,
              hintText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
class TextFieldLogin extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldLogin(
      {required this.labeltext,
        required this.fieldIC,
        required this.suffixIc,
        this.controller,
        this.validator});

  TextFieldStateLogin createState() => TextFieldStateLogin();
}

class TextFieldStateLogin extends State<TextFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border:
              OutlineInputBorder(
                borderSide:
                const BorderSide(
                  width: 1,
                  color: Colors.grey,
                  style:
                  BorderStyle.none,
                ),
                borderRadius:
                BorderRadius
                    .circular(8.0),
              ),
              filled: true,
              prefixIcon: Icon(Icons.person),
             fillColor: Colors.transparent,
              // border: InputBorder.none,
              hintText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
class TextFieldEmail extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldEmail(
      {required this.labeltext,
        required this.fieldIC,
        required this.suffixIc,
        this.controller,
        this.validator});

  TextFieldStateEmail createState() => TextFieldStateEmail();
}

class TextFieldStateEmail extends State<TextFieldEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border:
              OutlineInputBorder(
                borderSide:
                const BorderSide(
                  width: 1,
                  color: Colors.grey,
                  style:
                  BorderStyle.none,
                ),
                borderRadius:
                BorderRadius
                    .circular(4.0),
              ),
              filled: true,
              fillColor: AppTheme.lightgrayColor,
              // border: InputBorder.none,
              hintText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
class TextFieldPass extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldPass(
      {required this.labeltext,
        required this.fieldIC,
        required this.suffixIc,
        this.controller,
        this.validator});

  TextFieldStatePass createState() => TextFieldStatePass();
}

class TextFieldStatePass extends State<TextFieldPass> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border:
              OutlineInputBorder(
                borderSide:
                const BorderSide(
                  width: 1,
                  color: Colors.grey,
                  style:
                  BorderStyle.none,
                ),
                borderRadius:
                BorderRadius
                    .circular(8.0),
              ),
              filled: true,
              prefixIcon: Icon(Icons.lock),
              fillColor: Colors.transparent,
              // border: InputBorder.none,
              hintText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
class TextFieldMobile extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  final String? Function(String?)? validator;

  TextFieldMobile(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      this.validator});

  TextFieldMobileState createState() => TextFieldMobileState();
}

class TextFieldMobileState extends State<TextFieldMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          keyboardType: TextInputType.number,
          controller: widget.controller,
          validator: widget.validator == null ? null : widget.validator,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              errorMaxLines: 2,
              // contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5),
              //prefixIcon: fieldIC,
              labelText: widget.labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldProfile extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  bool enabled;
  final String? Function(String?)? validator;

  TextFieldProfile(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      required this.enabled,
      this.validator});

  TextFieldState22 createState() => TextFieldState22();
}

class TextFieldState22 extends State<TextFieldProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: widget.enabled,
          validator: widget.validator,
          controller: widget.controller,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              height: 1.6,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0),
              filled: true,
              fillColor:
                  widget.enabled ? Colors.white : Colors.grey.withOpacity(0.2),
              hintText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldPhone extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  var isEnabled;

  TextFieldPhone(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      this.isEnabled});

  TextFieldPhoneState createState() => TextFieldPhoneState();
}

class TextFieldPhoneState extends State<TextFieldPhone> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: widget.isEnabled == null ? true : widget.isEnabled,
          keyboardType: TextInputType.number,
          controller: widget.controller,
          style: const TextStyle(
              fontSize: 15.0,
              height: 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              filled: true,
              fillColor: widget.isEnabled
                  ? Colors.white
                  : Colors.grey.withOpacity(0.3),
              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0),
              //prefixIcon: fieldIC,

              hintText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldWithIcon extends StatelessWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;

  TextFieldWithIcon(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: false,
        controller: controller,
        style: const TextStyle(
          fontSize: 15.0,
          height: 1.6,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            // contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5),
            //prefixIcon: fieldIC,
            suffixIcon: Container(
              child: fieldIC,
            ),
            labelText: labeltext,
            labelStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
            )));
  }
}

class TextFieldWidget extends StatelessWidget {
  String labeltext;
  Widget fieldIC;
  Icon suffixIc;
  var controller;
  var isEnabled;
  final String? Function(String?)? validator;

  TextFieldWidget(
      {required this.labeltext,
      required this.fieldIC,
      required this.suffixIc,
      this.controller,
      this.isEnabled,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: isEnabled == null ? true : isEnabled,
          validator: validator != null ? validator : null,
          controller: controller,
          style: TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                  minHeight: 15,
                  minWidth: 15
              ),
              contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
              suffixIcon: Container(
                child: fieldIC,
              ),
              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class TextFieldSeller extends StatelessWidget {
  String labeltext;
  var controller;
  var isEnabled;
  final String? Function(String?)? validator;

  TextFieldSeller(
      {required this.labeltext,
      this.controller,
      this.isEnabled,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: isEnabled == null ? true : isEnabled,
          validator: validator != null ? validator : null,
          controller: controller,
          style: TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  String labeltext;
  Icon suffixIc;
  final String? Function(String?)? validator;
  var controller;

  CustomTextFieldWidget(
      {required this.labeltext,
      required this.suffixIc,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          validator: validator,
          controller: controller,
          style: TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Row(
                children: [
                  Text(labeltext),
                  const Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class PhoneTextFieldWidget extends StatelessWidget {
  String labeltext;
  final String? Function(String?)? validator;
  var controller;

  PhoneTextFieldWidget(
      {required this.labeltext, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 15.0,
            height: 1.6,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              errorMaxLines: 2,
              label: Row(
                children: [
                  Text(labeltext),
                  const Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}

class PinTextFieldWidget extends StatelessWidget {
  String labeltext;

  PinTextFieldWidget({required this.labeltext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            height: 1.6,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: labeltext,
              labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}
