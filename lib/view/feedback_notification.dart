import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/network/api_dialog.dart';
import 'package:qaviews/utils/app_modal.dart';
import 'package:toast/toast.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'audit_action_screen.dart';

class NotificationScreen extends StatefulWidget{
  final bool showBack;
  NotificationScreen(this.showBack);
  @override
  NotificationState createState() => NotificationState();
}
class NotificationState extends State<NotificationScreen> {
  bool isLoading = false;
  String selectParameter = '11';
  int selectedIndex=0;
  int selectIndex=-1;
  String strLeftTime = '';
  String rebuttal_Tat = '';
  int auditID = 0;
  List<dynamic> notificationList=[];
  List<String> filterOption=[
    "1 Hr To 10 Hr",
    "11 Hr To 20 Hr",
    "21 Hr To 30 Hr",
    "31 Hr To 40 Hr",
    "41 Hr To 50 Hr",
    "51 Hr To 60 Hr",
  ];
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
            // actions: [
            //   IconButton(
            //       icon: SvgPicture.asset(
            //         'assets/filter.svg',
            //         width: 22,
            //         height: 22,
            //       ),
            //       onPressed: () {
            //         filterDialog(context);
            //       }
            //   ),
            // ],

            title:Text(
              'Feedback Notification',

              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
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


              notificationList.length==0?


                  Center(
                    child:Text("No data found"),
                  ):



          ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: notificationList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (BuildContext context, int pos) {
                rebuttal_Tat = notificationList[pos]["rebuttal_tat"] /*?? '2000-09-16 09:57:38'*/;
                auditID = notificationList[pos]["id"];
                DateTime targetDate = DateTime.parse(rebuttal_Tat);
                DateTime currentDate = DateTime.now();
                Duration difference = targetDate.difference(currentDate);

                // Calculate the difference in hours
                String differenceInHours = difference.inHours.toString();
                targetDate.isBefore(currentDate) ? strLeftTime = '0' : strLeftTime = differenceInHours;
                Color backgroundColor =
                pos.isOdd ? Color(0xFfF7F7F7) : Colors.white;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 0, top: 0, bottom: 0,right: 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditActionScreen(notificationList[pos]["id"].toString())));

                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 5),
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
                                            strLeftTime + ' Hr Left',
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
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: const Text(
                                                        'Feedback From',
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
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: Text(notificationList[pos]["auditor"]["name"],
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
                                          margin: EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 5,),
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
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: Text(notificationList[pos]["raw_data"]["call_id"],
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
                                          margin: EdgeInsets.only(left: 5, right: 10, top: 12, bottom: 5,),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: const Text(
                                                        'Process Name',
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
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: Text(notificationList[pos]["process"]["name"],
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
                                          margin: EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 5,),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: const Text(
                                                        'Score With Fatal',
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
                                              SizedBox(height: 12.0),
                                              Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[
                                                 Container(
                                                   width: screenWidth -50, // Set the width of the progress bar
                                                   height: 15.0, // Set the height of the progress bar
                                                   decoration: BoxDecoration(
                                                     border: Border.all(color: Colors.grey), // Add border for the container
                                                     borderRadius: BorderRadius.circular(10.0), // Add border radius for rounded corners
                                                   ),
                                                   child: ClipRRect(
                                                     borderRadius: BorderRadius.circular(10.0), // Clip the progress bar with the same border radius
                                                     child: LinearProgressIndicator(
                                                       backgroundColor: Colors.grey, // Set the unfilled color
                                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), // Set the filled color
                                                       value:double.parse(notificationList[pos]["with_fatal_score_per"].toString())/100,

                                                     ),
                                                   ),
                                                 ),
                                                ],
                                              ),
                                              SizedBox(height: 12.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Score: '+notificationList[pos]["with_fatal_score_per"].toString()+' %'),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AuditActionScreen(notificationList[pos]["id"].toString()),
                                              ));
                                          if (result != null){
                                            fetchNotificationList();
                                          }
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditActionScreen(notificationList[pos]["id"].toString())));
                                        },
                                        child: Container(
                                            margin:
                                            const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 15),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: AppTheme.darkGreen,
                                                borderRadius: BorderRadius.circular(5)),
                                            height: 45,
                                            child: const Center(
                                              child: Text('Details',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white)),
                                            )),
                                      ),),
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          acceptFeedback(notificationList[pos]["id"]);
                                        },
                                        child: Container(
                                            margin:
                                            const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 15),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: AppTheme.blueColor,
                                                borderRadius: BorderRadius.circular(5)),
                                            height: 45,
                                            child: const Center(
                                              child: Text('Feedback Accepted',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white)),
                                            )),
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  // ),
                );
              }),
        ),
      ),
    );
  }
  void sendFeedbackDialog(BuildContext context) {
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
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Lottie.asset('assets/done.json',
                          width: 130.0, // Adjust the image width as needed
                          height: 130.0,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Feedback Accepted Successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppTheme.blackColor
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    height: 50,
                    width: 120,
                    child:ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          fetchNotificationList();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: AppTheme.blueColor, // Set the background color of the button
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Done',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                ),
                SizedBox(height: 45),
              ],
            ),
          );
        }

        );
      },
    );
  }
  void filterDialog(BuildContext context) {
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
                        Text('Feedback Notification Filter',
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
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child:Text('Select Time',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ListView.builder(
                    itemCount: filterOption.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int pos) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0,top: 8.0,bottom: 10.0,),
                        child: Row(
                          children: [
                            selectIndex == pos
                                ? Image.asset('assets/radio.png',
                                width: 24, height: 24)
                                : InkWell(
                              child: Image.asset(
                                  'assets/radio_disable.png',
                                  width: 24,
                                  height: 24),
                              onTap: () {
                                bottomSheetState(() {
                                  selectIndex = pos;
                                  print(selectIndex);
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(filterOption[pos],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 40,
                        width: 120,
                        child:ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {

                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.white, // Set the background color of the button
                          ),

                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Clear',
                                    style: TextStyle(
                                      color: AppTheme.blueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                    ),
                    SizedBox(width: 30),
                    Container(
                        height: 40,
                        width: 120,
                        child:ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            fetchNotificationList();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: AppTheme.blueColor, // Set the background color of the button
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Apply',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          );
        }
        );
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotificationList();
  }

  fetchNotificationList() async {
     setState(() {
       isLoading=true;
     });
    var requestModel = {
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('notification_feedback', requestModel, context);
    var responseJSON = json.decode(response.body);
    isLoading=false;
    if(responseJSON["data"].toString()!="No Data Found")
      {
        notificationList=responseJSON["data"];
      }
    print(responseJSON);
     setState(() {});
  }


  acceptFeedback(int feedbackID) async {

    APIDialog.showAlertDialog(context, "Accepting...");
    var requestModel = {
      // "agent_feedback_status":1,
      // "feedback_log_id":feedbackID
      "audit_id": auditID,
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('feedback_accept', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);
    if(responseJSON["status"]== 1)
    {
      sendFeedbackDialog(context);
    }
    else
      {
        Toast.show(responseJSON['message'],
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
      }
    print(responseJSON);
    setState(() {});
  }

}