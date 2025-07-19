import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qaviews/network/api_dialog.dart';
import 'package:qaviews/utils/app_theme.dart';
import 'package:qaviews/view/listening_audio_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../network/api_helper.dart';
import '../network/loader.dart';
import 'login_screen.dart';

class FilterAudioScreen extends StatefulWidget {
  ListeningState createState() => ListeningState();
}

class ListeningState extends State<FilterAudioScreen> {
  int selectedIndex = 1;
  bool isLoading=false;
  List<dynamic> processItems=[];
  List<dynamic> recordingList=[];
  final List<String> processTypeItems = [
  ];
  String? selectedProcessTypeValue;
  List<String> callTypeItems = [];
  List<dynamic> callListDynamic=[];
  String? selectedCallTypeValue;
  final List<String> callSubTypeItems = [
  ];
  List<dynamic> callSubListDynamic=[];
  String? selectedCallSubTypeValue;
  List<dynamic> locationDynamic=[];
  final List<String> locationTypeItems = [
  ];
  String? selectedLocationValue;

  List<dynamic> lobDynamic=[];

  final List<String> lobTypeItems = [

  ];
  String? selectedLobValue;

  List<dynamic> dispositionDynamic=[];

  final List<String> dispositionItems = [
  ];
  String? selectedDispositionValue;


List<dynamic> compaignDynamic=[];
  final List<String> compaignTypeItems = [

  ];
  String? selectedCompaignValue;

  List<dynamic> brandDynamic=[];

