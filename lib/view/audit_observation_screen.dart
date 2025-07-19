import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qaviews/view/observation_details_screen.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../utils/app_theme.dart';

class ObservationScreen extends StatefulWidget {
  final List<dynamic> paramList;
  final Map<String,dynamic> auditData;

  ObservationScreen(this.paramList,this.auditData);

  ObserveState createState() => ObserveState();
}

class ObserveState extends State<ObservationScreen> {
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
          'Audit Observation Details',
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ObservationDetails(widget.auditData,widget.paramList,pos)));
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
                        SizedBox(height: 25)
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
