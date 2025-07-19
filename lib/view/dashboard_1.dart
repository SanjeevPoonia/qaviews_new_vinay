
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/view/login_screen.dart';
import 'package:qaviews/view/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'calender_screen.dart';

class Dashboard1 extends StatefulWidget{
  bool showBack;
  Dashboard1(this.showBack);
  @override
  DashboardState createState() => DashboardState();
}
class DashboardState extends State<Dashboard1>  {
  bool isLoading = false;
  String selectParameter = '11';
  StateSetter? setStateGlobal;
  String startDate="";
  String endDate="";
  String dateRange="";
  int selectedIndex=0;
  String agentID = '';
  String name = '';
  String timeGreeting="";
  Map<String,dynamic> dashboardCountData={};
  String email = '';
   List<GDPData> _chartData=[];
  Map<String,dynamic> agentData = {};
  List<dynamic> lobList=[];
  List<String> lobListAsString=[];
  String profileImage="";
  int selectedLobIndex=9999;
  Map<String,dynamic> lobTableData={};
  List<dynamic> callTypeList=[];
  List<dynamic> parameterComplianceList=[];
  int selectedCallTypeIndex=0;
  @override

  Widget build(BuildContext context) {
    double progressValue = 1;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          extendBody: true,
          body:
          // isLoading ?
          // Center(
          //     child: Loader()
          // ) :
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
               Container(
                 color: Colors.white,
                 width: double.infinity,
                 padding: EdgeInsets.symmetric(vertical: 10),
                 child:  Column(
                   children: [
                     Row(
                       children: [
                         Expanded(
                           flex:1,
                           child: Container(
                             height: 130,
                             margin: EdgeInsets.only(left:10),
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: AppTheme.fontLightBlueColor.withOpacity(0.1)
                             ),

                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 SizedBox(height: 5),

                                 Text(
                                   "Total Audits",
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF818D83)),
                                 ),
                                 SizedBox(height: 10),

                                 Row(
                                   children: [
                                     Text(
                                       "10",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black),
                                     ),

                                     Spacer(),

                                     Container(
                                       width:30,
                                       height: 30,
                                       margin: EdgeInsets.only(right:5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: AppTheme.fontBlueColor
                                       ),
                                       child: Center(
                                         child: Image.asset(
                                           'assets/porter.png',
                                         ),
                                       ),
                                     )
                                   ],
                                 ),


                                 SizedBox(height: 20),
                               ],
                             ),
                           ),
                         ),

                         SizedBox(width: 10),

