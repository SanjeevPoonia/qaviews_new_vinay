import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qaviews/network/loader.dart';
import 'package:qaviews/view/listening_audio_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../utils/app_theme.dart';
import 'calender_screen.dart';
import 'filter_audio_screen.dart';
import 'login_screen.dart';
import 'notification.dart';

class Dashboard2 extends StatefulWidget {
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard2> {
  bool isLoading=false;
  String startDate="";
  String endDate="";
  String dateRange="";
  late ExpandedTileController _controller;
  late ExpandedTileController _controller2;
  String communicationPer='';
  String processPer='';
  String systemPer='';
  List<dynamic> rebuttalAudits=[];
  Map<String,dynamic> dashboardData={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body:

      // isLoading?
      //     Center(
      //       child: Loader(),
      //     ):
      ListView(
        children: [
          SizedBox(height: 5),
          dashboardData.isNotEmpty?
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderView()));
                    if(result!=null)
                    {
                      List<String> list=result.toString().split(',');
                      print(list[0]);
                      startDate=list[0].trim();
                      endDate=list[1].trim();
                      print("date range");
                      print(startDate);
                      print(endDate);

                      dateRange=startDate+" - "+endDate;



                     setState(() {

                     });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                        Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.fontLightBlueColor),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/calender_icc.png",
                                      width: 14, height: 14),
                                  SizedBox(width: 5),
                                  Text(
                                    dateRange,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF1D2226)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1.5,
                                color: Color(0xFF707070).withOpacity(0.50),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Audit Scores Summary',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterAudioScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F0F0),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Color(0xFFDFDFDF), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 0), // Offset of the shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      'Total Audits',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: AppTheme.fontLightBlueColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Text(
                                            dashboardData['audit_count'].toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 3),
                                              child: Text(
                                                '23%',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF25EE18),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'last month',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFA3A3A3),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                        margin: EdgeInsets.only(top: 13),
                                        child: Image.asset("assets/d1.png",
                                            width: 32, height: 32))
                                  ]),
                                  SizedBox(height: 3),
                                ],
                              ),
                            ),
                          ),
                          flex: 1),
                      SizedBox(width: 10),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F0F0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFFDFDFDF), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'Quality Score',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppTheme.fontLightBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          dashboardData['quality_score'].toStringAsFixed(2)+"%",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              '23%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFEE1818),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'last month',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFA3A3A3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Image.asset("assets/d2.png",
                                          width: 37, height: 37))
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          flex: 1)
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F0F0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFFDFDFDF), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'Fatal Error',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppTheme.fontLightBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                         dashboardData['fatal_errors'].toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              '23%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF25EE18),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'last month',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFA3A3A3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Image.asset("assets/d3.png",
                                          width: 32, height: 32))
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          flex: 1),
                      SizedBox(width: 10),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F0F0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFFDFDFDF), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'Communication Score',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: AppTheme.fontLightBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          dashboardData['communication_score'].toStringAsFixed(2)+"%",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              '23%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFEE1818),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'last month',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFA3A3A3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Image.asset("assets/d4.png",
                                          width: 37, height: 37))
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          flex: 1)
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F0F0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFFDFDFDF), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'Process Score',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppTheme.fontLightBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          dashboardData['process_score'].toStringAsFixed(2)+"%",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              '23%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF25EE18),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'last month',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFA3A3A3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.only(top: 13),
                                      child: Image.asset("assets/d5.png",
                                          width: 32, height: 32))
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          flex: 1),
                      SizedBox(width: 10),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F0F0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFFDFDFDF), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'System Score',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppTheme.fontLightBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          dashboardData['system_score'].toStringAsFixed(2)+"%",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              '23%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFEE1818),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'last month',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFA3A3A3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Image.asset("assets/d6.png",
                                          width: 37, height: 37))
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          flex: 1)
                    ],
                  ),
                ),
                SizedBox(height: 17),
              ],
            ),
          ):Container(),
          SizedBox(height: 10),
          dashboardData.isNotEmpty?
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Quality Scores',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Communication',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF272D3B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [






                    Container(
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: dashboardData['communication_score'].toInt(),
                        size: 22,
                        padding: 0,
                        unselectedColor: Colors.grey.withOpacity(0.5),
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2896E9), Color(0xFF7467F0)],
                        ),
                      ),
                    ),

                    Container(
                      height: 22,
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: Row(
                        children: [


                          Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              dashboardData['communication_score'].toStringAsFixed(2)+'%',
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(width: 10)


                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Process',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF272D3B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: dashboardData['process_score'].toInt(),
                        size: 22,
                        padding: 0,
                        unselectedColor: Colors.grey.withOpacity(0.5),
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2896E9), Color(0xFF7467F0)],
                        ),
                      ),
                    ),

                    Container(
                      height: 22,
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: Row(
                        children: [


                          Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              dashboardData['process_score'].toStringAsFixed(2)+'%',
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(width: 10)


                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'System',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF272D3B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: dashboardData['system_score'].toInt(),
                        size: 22,
                        padding: 0,
                        unselectedColor: Colors.grey.withOpacity(0.5),
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2896E9), Color(0xFF7467F0)],
                        ),
                      ),
                    ),

                    Container(
                      height: 22,
                      margin: const EdgeInsets.only(left: 22, right: 25),
                      child: Row(
                        children: [


                          Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              dashboardData['system_score'].toStringAsFixed(2)+'%',
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(width: 10)


                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 13),
                  child: Divider(
                    thickness: 1.5,
                    color: Color(0xFF707070).withOpacity(0.40),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0%',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF748AA1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '25%',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF748AA1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '50%',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF748AA1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '75%',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF748AA1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '100%',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF748AA1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ):Container(),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Quality Scores',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),



                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFF3F3F3),
                    border: Border.all(color: Color(0xFFD9D9D9), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 0), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: ExpandedTile(
                    controller: _controller,
                     theme: const ExpandedTileThemeData(
                                            headerColor: Color(0xFFF3F3F3),
                                            headerRadius: 24.0,
                                            headerPadding: EdgeInsets.only(top: 10,bottom: 10),
                                            titlePadding: EdgeInsets.zero,
                                            //headerSplashColor: Colors.red,
                                            //
                                           // contentBackgroundColor: Colors.blue,
                                            contentPadding: EdgeInsets.all(5.0),
                                            contentRadius: 2.0,
                                          ),
                    title:  Container(
                      color: Color(0xFFF3F3F3),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Process Fatal Errors',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.fontLightBlueColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

/*
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 5),
                            child: Icon(Icons.keyboard_arrow_down,size: 31),
                          )*/



                        ],
                      ),
                    ),

                    content:

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [


                            ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context,int pos)

                                {
                                  return Column(
                                    children: [

                                      Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.symmetric(horizontal: 13),
                                          decoration: BoxDecoration(
                                            //  borderRadius: BorderRadius.circular(2),
                                            color: Color(0xFFF1F0F0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                'Description',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),


                                              SizedBox(height: 7),

                                              Text(
                                                'Wrong information related to process',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF565656).withOpacity(0.97),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 10),



                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Text(
                                                        'Error',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                      SizedBox(height: 7),

                                                      Text(
                                                        'EPFWIP1',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(0xFF565656).withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                    ],
                                                  ),

                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Text(
                                                        'Count',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                      SizedBox(height: 7),

                                                      Text(
                                                        '4',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(0xFF565656).withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                    ],
                                                  ),


                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Text(
                                                        '%Age',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                      SizedBox(height: 7),

                                                      Text(
                                                        '27%',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(0xFF565656).withOpacity(0.97),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),


                                                    ],
                                                  )


                                                ],
                                              ),


                                              SizedBox(height: 5),

                                            ],
                                          )
                                      ),

                                      SizedBox(height: 10),


                                    ],
                                  );
                                }



                            ),



                            SizedBox(height: 13),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0XFFBACCFF).withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 0), // Offset of the shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF565656).withOpacity(0.97),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      '20',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF565656).withOpacity(0.97),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),

                            SizedBox(height: 15),
                          ],



                        ),

                    onTap: () {

                    },
                    onLongTap: () {
                      debugPrint("looooooooooong tapped!!");
                    },

                  ),
                ),



                SizedBox(height: 20),





              ],
            ),
          ),


          SizedBox(height: 10),


          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Markdown Summary',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),



                Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFF3F3F3),
                    border: Border.all(color: Color(0xFFD9D9D9), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 0), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: ExpandedTile(
                    controller: _controller2,
                    theme: const ExpandedTileThemeData(
                      headerColor: Color(0xFFF3F3F3),
                      headerRadius: 24.0,
                      headerPadding: EdgeInsets.only(top: 10,bottom: 10),
                      titlePadding: EdgeInsets.zero,
                      //headerSplashColor: Colors.red,
                      //
                      // contentBackgroundColor: Colors.blue,
                      contentPadding: EdgeInsets.all(5.0),
                      contentRadius: 2.0,
                    ),
                    title:  Container(
                      color: Color(0xFFF3F3F3),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Communication Markdown',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.fontLightBlueColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

/*
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 5),
                            child: Icon(Icons.keyboard_arrow_down,size: 31),
                          )*/



                        ],
                      ),
                    ),

                    content:

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context,int pos)

                            {
                              return Column(
                                children: [

                                  Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.symmetric(horizontal: 13),
                                      decoration: BoxDecoration(
                                        //  borderRadius: BorderRadius.circular(2),
                                        color: Color(0xFFF1F0F0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            'Apology missing on call',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    'Error',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                  SizedBox(height: 7),

                                                  Text(
                                                    'EPFWIP1',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF565656).withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    'Count',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                  SizedBox(height: 7),

                                                  Text(
                                                    '4',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF565656).withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                ],
                                              ),


                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    '%Age',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                  SizedBox(height: 7),

                                                  Text(
                                                    '27%',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF565656).withOpacity(0.97),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),


                                                ],
                                              )


                                            ],
                                          ),


                                          SizedBox(height: 5),

                                        ],
                                      )
                                  ),

                                  SizedBox(height: 10),


                                ],
                              );
                            }



                        ),



                        SizedBox(height: 13),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0XFFBACCFF).withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 0), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF565656).withOpacity(0.97),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  '20',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF565656).withOpacity(0.97),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                      ],



                    ),

                    onTap: () {

                    },
                    onLongTap: () {
                      debugPrint("looooooooooong tapped!!");
                    },

                  ),
                ),



                SizedBox(height: 20),





              ],
            ),
          ),


          SizedBox(height: 10),



          dashboardData.isNotEmpty?


          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Rebuttal score',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20),




                ListView.builder(
                    itemCount: rebuttalAudits.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int pos)
                    {
                      return Column(
                        children: [



                          Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                //  borderRadius: BorderRadius.circular(2),
                                color: Color(0xFFF1F0F0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Auditor ID',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),


                                  SizedBox(height: 7),

                                  Text(
                                   rebuttalAudits[pos]['auditor_name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF565656).withOpacity(0.97),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 13),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'Total Audits',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            rebuttalAudits[pos]['audit_count'].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'Rebuttals Raised',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            rebuttalAudits[pos]['rebuttal_count'].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      ),


                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'Valid Rebuttals',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            rebuttalAudits[pos]['rebuttal_valid'].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      )


                                    ],
                                  ),

                                  SizedBox(height: 13),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'Auditor Error',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            rebuttalAudits[pos]['rebuttal_auditor_error'].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'No Error',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            rebuttalAudits[pos]['audit_no_error_count'].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      ),


                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            'BOD Given',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                          SizedBox(height: 7),

                                          Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF565656).withOpacity(0.97),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),


                                        ],
                                      )


                                    ],
                                  ),


                                  SizedBox(height: 10),


                                  Text(
                                    'Rebuttal Accepted%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.fontLightBlueColor.withOpacity(0.97),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),


                                  SizedBox(height: 7),

                                  Text(
                                    rebuttalAudits[pos]['accept_per'].toString()+"%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF565656).withOpacity(0.97),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),



                                  SizedBox(height: 15),



                                  Container(
                                      height: 50,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color(0XFFBACCFF).withOpacity(0.8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: const Offset(0, 0), // Offset of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Overall Audits Rebuttal Accepted : '+ rebuttalAudits[pos]['accept_per'].toString()+"%",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF565656).withOpacity(0.97),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),






                                  SizedBox(height: 5),

                                ],
                              )
                          ),

                          SizedBox(height: 12)


                        ],
                      );
                    }




                ),




                SizedBox(height: 20),





              ],
            ),
          ):Container(),









        ],
      ),
    );
  }

  _logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ExpandedTileController();
    _controller2 = ExpandedTileController();
    startDate=DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate=DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 27)));
    dateRange="2023-06-01-2023-10-30";
    fetchDashboardData();
  }
  fetchDashboardData() async {
    setState(() {
      isLoading=true;
    });

    var requestModel = {
      "start_date":"2023-06-01",
      "end_date":"2023-10-30"
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('agent_dashboard2', requestModel, context);
    var responseJSON = json.decode(response.body);
    isLoading=false;
    print(responseJSON);
    dashboardData = responseJSON["data"];
    rebuttalAudits = responseJSON["data"]['rebuttal_summary'];
    setState(() {});

  }

}
