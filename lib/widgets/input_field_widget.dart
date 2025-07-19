import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labeltext;
   String? initialText;
  final controller;
  TextFieldWidget(
      {required this.labeltext, this.initialText,this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
          child: Text(
            labeltext,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D2226).withOpacity(0.5)),
          ),
        ),


        Container(
          height: 45,
          child: TextFormField(
            initialValue: initialText,
              controller: controller,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF707070),
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 13, 5),
                  //prefixIcon: fieldIC,
                /*  hintText: labeltext,
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                  )*/)),
        ),
      ],
    );
  }
}

class DisabledTextFieldWidget extends StatelessWidget {
  final String labeltext;
  final String initialText;
  DisabledTextFieldWidget(
      {required this.labeltext,required this.initialText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
          child: Text(
            labeltext,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D2226).withOpacity(0.5)),
          ),
        ),


        Container(
          height: 45,
          child: TextFormField(
              initialValue: initialText,
              enabled: false,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF707070),
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 13, 5),
                //prefixIcon: fieldIC,
                /*  hintText: labeltext,
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                  )*/)),
        ),
      ],
    );
  }
}

class TextFieldMultilineWidget extends StatelessWidget {
  final String labeltext;
  final String initialText;
  var controller;
  TextFieldMultilineWidget(
      {required this.labeltext,required this.initialText,this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
          child: Text(
            labeltext,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D2226).withOpacity(0.5)),
          ),
        ),


        Container(

          child: TextFormField(
              controller:controller,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF707070),
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 13, 5),
                //prefixIcon: fieldIC,
                /*  hintText: labeltext,
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                  )*/)),
        ),
      ],
    );
  }
}