import 'dart:convert';

import 'package:flutter/material.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';

class NotifyScreen extends StatefulWidget{
  bool showBack;
  NotifyScreen(this.showBack);
  @override
  NotifyState createState() => NotifyState();
}
class NotifyState extends State<NotifyScreen> {
  bool isLoading = false;
  int selectedIndex=0;
  String strName = '';
  String strDescription = '';
  String date = '';
  List<dynamic> notificationList = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,

      child: SafeArea(
        child: Scaffold(
          appBar: widget.showBack
              ? AppBar(
            backgroundColor: AppTheme.blueColor,
            title:Text(
              'Notification',
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
          ListView.builder(
              itemCount: notificationList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (BuildContext context, int pos) {
                if (notificationList[pos]["data"]["name"] != null){
                  strName = notificationList[pos]["data"]["name"];
                }
                if (notificationList[pos]["data"]["description"] != null){
                  strDescription = notificationList[pos]["data"]["description"];
                }
                if (notificationList[pos]["created_at"] != null){
                  date = notificationList[pos]["created_at"];
                }
                Color backgroundColor =
                pos.isOdd ? Color(0xFfF7F7F7) : Colors.white;
                return Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 2.5,),
                          decoration: BoxDecoration(
                              color:
                              Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 60.0, // Set the desired width
                                    height: 60.0, // Set the desired height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      image: DecorationImage(
                                        image: AssetImage('assets/hrx.jpg'), // Replace with your image path
                                        fit: BoxFit.fill, // Adjust the fit as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Container(
                                    width: screenWidth -115,
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                strName,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                date,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 6.0),
                                        Text(
                                          strDescription,
                                          maxLines: 3,
                                          // softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),// Add some space between the image and text

                                ],
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),

                        ),
                      ),
                    ],
                  );
                  // ),

              }),
        ),
      ),
    );
  }
  void initState() {
    super.initState();
    getNotificationData();
  }
  getNotificationData() async {
    setState(() {
      isLoading=true;
    });
    var requestModel = {
    };
    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('agent_notification', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    notificationList = responseJSON["data"]["agent_details"]["unreadnotifications"];
    print(responseJSON);
    setState(() {});
  }
}