  final List<String> brandTypeItems = [

  ];
  String? selectedBrandValue;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.blueColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/logout.svg',
            width: 25,
            height: 25,
          ),
          onPressed: () {

            _logOut();
            // Add your right button action here
          },
        ),

     /*   actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/filter.svg',
                width: 22,
                height: 22,
              ),
              onPressed: () {
                _bottomSheetFilter();

              }
          ),
          IconButton(
              icon: SvgPicture.asset(
                'assets/notification.svg',
                width: 25,
                height: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NotifyScreen(true)));
              }
          ),
        ],*/

        title: Image.asset(
          'assets/porter.png',
          width: 100,
          height: 60,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:

      isLoading?
          Center(
            child:Loader()
          ):


      Column(
        children: [
          SizedBox(height: 18),
          Expanded(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  children: [
                Row(
                  children: [
                    Text('Filters',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16)),



                /*    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),*/

                  ],
                ),
                SizedBox(height: 15),
                Text('Call Type',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                SizedBox(height: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: selectedIndex == 1
                              ? Icon(Icons.radio_button_checked,
                                  color: AppTheme.fontLightBlueColor)
                              : Icon(Icons.radio_button_off)),
                      SizedBox(width: 10),
                      Text('Good Call',
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: selectedIndex == 0
                              ? Icon(Icons.radio_button_checked,
                                  color: AppTheme.fontLightBlueColor)
                              : Icon(Icons.radio_button_off)),
                      SizedBox(width: 10),
                      Text('Bad Call',
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Divider(
                      thickness: 1.5,
                    )),

                    SizedBox(height: 8),
                    Text('Process Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                          overlayColor: MaterialStateProperty.all<Color>(
                              AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                      //  itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                       // dropdownScrollPadding: EdgeInsets.zero,

                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Process',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: processTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedProcessTypeValue,
                        onChanged: (value) {
                          setState(() {
                            selectedProcessTypeValue = value as String;
                          });
                        },
                      /*  buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),

                    SizedBox(height: 12),

                    Text('Call Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                        //itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                       // dropdownScrollPadding: EdgeInsets.zero,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Call Type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: callTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedCallTypeValue,
                        onChanged: (value) {
                          setState(() {
                            selectedCallTypeValue = value as String;
                          });
                        },
                       /* buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),



                    SizedBox(height: 12),

                    Text('Call-Sub Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                       // itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                       // dropdownScrollPadding: EdgeInsets.zero,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Call-Sub Type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: callSubTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedCallSubTypeValue,
                        onChanged: (value) {
                          setState(() {
                            selectedCallSubTypeValue = value as String;
                          });
                        },
                       /* buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),



                    SizedBox(height: 12),

                    Text('Location Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                        //itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                        //dropdownScrollPadding: EdgeInsets.zero,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Location',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: locationTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedLocationValue,
                        onChanged: (value) {
                          setState(() {
                            selectedLocationValue = value as String;
                          });
                        },
                      /*  buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),

                    SizedBox(height: 12),

                    Text('LOB Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                        //itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select LOB',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: lobTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedLobValue,
                        onChanged: (value) {
                          setState(() {
                            selectedLobValue = value as String;
                          });
                        },
                     /*   buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),



                    SizedBox(height: 12),

                    Text('Disposition Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.blue)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                       // itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Disposition',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: dispositionItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedDispositionValue,
                        onChanged: (value) {
                          setState(() {
                            selectedDispositionValue = value as String;
                          });
                        },
                       /* buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),

                    SizedBox(height: 12),

                    Text('Compaign Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                       // itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                      //  dropdownScrollPadding: EdgeInsets.zero,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Compaign',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: compaignTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedCompaignValue,
                        onChanged: (value) {
                          setState(() {
                            selectedCompaignValue = value as String;
                          });
                        },
                       /* buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),


                    SizedBox(height: 12),

                    Text('Brand Type',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.fontLightBlueColor.withOpacity(0.4),
                              // Color of the shadow
                              spreadRadius: 0,
                              // Spread radius of the shadow
                              blurRadius: 2,
                              // Blur radius of the shadow
                              offset: Offset(0, 0), // Offset of the shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.5),
                          color:  Colors.white),
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppTheme.fontLightBlueColor)
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFFE0F4FF),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(10),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        underline: Container(),
                        //itemPadding: EdgeInsets.only(left: 10),
                        isExpanded: true,
                      //  dropdownScrollPadding: EdgeInsets.zero,
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppTheme.fontLightBlueColor,
                                size: 35),
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        hint: Text(
                          'Select Brand',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: brandTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedBrandValue,
                        onChanged: (value) {
                          setState(() {
                            selectedBrandValue = value as String;
                          });
                        },
                      /*  buttonHeight: 48,
                        itemHeight: 48,*/
                      ),
                    ),


                    SizedBox(height: 15)




                  ])),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Container(
              height: 51,
              margin: EdgeInsets.symmetric(vertical: 12,horizontal: 17),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(
                        Colors.white), // background
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        AppTheme.fontLightBlueColor), // fore
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ))),
                onPressed: () {
               if(selectedProcessTypeValue==null)
                 {
                   Toast.show("Please select a Process!",
                       duration: Toast.lengthLong,
                       gravity: Toast.bottom,
                       backgroundColor: Colors.red);
                 }
               else
                 {
                   applyFilter();
                 }
                },
                child: const Text(
                  'APPLY FILTER',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),




        ],
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRecordings();
  }





  applyFilter() async {

    int processID=0;
    for(int i=0;i<processItems.length;i++)
      {
        if(selectedProcessTypeValue==processItems[i]['name'])
          {
            processID=processItems[i]['id'];
            break;
          }
      }


    APIDialog.showAlertDialog(context,"Please wait...");

   /* var requestModel = {
        "good_bad_call":selectedIndex,
        "process_id":processID,
        "call_type":selectedCallTypeValue!=null?selectedCallTypeValue:"",
        "call_sub_type":selectedCallSubTypeValue!=null?selectedCallSubTypeValue:"",
        "location":selectedLocationValue!=null?selectedLocationValue:"",
        "lob":selectedLobValue!=null?selectedLobValue:"",
        "disposition":selectedDispositionValue!=null?selectedDispositionValue:"",
        "campaign_type":selectedCompaignValue!=null?selectedCompaignValue:"",
        "brand_type":selectedBrandValue!=null?selectedBrandValue:""

    };
*/

    var requestModel = {
      "good_bad_call":0,
      "process_id":53,
      "call_type":"inbound.call.dial",
      "call_sub_type":"DNA",
      "location":"PAN India",
      "lob":"IBCC_House_Shifting",
      "disposition":"Spot_ Call_HS",
      "campaign_type":"Porter_IBCC_House_Shifting",
      "brand_type":"PORTER"
    };



    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('searching', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);
    print(responseJSON);
    recordingList= responseJSON["data"];

   if(recordingList.length==0)
     {
       Toast.show("No data found !",
           duration: Toast.lengthLong,
           gravity: Toast.bottom,
           backgroundColor: Colors.red);
     }
   else
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ListeningAudioScreen(recordingList)));
     }

  }
  fetchRecordings() async {
    setState(() {
      isLoading=true;
    });

    var requestModel = {
      /*  "start_date":"2023-06-01",
      "end_date":"2023-10-30"*/
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('listenning_call_filters', requestModel, context);
    var responseJSON = json.decode(response.body);
    isLoading=false;
    setState(() {

    });
    print(responseJSON);
    processItems = responseJSON["data"]['process'];

    for(int i=0;i<processItems.length;i++)
      {
        processTypeItems.add(processItems[i]['name']);
      }

    callListDynamic= responseJSON["data"]['call_type'];


    for(int i=0;i<callListDynamic.length;i++)
    {
      if(callListDynamic[i]['call_type']!=null)
        {
          callTypeItems.add(callListDynamic[i]['call_type']);
        }
    }



    callSubListDynamic= responseJSON["data"]['call_sub_type'];

    for(int i=0;i<callSubListDynamic.length;i++)
    {

      if(callSubListDynamic[i]['call_sub_type']!=null)
        {
          callSubTypeItems.add(callSubListDynamic[i]['call_sub_type']);
        }


    }
    locationDynamic= responseJSON["data"]['location'];

    for(int i=0;i<locationDynamic.length;i++)
    {

      if(locationDynamic[i]['location']!=null)
        {
          locationTypeItems.add(locationDynamic[i]['location']);
        }
    }
    lobDynamic= responseJSON["data"]['lob'];


    for(int i=0;i<lobDynamic.length;i++)
    {

      if(lobDynamic[i]['lob']!=null)
        {
          lobTypeItems.add(lobDynamic[i]['lob']);
        }

    }


    dispositionDynamic= responseJSON["data"]['disposition'];

    for(int i=0;i<dispositionDynamic.length;i++)
    {

      if(dispositionDynamic[i]['disposition']!=null)
        {
          dispositionItems.add(dispositionDynamic[i]['disposition']);

        }

    }
    compaignDynamic= responseJSON["data"]['campaign_name'];

    for(int i=0;i<compaignDynamic.length;i++)
    {

      if(compaignDynamic[i]['campaign_name']!=null)
        {
          compaignTypeItems.add(compaignDynamic[i]['campaign_name']);

        }


    }
    brandDynamic= responseJSON["data"]['brand_name'];

    for(int i=0;i<brandDynamic.length;i++)
    {
      if(brandDynamic[i]['brand_name']!=null)
        {
          brandTypeItems.add(brandDynamic[i]['brand_name']);
        }



    }
    setState(() {});

  }

  _logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
  }
}
