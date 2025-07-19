import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qaviews/view/observation_details_screen.dart';
import 'package:qaviews/view/raise_rebuttal_screen.dart';
import 'package:toast/toast.dart';

import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';

class RaisereButtal1 extends StatefulWidget {
  final List<dynamic> paramList;
  final Map<String,dynamic> auditData;

  RaisereButtal1(this.paramList,this.auditData);

  ObserveState createState() => ObserveState();
}

class ObserveState extends State<RaisereButtal1> {
  List<dynamic> subParamsList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppTheme.blueColor,
        title: const Text(
          'Raise Rebuttal',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: widget.paramList.length,
                  itemBuilder: (BuildContext context, int pos) {

                    int rebuttalRaised=0;

                    for(int i=0;i<AppModel.rebuttalData.length;i++)
                      {
                        if(widget.paramList[pos]["qmSheeetParameater_id"].toString()==AppModel.rebuttalData[i]["parameter_id"].toString())
                          {
                            rebuttalRaised++;
                          }
                      }

                    bool isCritical = false;
                    bool isFail = false;
                    bool isPassed = false;

                    if (widget.paramList[pos]["fail_count"] >
                            widget.paramList[pos]["pass_count"] &&
                        widget.paramList[pos]["fail_count"] >
                            widget.paramList[pos]["critical_count"]) {
                      isFail = true;
                    } else if (widget.paramList[pos]["critical_count"] >
                            widget.paramList[pos]["pass_count"] &&
                        widget.paramList[pos]["critical_count"] >
                            widget.paramList[pos]["fail_count"]) {
                      isCritical = true;
                    } else {
                      isPassed = true;
                    }

                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            if(subParamsList.length!=0)
                              {
                                subParamsList.clear();
                              }


                           int currentParamID=widget.paramList[pos]["qmSheeetParameater_id"];
                            print("The ID is "+currentParamID.toString());

                            for(int i=0;i<widget.auditData["audit_data"]["audit_results"].length;i++)
                            {
                              if(currentParamID==widget.auditData["audit_data"]["audit_results"][i]["parameter_id"])
                              {
                                subParamsList.add(widget.auditData["audit_data"]["audit_results"][i]);
                              }
                            }

                            print("Length of sub Params is "+subParamsList.toString());



                     final data=await  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RaiseRubattal(subParamsList,pos,widget.paramList)));
                     if(data!=null)
                       {
                         setState(() {

                         });
                       }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isCritical
                                    ? Color(0xFfFF8989)
                                    : isFail
                                        ? Color(0xFFFFAA74)
                                        : Color(0xFF72E279)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -10.0, 0.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 28,
                                          width: 80,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: isCritical
                                                  ? Color(0xFFFF2929)
                                                  : isFail
                                                      ? Color(0xFFF47321)
                                                      : Color(0xFF1CAA25)),
                                          child: Row(
                                            children: [
                                              isPassed
                                                  ? Icon(
                                                      Icons
                                                          .thumb_up_off_alt_sharp,
                                                      color: Colors.white,
                                                      size: 12)
                                                  : Icon(
                                                      Icons
                                                          .thumb_down_alt_sharp,
                                                      color: Colors.white,
                                                      size: 12),
                                              SizedBox(width: 5),
                                              Text(
                                                isFail
                                                    ? 'Fail'
                                                    : isCritical
                                                        ? 'Critical'
                                                        : 'Passed',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),

                                      Spacer(),



                                     AppModel.rebuttalData.toString().contains(widget.paramList[pos]["qmSheeetParameater_id"].toString())?



                                      Container(
                                          transform: Matrix4.translationValues(
                                              -5.0, 15.0, 0.0),
                                          child: Icon(Icons.check_circle,color: Colors.white)):Container()

                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Parameter',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            widget.paramList[pos]
                                                ["parameater_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.fontBlueColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 5, top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  isCritical
                                                      ? 'Critical'
                                                      : isFail
                                                          ? 'Fail'
                                                          : 'Passed',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: isCritical
                                                          ? Color(0xFFFF2929)
                                                          : isFail
                                                              ? Color(
                                                                  0xFFF47321)
                                                              : Color(
                                                                  0xFF1CAA25)),
                                                ),
                                                Text(
                                                  isCritical
                                                      ? widget.paramList[pos]
                                                              ["critical_count"]
                                                          .toString()
                                                      : isFail
                                                          ? widget
                                                              .paramList[pos]
                                                                  ["fail_count"]
                                                              .toString()
                                                          : widget
                                                              .paramList[pos]
                                                                  ["pass_count"]
                                                              .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: isCritical
                                                          ? Color(0xFFFF2929)
                                                          : isFail
                                                              ? Color(
                                                                  0xFFF47321)
                                                              : Color(
                                                                  0xFF1CAA25)),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Spacer(),

                                          SizedBox(
                                            width: 65,
                                            height: 65,
                                            child: isCritical
                                                ? Lottie.asset(
                                                    'assets/angry_animation.json')
                                                : isFail
                                                    ? Lottie.asset(
                                                        'assets/sad_animation.json')
                                                    : Lottie.asset(
                                                        'assets/happy_animation.json'),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 1,
                                  color: Colors.white.withOpacity(0.5),
                                  width: double.infinity,
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Sub-Parameter',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: AppTheme.fontBlueColor),
                                          child: Center(
                                            child: Text(
                                              widget.paramList[pos]
                                                      ["total_sub_para_count"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    isCritical
                                        ? Container(
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 28,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Color(0xFF1CAA25)
                                                            .withOpacity(0.3)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .thumb_up_off_alt_sharp,
                                                            color: Color(
                                                                0xFF1CAA25),
                                                            size: 12),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Pass : ' +
                                                              widget.paramList[
                                                                      pos][
                                                                      "critical_count"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFF1CAA25)),
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(width: 5),
                                                Container(
                                                    height: 28,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Color(0xFFFF2929)
                                                            .withOpacity(0.3)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .thumb_down_alt_sharp,
                                                            color: Colors.red,
                                                            size: 12),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Fail : ' +
                                                              widget.paramList[
                                                                      pos][
                                                                      "fail_count"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ))
                                        : isFail
                                            ? Container(
                                                height: 40,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: 28,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: Color(
                                                                    0xFFFF2929)
                                                                .withOpacity(
                                                                    0.3)),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/angry.png",
                                                                width: 16,
                                                                height: 16),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Critical : ' +
                                                                  widget
                                                                      .paramList[
                                                                          pos][
                                                                          "critical_count"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        )),
                                                    SizedBox(width: 5),
                                                    Container(
                                                        height: 28,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: Color(
                                                                    0xFF1CAA25)
                                                                .withOpacity(
                                                                    0.3)),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .thumb_up_off_alt_sharp,
                                                                color: Color(
                                                                    0xFF1CAA25),
                                                                size: 12),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Pass : ' +
                                                                  widget
                                                                      .paramList[
                                                                          pos][
                                                                          "pass_count"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xFF1CAA25)),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ))
                                            : Container(
                                                height: 40,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: 28,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: Color(
                                                                    0xFFFF2929)
                                                                .withOpacity(
                                                                    0.3)),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/angry.png",
                                                                width: 16,
                                                                height: 16),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Critical : ' +
                                                                  widget
                                                                      .paramList[
                                                                          pos][
                                                                          "critical_count"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        )),
                                                    SizedBox(width: 5),
                                                    Container(
                                                        height: 28,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: Color(
                                                                    0xFFFF2929)
                                                                .withOpacity(
                                                                    0.3)),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .thumb_down_alt_sharp,
                                                                color:
                                                                    Colors.red,
                                                                size: 12),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Fail : ' +
                                                                  widget
                                                                      .paramList[
                                                                          pos][
                                                                          "fail_count"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ))
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(

                          children: [

                            Spacer(),

                            Text(
                              'Rebuttal Raised: '+rebuttalRaised.toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),

                            SizedBox(width: 10),

                          ],

                        ),


                        SizedBox(height: 15),


                      ],
                    );
                  })),

          SizedBox(height: 25),


          AppModel.rebuttalData.length!=0?

          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 40),
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

                raiseRebuttal();


              },
              child: const Text(
                'Raise Rebuttal Submit',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ):Container(),



          AppModel.rebuttalData.length!=0?


          SizedBox(height: 25):Container()


        ],
      ),
    );
  }


  raiseRebuttal() async {
    APIDialog.showAlertDialog(context, "Please wait...");
    var requestModel = {
      "raised_rebuttal":AppModel.rebuttalData,
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('Rebuttal', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);
    print(responseJSON);
    if(responseJSON["message"]=="Success")
    {
      AppModel.setRebuttalData([]);
      setState(() {});
      sendFeedbackDialog(context);

    }
    else
    {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }

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
                        'Rebuttal raised sucessfully',
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

}
