import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/view/expand_rebuttal.dart';
import 'package:qaviews/view/track_rebuttal.dart';
import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';

class RebuttalScreen extends StatefulWidget{
  bool showBack;
  RebuttalScreen(this.showBack);
  @override
  RebuttalState createState() => RebuttalState();
}
class RebuttalState extends State<RebuttalScreen> {
  bool isLoading = false;
  int selectedIndex=0;
  int selectIndex=-1;
  String callID = '';
  String clientName = '';
  String agentName = '';
  String auditDate = '';
  int status = -1;
  String strStatus = '';
  String parameter = '';
  String sub_parameter = '';
  String rebuttalDate = '';
  String rebuttalDate1 = '';
  String rebuttalID = '';
  String leftTime = '';
  int rebuttal_Id = 0;
  List<dynamic> rebuttalList = [];
  List<dynamic> rebuttalData = [];
  @override
  Widget build(BuildContext context) {
    double progressValue = 1;
    double _progressValue = 0.5;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,

      child: SafeArea(
        child: Scaffold(
          appBar: widget.showBack
              ? AppBar(
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
          backgroundColor: AppTheme.backgroundColor,
          extendBody: true,
          body:
          isLoading ?
          Center(
              child: Loader()
          ) :


          rebuttalList.length==0?


          Center(
            child:Text("No data found"),
          ):


          ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: rebuttalList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (BuildContext context, int pos) {
                callID = rebuttalList[pos]["call_id"];
                agentName = rebuttalList[pos]["agent_name"];
                clientName = rebuttalList[pos]["customer_name"];
                auditDate = rebuttalList[pos]["audit_date"];
                parameter = rebuttalList[pos]["parameter"] ?? "NA";
                sub_parameter = rebuttalList[pos]["sub_parameter"]  ?? "NA";
                rebuttalDate1 = rebuttalList[pos]["porter_tl_reply_rebuttal_time_tat"] ?? '2000-09-16 09:57:38';
                status = rebuttalList[pos]["status"];
                if (status == 1){
                  strStatus = 'Accepted';
                }else if (status == 2){
                  strStatus = 'Rejected';
                }else{
                  strStatus = 'In-progress';
                }
                DateTime targetDate = DateTime.parse(rebuttalDate1);
                DateTime currentDate = DateTime.now();
                Duration difference = targetDate.difference(currentDate);

                // Calculate the difference in hours
                String differenceInHours = difference.inHours.toString();
                targetDate.isBefore(currentDate) ? leftTime = '0' : leftTime = differenceInHours;

                Color backgroundColor =
                pos.isOdd ? Color(0xFfF7F7F7) : Colors.white;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 0, top: 0, bottom: 0,right: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 16, right: 16, top: 12, bottom: 5,),
                          decoration: BoxDecoration(
                              color:
                              Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
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
                                        '$leftTime Hr Left',
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
                                                    'Parameter',
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
                                                    'SubParameter',
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
                                                    parameter,
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
                                                    sub_parameter,
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
                                      margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5,),
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
                                                    'Status',
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
                                          SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                  child: Text(
                                                    strStatus,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: status == 1 ? AppTheme.darkGreen : status == 2 ? Colors.red:Colors.orange,
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
                                  Expanded(child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExpandRebuttalScreen(true, rebuttalList[pos]["id"],rebuttalList[pos]["porter_tl_reply_rebuttal_time_tat"] ?? '2000-09-16 09:57:38')));
                                    },
                                    child: Container(
                                        margin:
                                        const EdgeInsets.only(left: 16,right: 8,top: 8,bottom: 15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppTheme.blueColor,
                                            borderRadius: BorderRadius.circular(5)),
                                        height: 45,
                                        child: const Center(
                                          child: Text('Expand',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        )),
                                  ),),
                                  Expanded(child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackRebuttalScreen(true,rebuttalList[pos]["call_id"],rebuttalList[pos]["customer_name"],rebuttalList[pos]["audit_date"],
                                                      rebuttalList[pos]["agent_name"],rebuttalList[pos]["rebuttal_id"],
                                                      rebuttalList[pos]["porter_tl_reply_rebuttal_time_tat"] ?? '2000-09-16 09:57:38')));
                                    },
                                    child: Container(
                                        margin:
                                        const EdgeInsets.only(left: 8,right: 16,top: 8,bottom: 15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppTheme.darkGreen,
                                            borderRadius: BorderRadius.circular(5)),
                                        height: 45,
                                        child: const Center(
                                          child: Text('Track',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        )),
                                  ),)
                                ],
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                  // ),
                );
              }),
        ),
      ),
    );
  }
  void initState() {
    super.initState();
    gatRebuttalData();
  }
  gatRebuttalData() async {
    setState(() {
      isLoading=true;
    });
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    // Get the current date
    DateTime currentDate = DateTime.now();

    DateTime oneMonthAgo = currentDate.subtract(Duration(days: 30));
    String currentFormattedDate = formatDate(currentDate);
    String oneMonthAgoFormattedDate = formatDate(oneMonthAgo);
    var requestModel = {
      "user_id": userId,
      // "start_date":oneMonthAgoFormattedDate,
      // "end_date":currentFormattedDate
    };
    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('rebuttal_list', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    rebuttalList = responseJSON["data"];
    print(responseJSON);
    setState(() {});
  }
  String formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}