                         Expanded(
                           flex:1,
                           child: Container(
                             height: 130,
                             margin: EdgeInsets.only(right:10),
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: AppTheme.fontLightBlueColor.withOpacity(0.1)
                             ),



                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 SizedBox(height: 5),

                                 Text(
                                   "Quality Score",
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF818D83)),
                                 ),


                                 SizedBox(height: 5),


                                 Row(
                                   children: [


                                     Text(
                                       "45",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black),
                                     ),


                                     Spacer(),

                                     Container(
                                       width:30,
                                       height: 30,
                                       margin: EdgeInsets.only(right:5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: AppTheme.fontBlueColor
                                       ),
                                       child: Center(
                                         child: Image.asset(
                                           'assets/porter.png',
                                         ),
                                       ),
                                     )


                                   ],
                                 ),

                               ],
                             ),
                           ),
                         ),


                       ],
                     ),
                     SizedBox(height:15),
                     Row(
                       children: [
                         Expanded(
                           flex:1,
                           child: Container(
                             margin: EdgeInsets.only(left:10),
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: AppTheme.fontLightBlueColor.withOpacity(0.1)
                             ),



                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 SizedBox(height: 5),

                                 Text(
                                   "Rebuttal Accepted Count",
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF818D83)),
                                 ),


                                 SizedBox(height: 5),


                                 Row(
                                   children: [


                                     Text(
                                       dashboardCountData["rebuttal_count"]!=null?dashboardCountData["rebuttal_count"].toString():"",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black),
                                     ),


                                     Spacer(),


                                     Container(
                                       width:30,
                                       height: 30,
                                       margin: EdgeInsets.only(right:5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: AppTheme.fontBlueColor
                                       ),
                                       child: Center(
                                         child: Icon(
                                           Icons.add_chart_rounded,
                                           color: Colors.white,
                                           size: 14,

                                         ),
                                       ),
                                     )









                                   ],
                                 ),


                                 SizedBox(height: 20),



                                 Divider(
                                   color:Color(0xFFB8C6BB),
                                   thickness: 1.5,

                                 ),


                                 SizedBox(height: 2),

                                 Row(
                                   children: [

                                     Text(
                                       "Rebuttal Accepted",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.black),
                                     ),


                                     Spacer(),



                                     Text(
                                       dashboardCountData["rebuttal_accept"]!=null?dashboardCountData["rebuttal_accept"].toString():"",
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.blue),
                                     ),



                                   ],
                                 ),



                                 SizedBox(height: 5),


                                 Row(
                                   children: [

                                     Text(
                                       "Auto Accepted",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.black),
                                     ),


                                     Spacer(),



                                     Text(
                                       dashboardCountData["rebuttal_auto_accept"]!=null?dashboardCountData["rebuttal_auto_accept"].toString():"",
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.blue),
                                     ),



                                   ],
                                 ),



                                 SizedBox(height: 5),



                               ],
                             ),
                           ),
                         ),

                         SizedBox(width: 10),

                         Expanded(
                           flex:1,
                           child: Container(
                             margin: EdgeInsets.only(right:10),
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: AppTheme.fontLightBlueColor.withOpacity(0.1)
                             ),



                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 SizedBox(height: 5),

                                 Text(
                                   "Rebuttal Rejected Count",
                                   textAlign: TextAlign.left,
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF818D83)),
                                 ),


                                 SizedBox(height: 5),


                                 Row(
                                   children: [


                                     Text(
                                       dashboardCountData["rebuttal_reject"]!=null?dashboardCountData["rebuttal_reject"].toString():"",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black),
                                     ),


                                     Spacer(),


                                     Container(
                                       width:30,
                                       height: 30,
                                       margin: EdgeInsets.only(right:5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: AppTheme.fontBlueColor
                                       ),
                                       child: Center(
                                         child: Icon(
                                           Icons.add_chart_rounded,
                                           color: Colors.white,
                                           size: 14,

                                         ),
                                       ),
                                     )









                                   ],
                                 ),


                                 SizedBox(height: 20),



                                 Divider(
                                   color:Color(0xFFB8C6BB),
                                   thickness: 1.5,

                                 ),


                                 SizedBox(height: 2),

                                 Row(
                                   children: [

                                     Text(
                                       "Rebuttal Rejected",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.black),
                                     ),


                                     Spacer(),



                                     Text(
                                       dashboardCountData["rebuttal_reject"]!=null?dashboardCountData["rebuttal_reject"].toString():"",
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.blue),
                                     ),



                                   ],
                                 ),



                                 SizedBox(height: 5),


                                 Row(
                                   children: [

                                     Text(
                                       "Auto Rejected",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.black),
                                     ),


                                     Spacer(),



                                     Text(
                                       dashboardCountData["rebuttal_auto_reject"]!=null?dashboardCountData["rebuttal_auto_reject"].toString():"",
                                       style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.blue),
                                     ),



                                   ],
                                 ),



                                 SizedBox(height: 5),



                               ],
                             ),
                           ),
                         ),


                       ],
                     ),
                   ],
                 )
               ),



                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                         top: 5, bottom: 5,),
                        decoration: BoxDecoration(
                            color:
                            Colors.white,
                            ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5.0, right: 8.0,top: 6),
                                              child: const Text(
                                                'LOB Wise Score',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.0),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: const Color(0xFfFFFFFF),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 6),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  selectParamDialog(context);
                                                },
                                                child: Container(
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: const Color(0xFfFFFFFf),
                                                      border: Border.all(
                                                          width: 0.6, color: const Color(0XFFB9B9B9))),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 8),
                                                        child: Text(
                                                          selectedLobIndex==9999?"":

                                                            lobList[selectedLobIndex]["process"]["name"],
                                                            style: TextStyle(
                                                              fontSize: 13.5,
                                                              color: Colors.black,
                                                            )),
                                                      ),
                                                      Icon(Icons.keyboard_arrow_down_outlined,
                                                          color: Colors.black),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10),

                                      Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Text(
                                            'Voice Evaluation',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppTheme.blackColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),




                                      SizedBox(height: 15),
                                      Container(
                                        height: 40, 
                                        margin: EdgeInsets.symmetric(horizontal: 5), // Add margin
                                        padding: EdgeInsets.all(10.0), // Add padding for text spacing
                                        color: Color(0xFfE3E3E3).withOpacity(0.8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Left Text
                                            Text(
                                              'Head',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),

                                            // Right Text
                                            Text(
                                              'Value',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Color(0xFfF7F7F7)


                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.white,
                                                //margin: EdgeInsets.all(6.0), // Add margin
                                                padding: EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 13),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    // Left Text
                                                    Text(
                                                      'Audit Count',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0xFf565656).withOpacity(0.97),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Text(
                                                        lobTableData["audit_count"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xFf565656).withOpacity(0.97),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ),
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Color(0xFfF7F7F7),
                                                //margin: EdgeInsets.all(6.0), // Add margin
                                                padding: EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 13),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    // Left Text
                                                    Text(
                                                      'Main Score (With fatal)',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0xFf565656).withOpacity(0.97),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Text(
                                                        lobTableData["with_fatal_score"]!=null?
                                                        lobTableData["with_fatal_score"].toStringAsFixed(2)+"%":"NA",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xFf565656).withOpacity(0.97),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ),
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.white,
                                                //margin: EdgeInsets.all(6.0), // Add margin
                                                padding: EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 13),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    // Left Text
                                                    Text(
                                                      'Score Excl. Fatal Computation',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0xFf565656).withOpacity(0.97),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Text(
                                                        lobTableData["without_fatal_score"]!=null?
                                                        lobTableData["without_fatal_score"].toStringAsFixed(2)+"%":"NA",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xFf565656).withOpacity(0.97),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ),
                                      ),


                                      Container(
                                        height: 1,
                                        margin: EdgeInsets.symmetric(horizontal: 7),
                                        color: Colors.grey.withOpacity(0.1),
                                        width: double.infinity,
                                      ),




                                      SizedBox(height: 20.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10.0, right: 8.0,top: 6),
                                              child: const Text(
                                                'Call Type : As Per System',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),

                                      Container(
                                        height: 50,
                                        margin: EdgeInsets.only(left: 7),
                                        child: ListView.builder(
                                            itemCount: callTypeList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,int pos)
                                            {

                                              return Row(
                                                children: [

                                                  Container(
                                                    width: 125,
                                                    height: 45,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 8.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedCallTypeIndex=pos;
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: selectedCallTypeIndex==pos ? AppTheme.blueColor : AppTheme.lightgrayColor, // Set the desired background color
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(callTypeList[pos]["qrc"],
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: selectedCallTypeIndex==pos ? Colors.white : AppTheme.grayColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 10),


                                                ],
                                              );
                                            }



                                        ),
                                      ),



                                      SizedBox(height: 10.0),
                                      Container(
                                        height: 40,
                                        margin: EdgeInsets.all(6.0), // Add margin
                                        padding: EdgeInsets.all(10.0), // Add padding for text spacing
                                        color: Color(0xFfE3E3E3).withOpacity(0.8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Left Text
                                            Text(
                                              'Head',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),

                                            // Right Text
                                            Text(
                                              'Value',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                      callTypeList.length==0?Container():
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5,right: 5),
                                              color: Colors.white, // Add margin
                                              padding: EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 13),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  // Left Text
                                                  Text(
                                                    'Audit Count',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0xFf565656).withOpacity(0.97),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right:10),
                                                    child: Text(
                                                      callTypeList[selectedCallTypeIndex]["audit_count"].toString(),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                        color: const Color(0xFf565656).withOpacity(0.97),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),
                                      callTypeList.length==0?Container():
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5,right: 5),
                                              color: Color(0xFFF7F7F7),
                                              padding: EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 13),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  // Left Text
                                                  Text(
                                                    'FATAL Count',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0xFf565656).withOpacity(0.97),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right:10),
                                                    child: Text(
                                                      callTypeList[selectedCallTypeIndex]["with_fatal_score_per"]!=null?
                                                      callTypeList[selectedCallTypeIndex]["with_fatal_score_per"].toStringAsFixed(2)+"%":"NA",
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0xFf565656).withOpacity(0.97),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5, bottom: 5,),
                        decoration: BoxDecoration(
                            color:
                            Colors.white,
                           ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0,top: 6),
                                              child: const Text(
                                                'Process Score',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 7),
                                                child: CircularPercentIndicator(
                                                    radius: 67.0,
                                                    lineWidth: 20.0,
                                                    percent: lobTableData["with_fatal_score"]!=null?
                                                    lobTableData["with_fatal_score"]/100:0,
                                                    arcType:  ArcType.HALF,
                                                    center: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(height: 44),


                                                        Text(
                                                          lobTableData["with_fatal_score"]!=null?
                                                          lobTableData["with_fatal_score"].toStringAsFixed(2)+"%":"NA",
                                                          style: const TextStyle(
                                                            fontSize: 19.0,
                                                            color: Color(0xFF61758D),
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),

                                                        SizedBox(height: 16),
                                                        Text('With Fatal',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                color:AppTheme
                                                                    .fontLightBlueColor)),
                                                      ],
                                                    ),
                                                    progressColor: AppTheme.fontLightBlueColor,
                                                    arcBackgroundColor: Color(0xFFE7E7E7)
                                                ), // Set righ
                                              ),


                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 7),
                                                child: CircularPercentIndicator(
                                                    radius: 67.0,
                                                    lineWidth: 20.0,
                                                    percent: lobTableData["without_fatal_score"]!=null?
                                                    lobTableData["without_fatal_score"]/100:0,
                                                    arcType:  ArcType.HALF,
                                                    center: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(height: 44),


                                                        Text(
                                                          lobTableData["without_fatal_score"]!=null?
                                                          lobTableData["without_fatal_score"].toStringAsFixed(2)+"%":"NA",
                                                          style: const TextStyle(
                                                            fontSize: 19.0,
                                                            color: Color(0xFF61758D),
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),

                                                        SizedBox(height: 16),
                                                        Text('Without Fatal',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                color:AppTheme
                                                                    .fontLightBlueColor)),
                                                      ],
                                                    ),
                                                    progressColor: Color(0xFFFFE500),
                                                    arcBackgroundColor: Color(0xFFE7E7E7)
                                                ), // Set righ
                                              ),


                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5, bottom: 5,),
                        decoration: BoxDecoration(
                            color:
                            Colors.white,
                            ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0,top: 6),
                                              child: const Text(
                                                'Parameter Wise Compliance',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.0),
                                      Container(
                                        height: 40,
                                        margin: EdgeInsets.all(6.0), // Add margin
                                        padding: EdgeInsets.all(10.0), // Add padding for text spacing
                                        color: Color(0xFfE3E3E3).withOpacity(0.8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Left Text
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),

                                            // Right Text
                                            Text(
                                              'Compliance',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFf2962FF).withOpacity(0.97),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          itemCount: parameterComplianceList.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, int pos) {
                                            Color backgroundColor =
                                            pos.isOdd ? Color(0xFfF7F7F7) : Colors.white;
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, top: 2.5, bottom: 2.5,right: 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color: backgroundColor,
                                                      margin: EdgeInsets.only(right: 2), // Add margin
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          // Left Text
                                                          Expanded(
                                                            child: Text(
                                                              parameterComplianceList[pos]["name"],
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.normal,
                                                                color: Color(0xFf565656).withOpacity(0.97),
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(width: 7),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 5),
                                                            child: Text(
                                                                parameterComplianceList[pos]["score"]!=null?
                                                              parameterComplianceList[pos]["score"].toStringAsFixed(2)+"%":"NA",
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.normal,
                                                                color: Color(0xFf565656).withOpacity(0.97),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ),
                                                ],
                                              ),
                                              // ),
                                            );
                                          }),
                                      SizedBox(height: 15.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 0, right: 0, top: 5, bottom: 5,),
                        decoration: BoxDecoration(
                            color:
                            Colors.white,
                           ),
                        child: Column(
                          children: [
                            Column(
                              children: <Widget>[
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20.0, right: 8.0,top: 20),
                                            child: const Text(
                                              'Quality Scores',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppTheme.blackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),

                                    _chartData.length==0?

                                        Container(
                                          height: 150,
                                          child: Center(
                                            child:Text("No data found")
                                          ),
                                        ):


                                    Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                          series: <ChartSeries>[
                                            // Renders bar chart
                                            BarSeries<GDPData, String>(dataSource: _chartData,
                                                xValueMapper: (GDPData gdp, _) => gdp.continent,
                                                yValueMapper: (GDPData gdp, _) => gdp.gdp,
                                                dataLabelSettings: DataLabelSettings(isVisible: true),
                                                color: AppTheme.blueColor
                                            )

                                          ],
                                          
                                          
                                          
                                          
                                          primaryXAxis: CategoryAxis(),
                                          primaryYAxis: NumericAxis(
                                              edgeLabelPlacement: EdgeLabelPlacement.none,
                                              labelFormat: '{value}%',
                                              minimum: 0.0,
                                              maximum: 20.0,
                                              interval: 2.0
                                            //numberFormat:  NumberFormat.percentPattern()
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 0.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5, right: 5, top: 12, bottom: 5,),
                                            decoration: BoxDecoration(
                                                color:
                                                AppTheme.lightWhite,
                                                borderRadius: const BorderRadius.all(Radius.circular(10))),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 15.0),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(left: 10.0, right: 8.0),
                                                        child: const Text(
                                                          'The agent did not ask for Csat Rating',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: AppTheme.grayColor,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 12.0),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Divider(
                                                    color: AppTheme.lightgrayColor,
                                                    thickness: 0.8,
                                                    height: 16.0,
                                                  ),
                                                ),
                                                SizedBox(height: 6.0),
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 15.0), // Set left padding
                                                      child: Text('Reason Count',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.grey// Set the desired font size
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 15.0), // Set right padding
                                                      child: Text('Percentage',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.grey// Set the desired font size
                                                        ),
                                                      ),// Replace with actual image path
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                lobTableData.isEmpty?
                                                    Container():
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 25.0), // Set left padding
                                                      child: Text(lobTableData["pareto_data"]["reasons_count"].toString()+' Count',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: AppTheme.blueColor// Set the desired font size
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 25.0), // Set right padding
                                                      child: Text('40%',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: AppTheme.blueColor// Set the desired font size
                                                        ),
                                                      ),// Replace with actual image path
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void initState() {

    super.initState();
    //  getDashboardData();
    startDate=DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 15)));
    endDate=DateFormat('yyyy-MM-dd').format(DateTime.now());

    timeGreeting=greeting();
   // getLOBList();
    getDashboardCounts();
    getDashboardData();
  //  fetchProfileData();
  }


  getLOBList() async {
    setState(() {
      isLoading=true;
    });


    var requestModel = {
      /* "agent_id": userId,*/
    };

    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard/lob_list',requestModel, context);
   // isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    lobList=responseJSON["lob_details"];
    selectedLobIndex=0;
    setState(() {});
    getLOBData(lobList[0]["process_id"].toString());
  }

  getDashboardCounts() async {
    var requestModel = {
      "start_date":startDate,
      "end_date":endDate
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard_counts',requestModel, context);

    var responseJSON = json.decode(response.body);
    dashboardCountData=responseJSON["data"];

    _chartData = getChartData();


    print("The counts are");
    print(responseJSON);
    setState(() {});
  }
  getLOBData(String lobID) async {
  /*  setState(() {
      isLoading=true;
    });*/


    var requestModel = {
      "process_id":lobID,
      "start_date":startDate,
      "end_date":endDate
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard/lob',requestModel, context);

    var responseJSON = json.decode(response.body);
    lobTableData=responseJSON["final_data"];
    callTypeList=lobTableData["qrc"];
    parameterComplianceList=lobTableData["parameter_compliance"];
   // _chartData = getChartData();
    isLoading = false;
    print(responseJSON);
    setState(() {});
  }


  getDashboardData() async {
      setState(() {
      isLoading=true;
    });


    var requestModel = {
      "start_date":startDate,
      "end_date":endDate
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard_rebuttal_counts',requestModel, context);

    var responseJSON = json.decode(response.body);
   /* lobTableData=responseJSON["final_data"];
    callTypeList=lobTableData["qrc"];
    parameterComplianceList=lobTableData["parameter_compliance"];
    _chartData = getChartData();*/
    isLoading = false;
    print(responseJSON);
    setState(() {});
  }



  showLogOutDialog(BuildContext context) {
    Widget cancelButton = GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Text("Cancel"));
    Widget continueButton = GestureDetector(
        onTap: (){
          Navigator.pop(context);
          // _logOut();
        },

        child: Text("Logout",style: TextStyle(
            color: Colors.red
        ),));

    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to Log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void selectParamDialog(BuildContext context) {

    showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context,bottomSheetState)
        {
          setStateGlobal=bottomSheetState;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            //margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 0),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppTheme.lightgrayColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0), // Adjust the radius as needed
                      topRight: Radius.circular(16.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 16,left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('LOB Parameters Filter',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/close1.png', // Replace with your image path
                                width: 25, // Set the desired width
                                height: 25, // Set the desired height
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                    padding: EdgeInsets.only(top: 0,left: 16, right: 16,bottom: 0),
                    itemCount: lobList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int pos) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      return GestureDetector(
                        onTap: (){

                          bottomSheetState(() {
                            selectedLobIndex=pos;
                          });
                          Navigator.pop(context);

                          getLOBData(lobList[selectedLobIndex]["process"]["id"].toString());






                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          //color: selectIndexResStatus == pos ? _currentColor : Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0), // Set left padding
                                    child: Text(lobList[pos]["process"]["name"],
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                  ),


                                  selectedLobIndex==pos?

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.check_circle,color: AppTheme.fontBlueColor,size: 18),
                                  ):
                                  Container(),


                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 8,right: 8,top: 15),
                                    height: 1,
                                    width: screenWidth -50,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 30),
              ],
            ),
          );
        }
        );
      },
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

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [];
    String systemData=dashboardCountData["agentSystemScore"].toString().substring(0,dashboardCountData["agentSystemScore"].toString().length-1);
    String processData=dashboardCountData["agentProcessScore"].toString().substring(0,dashboardCountData["agentProcessScore"].toString().length-1);
    String commData=dashboardCountData["agentCommunicationScore"].toString().substring(0,dashboardCountData["agentCommunicationScore"].toString().length-1);

    chartData.add(GDPData("System", double.parse(systemData)));
    chartData.add(GDPData("Process", double.parse(processData)));
    chartData.add(GDPData("Communi\ncation", double.parse(commData)));




