
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';

class TrackRebuttalScreen extends StatefulWidget{
  bool showBack;
  String callID = '';
  String clientName = '';
  String auditDate = '';
  String agentName = '';
  int rebuttalID;
  String rebuttalDate = '';
  TrackRebuttalScreen(this.showBack, this.callID,this.clientName,this.auditDate,this.agentName,this.rebuttalID,this.rebuttalDate);
  @override
  TrackRebuttalState createState() => TrackRebuttalState();
}

class TrackRebuttalState extends State<TrackRebuttalScreen> {
  bool isLoading = false;
  int selectedIndex = 0;
  String progressBar = '0';
  String strtime = '';
  String lefttime = '';
  String statusATL = '';
  String statusQTL = '';
  Map<String,dynamic> trackRebuttalList = {};
  List<dynamic> statusTagList = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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

            title: Text(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Expanded(child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Background color of the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            // Color of the shadow
                            spreadRadius: 0,
                            // Spread radius of the shadow
                            blurRadius: 5,
                            // Blur radius of the shadow
                            offset: Offset(0, 0), // Offset of the shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10, right: 5, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
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
                                  margin: EdgeInsets.only(
                                    left: 5, right: 10, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Client Name',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.right,
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
                                  margin: EdgeInsets.only(
                                    left: 10, right: 5, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                widget.callID,
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
                                  margin: EdgeInsets.only(
                                    left: 5, right: 10, top: 5, bottom: 5,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                widget.clientName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.right,
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
                                  margin: EdgeInsets.only(
                                    left: 10, right: 5, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
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
                                  margin: EdgeInsets.only(
                                    left: 5, right: 10, top: 10, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: const Text(
                                                'Agent Name',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppTheme.blueColor,
                                                ),
                                                textAlign: TextAlign.right,
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
                                  margin: EdgeInsets.only(
                                    left: 10, right: 5, top: 5, bottom: 0,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                widget.auditDate,
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
                                  margin: EdgeInsets.only(
                                    left: 5, right: 10, top: 5, bottom: 5,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                widget.agentName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.blackColor,
                                                ),
                                                textAlign: TextAlign.right,
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
                          Container(
                            width: screenWidth,
                            height: 40.0,
                            color: AppTheme.yellow,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Lottie.asset('assets/Clock.json',
                                    width: 30.0,
                                    // Adjust the image width as needed
                                    height: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "$lefttime Hr Left",
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
                                  margin: EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 5,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.0),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.diagonal3Values(1.0, -1.0, 1.0),
                                              child: Container(
                                                margin: EdgeInsets.only(left: 20),
                                                width: 20, // Set the width of the progress bar
                                                height: 500.0, // Set the height of the progress bar
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey), // Add border for the container
                                                  borderRadius: BorderRadius.circular(10.0), // Add border radius for rounded corners
                                                ),
                                                child:RotatedBox(
                                                  quarterTurns: 1,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0), // Clip the progress bar with the same border radius
                                                    child: LinearProgressIndicator(
                                                      backgroundColor: Colors.red, // Set the unfilled color
                                                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.greenColor), // Set the filled color
                                                      value:double.parse(progressBar)/100,

                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),),
                                          SizedBox(width: 15.0),
                                          Expanded(
                                            flex: 8,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: 10, right: 5, top: 5, bottom: 0,),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(10))),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  strtime,
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: AppTheme.greenColor,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                  softWrap: true,
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
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  trackRebuttalList["status"] >= 4 ? statusATL = "Rebuttal Closed" :"WIP",
                                                                  style: TextStyle(
                                                                    fontSize: 14,
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
                                                        SizedBox(height: 80.0),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  'Assigned to',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: AppTheme.grayColor,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                  softWrap: true,
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
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  'QTL',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
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
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  statusQTL,
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: AppTheme.yellow,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                  softWrap: true,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 95.0),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  'Assigned to',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: AppTheme.grayColor,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                  softWrap: true,
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
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  'Agent TL',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
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
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  trackRebuttalList["status"] > 3 ? statusATL = "Accepted by ATL" :statusATL,
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: AppTheme.yellow,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                  softWrap: true,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 100.0),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 8.0, right: 8.0),
                                                                child: Text(
                                                                  'Rebuttal Raised',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
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
                                                        SizedBox(height: 100.0),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),)
                                        ],
                                      ),
                                      SizedBox(height: 12.0),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),

                    ),
                  ])),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  void initState() {
    super.initState();
    trackRebuttalData();
  }
  trackRebuttalData() async {
    setState(() {
      isLoading=true;
    });
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id": userId,
      "rebuttal_id": widget.rebuttalID
    };
    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('trackRebuttal', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    trackRebuttalList = responseJSON["data"];
   // statusTagList = responseJSON["data"]["status_tag"];
    print(responseJSON);
    hourPercent();
    setState(() {});
  }
  hourPercent() async{
    // Parse the target date as a DateTime object
    DateTime targetDate = DateTime.parse(widget.rebuttalDate);
    DateTime currentDate = DateTime.now();

    if (targetDate.isBefore(currentDate)) {
      progressBar = "100";
      strtime = "0 Hrs";
      lefttime = "0";
    } else {
      Duration difference = targetDate.difference(currentDate);

      // Calculate the difference in hours
      String differenceInHours = difference.inHours.toString();
      strtime ="$differenceInHours Hrs";
      lefttime = differenceInHours;
      if (trackRebuttalList["status"] == 0){
        progressBar = "25";
      }else if (trackRebuttalList["status"] == 1  || trackRebuttalList["status"] == 2 || trackRebuttalList["status"] == 3){
        progressBar = "50";
        statusATL = trackRebuttalList["tag"];

      }else if(trackRebuttalList["status"] ==4 || trackRebuttalList["status"] ==5){
        progressBar = "100";
        statusQTL = trackRebuttalList["tag"];
      }else if(trackRebuttalList["status"] ==6){
        progressBar = "100";
        statusQTL = trackRebuttalList["tag"];
      }else{
        progressBar = "0";
      }
    }

  }
}