import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/view/track_rebuttal.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'package:flutter/cupertino.dart';

class ExpandRebuttalScreen extends StatefulWidget{
  bool showBack;
  int ID;
  String date = '';
  ExpandRebuttalScreen(this.showBack, this.ID, this.date);
  @override
  ExpandRebuttalState createState() => ExpandRebuttalState();
}
class ExpandRebuttalState extends State<ExpandRebuttalScreen> {
  bool isLoading = false;
  int selectedIndex=0;
  int selectIndex=-1;
  String callID = '';
  String clientName = '';
  String agentName = '';
  String auditDate = '';
  String parameter = '';
  String sub_parameter = '';
  String details = '';
  String custName = '';
  String custContactNum = '';
  int rebuttalID = 0;
  String rebuttalDate = '';
  String leftTime = '';
  Map<String,dynamic> singleRebuttalList = {};
 // List<dynamic> singleRebuttalList = [];
  List<dynamic> subParameter = [];
  List<dynamic> arrRemark = [];
  List<dynamic> arrRevertRemark = [];
  List<dynamic> arrRebuttalData = [];
  @override
  Widget build(BuildContext context) {
    DateTime targetDate = DateTime.parse(widget.date);
    DateTime currentDate = DateTime.now();
    Duration difference = targetDate.difference(currentDate);

    // Calculate the difference in hours
    String differenceInHours = difference.inHours.toString();
    targetDate.isBefore(currentDate) ? leftTime = '0' : leftTime = differenceInHours;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,

      child: SafeArea(
        child: Scaffold(
          appBar: widget.showBack
              ? AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppTheme.blueColor,

            title:Text(
                'Rebuttal',
                style: TextStyle(
                  fontSize: 14,
                    color: Colors.white
                )
            ),
            centerTitle: true,
          )
              : PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar()),
          backgroundColor: Colors.white,
          extendBody: true,
          body:
          isLoading ?
          Center(
              child: Loader()
          ) :

          singleRebuttalList.length==0?


          Center(
            child:Text("No data found"),
          ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
                child: Text(
                  'Plan of Action',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Container(
                height: 5,
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: 5),

              Expanded(child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4), // Color of the shadow
                            spreadRadius: 0, // Spread radius of the shadow
                            blurRadius: 5, // Blur radius of the shadow
                            offset: Offset(0, 0), // Offset of the shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth,
                            height: 40.0,
                            color: Colors.yellow,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Lottie.asset('assets/Clock.json',
                                    width: 30.0, // Adjust the image width as needed
                                    height: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    leftTime + ' Hr Left',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600// Adjust the font size as needed
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Call Id',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Client Name',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                callID,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                clientName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Audit Date',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Agent Name',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                auditDate,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                agentName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Cust Name:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Cust contact number:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                custName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Text(
                                                custContactNum,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),// Set padding on all sides
                                    child: Text(
                                      'Rebuttal list',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppTheme.fontBlueColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16.0),
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),

                          ListView.builder(
                              padding: const EdgeInsets.only(bottom: 0),
                              itemCount: arrRebuttalData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              itemBuilder:
                                  (BuildContext context, int pos) {

                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, top: 0, bottom: 0,right: 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 16),// Set padding on all sides
                                            child: Text(
                                              'Behavior',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.fontBlueColor,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 16),// Set padding on all sides
                                            child: Text(
                                              arrRebuttalData[pos]["parameter"]["parameter"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.blackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          SizedBox(width: 16.0),
                                          Expanded(child: Text(
                                            'Parameter',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppTheme.fontBlueColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          SizedBox(width: 16.0),
                                          Expanded(child: Text(
                                            arrRebuttalData[pos]["sub_parameter"]["sub_parameter"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.blackColor,
                                            ),
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),)
                                        ],
                                      ),

                                      SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 16),// Set padding on all sides
                                            child: Text(
                                              'Remark',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.fontBlueColor,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          SizedBox(width: 16.0),
                                          Expanded(child: Text(
                                            arrRebuttalData[pos]["remark"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.blackColor,
                                            ),
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 15.0),
                                      Container(
                                        margin: EdgeInsets.only(right: 16.0,left: 16),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                  // ),
                                );
                              }),
                        ],
                      ),

                    ),
                  ])),
              // SizedBox(height: 10),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: <BoxShadow>[
              //       BoxShadow(
              //         color: Colors.black38,
              //         blurRadius: 6,
              //         offset: Offset(0, -3),
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           SizedBox(width: 40),
              //           Expanded(child: Container(
              //             height: 53,
              //             child: ElevatedButton(
              //               style: ButtonStyle(
              //                   foregroundColor: MaterialStateProperty.all<Color>(
              //                       Colors.white), // background
              //                   backgroundColor: MaterialStateProperty.all<Color>(
              //                       AppTheme.fontLightBlueColor), // fore
              //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //                       RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(6.0),
              //                       ))),
              //               onPressed: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             TrackRebuttalScreen(true,callID,clientName,auditDate,agentName,rebuttalID,rebuttalDate)));
              //               },
              //               child: const Text(
              //                 'Track Feedback',
              //                 style: TextStyle(fontSize: 14),
              //               ),
              //             ),
              //           ),flex: 1),
              //           SizedBox(width: 40),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  void initState() {
    super.initState();
    gatSingleRebuttalData();
  }
  gatSingleRebuttalData() async {
    setState(() {
      isLoading=true;
    });
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      // "user_id": userId,
      "id":widget.ID
    };
    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('single_rebuttal_list', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    singleRebuttalList = responseJSON["data"];
    //subParameter = responseJSON["data"][0]["parameter"]["System"]["subparameters"];
    //arrRemark = responseJSON["data"][0]["parameter"]["System"]["remarks"];
    arrRebuttalData = responseJSON["data"]["rebuttalData"];
   // arrRevertRemark = responseJSON["data"][0]["parameter"]["System"]["revert_remark"] ?? "NA";
    callID = singleRebuttalList["call_id"];
    agentName = singleRebuttalList["agent_name"];
    custName = singleRebuttalList["customer_name"] ?? "NA";
    custContactNum = singleRebuttalList["phone_number"] ?? "NA";
    clientName = singleRebuttalList["client_name"];
    auditDate = singleRebuttalList["audit_date"];
    // parameter = singleRebuttalList[0]["parameter"];
    // sub_parameter = singleRebuttalList[0]["sub_parameter"];
    // details = singleRebuttalList[0]["partner_remark"];
    rebuttalID = singleRebuttalList["id"];
    rebuttalDate = singleRebuttalList["porter_tl_reply_rebuttal_time_tat"] ?? '2000-09-16 09:57:38';
    print(responseJSON);
    setState(() {});
  }
}