/*    for(int i=0;i<lobTableData["pareto_data"]["per"].length;i++)
    {
      chartData.add(GDPData("Reason "+(i+1).toString(), double.parse(lobTableData["pareto_data"]["per"][i].toString())));
    }*/
    return chartData;
  }


  fetchProfileData() async {
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id":userId,
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('user_profile', requestModel, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    name = responseJSON["data"]["name"];
    email = responseJSON["data"]["email"];
    profileImage = responseJSON["data"]["avatar"];
    agentID = responseJSON["data"]["id"].toString();
    setState(() {});
    callapiUrl();
  }

  void _bottomSheetFilter() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Filter',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/close_icc.png',
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            )),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),


                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Select Date Range",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 15),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),

                  child: GestureDetector(
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



                        setModalState(() {

                        });
                      }
                    },
                    child: Row(
                      children: [

                        Image.asset("assets/calender_icc.png",width: 12,height: 12),

                        SizedBox(width: 10),

                        Text(
                          dateRange,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black),
                        ),








                      ],
                    ),
                  ),

                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  ),












                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const SizedBox(width: 25),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: AppTheme.blueColor),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 43,
                              child: const Center(
                                child: Text('Clear',
                                    style: TextStyle(
                                        fontSize: 14, color: AppTheme.blueColor)),
                              )),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {

                            if(dateRange!="")
                              {
                                Navigator.pop(context);

                                getLOBData(lobList[selectedLobIndex]["process_id"].toString());
                                getDashboardCounts();

                              }




                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: AppTheme.blueColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 43,
                              child: const Center(
                                child: Text('Apply',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              )),
                        ),
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            );
          }),
    );
  }







  callapiUrl() async {
    setState(() {});
    var requestModel = {
      "link": profileImage
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    var responseJSON = json.decode(response.body);
    profileImage = responseJSON["public_link"];
    //print('CallUrl:- $callAudioUrl');
    setState(() {});
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning !';
    }
    if (hour < 17) {
      return 'Good Afternoon !';
    }
    return 'Good Evening!';
  }

}
class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}

