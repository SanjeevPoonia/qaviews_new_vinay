import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:qaviews/view/plan_of_action1.dart';
import 'package:toast/toast.dart';
import 'package:record/record.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/constants.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';

class AuditPlan extends StatefulWidget {
  String auditID;
  final List<dynamic> subParamsList;
  Map<String, dynamic> auditData;

  AuditPlan(this.auditID, this.subParamsList, this.auditData);

  AuditState createState() => AuditState();
}

class AuditState extends State<AuditPlan> {
  int _recordDuration = 0;
  List<dynamic> paramList = [];
  String recordingPath = "";
  XFile? image;
  bool recordingCompleted = false;
  RecordState _recordState = RecordState.stop;
  Timer? _timer;
  int selectedTabIndex = 0;
  final record = Record();
  StreamSubscription<RecordState>? _recordSub;
  var textController = TextEditingController();
  List<TextEditingController>? _controllerTab = [];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppTheme.blueColor,
          title: const Text(
            'Plan of Action',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            Card(
              elevation: 3,
              child: Container(
                height: 44,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = 0;
                            });
                          },
                          child: Column(children: [
                            Text(
                              'Overall',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selectedTabIndex == 0
                                      ? Colors.black
                                      : Color(0xFFD1D1D1)),
                            ),
                            SizedBox(height: 7),
                            Container(
                              height: 5,
                              margin: EdgeInsets.only(left: 15),
                              color: selectedTabIndex == 0
                                  ? AppTheme.tabTheme
                                  : Color(0xFFD1D1D1),
                            )
                          ]),
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = 1;
                            });
                          },
                          child: Column(children: [
                            Text(
                              'Behaviour Wise',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selectedTabIndex == 1
                                      ? Colors.black
                                      : Color(0xFFD1D1D1)),
                            ),
                            SizedBox(height: 7),
                            Container(
                              height: 5,
                              margin: EdgeInsets.only(right: 15),
                              color: selectedTabIndex == 1
                                  ? AppTheme.tabTheme
                                  : Color(0xFFD1D1D1),
                            )
                          ]),
                        )),
                  ],
                ),
              ),
            ),
            selectedTabIndex == 0
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Text(
                            "Write plan of Action",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D2226).withOpacity(0.5)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                              controller: textController,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF707070),
                              ),
                              decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.zero,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 13, 5),
                                  //prefixIcon: fieldIC,
                                  hintText: "Write here",
                                  hintStyle: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF707070).withOpacity(0.4),
                                  ))),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "Record plan of Action",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D2226).withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: GestureDetector(
                              onTap: () async {
                                if (await record.isRecording()) {
                                  _timer?.cancel();
                                  _recordDuration = 0;

                                  final path = await record.stop();
                                  recordingPath = path.toString();

                                  if (path != null) {
                                    print("The Path is " + path);
                                  }
                                  recordingCompleted = true;
                                  setState(() {});
                                } else {
                                  if (await record.hasPermission()) {
                                    // Start recording
                                    await record.start(
                                      encoder: AudioEncoder
                                          .aacLc, // by default// by default
                                    );
                                    _recordDuration = 0;
                                    _startTimer();
                                  }
                                }
                              },
                              child: Image.asset("assets/record_voice.png",
                                  width: 60, height: 60)),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: recordingCompleted
                              ? Text("Recorded Successfully",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                      fontSize: 15))
                              : _buildText(),
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
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
                              if (textController.text == "") {
                                Toast.show("Plan of action cannot be empty!",
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom,
                                    backgroundColor: Colors.red);
                              } else {
                                planOFAction();
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: widget.subParamsList.length,
                        itemBuilder: (BuildContext context, int pos) {
                          bool isCritical = false;
                          bool isFail = false;
                          bool isPassed = false;

                          if (widget.subParamsList[pos]["fail_count"] >
                                  widget.subParamsList[pos]["pass_count"] &&
                              widget.subParamsList[pos]["fail_count"] >
                                  widget.subParamsList[pos]["critical_count"]) {
                            isFail = true;
                          } else if (widget.subParamsList[pos]
                                      ["critical_count"] >
                                  widget.subParamsList[pos]["pass_count"] &&
                              widget.subParamsList[pos]["critical_count"] >
                                  widget.subParamsList[pos]["fail_count"]) {
                            isCritical = true;
                          } else {
                            isPassed = true;
                          }

                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (paramList.length != 0) {
                                    paramList.clear();
                                  }

                                  int currentParamID = widget.subParamsList[pos]
                                      ["qmSheeetParameater_id"];
                                  print(
                                      "The ID is " + currentParamID.toString());

                                  for (int i = 0;
                                      i <
                                          widget
                                              .auditData["audit_data"]
                                                  ["audit_results"]
                                              .length;
                                      i++) {
                                    if (currentParamID ==
                                        widget.auditData["audit_data"]
                                                ["audit_results"][i]
                                            ["parameter_id"]) {
                                      paramList.add(
                                          widget.auditData["audit_data"]
                                              ["audit_results"][i]);
                                    }
                                  }

                                  print("Length of sub Params is " +
                                      paramList.toString());

                                  final data = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlanofAction1(
                                              paramList,
                                              pos,
                                              widget.subParamsList)));
                                  if (data != null) {
                                    setState(() {});
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        BorderRadius.circular(
                                                            6),
                                                    color: isCritical
                                                        ? Color(0xFFFF2929)
                                                        : isFail
                                                            ? Color(0xFFF47321)
                                                            : Color(
                                                                0xFF1CAA25)),
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
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 12),
                                                Text(
                                                  widget.subParamsList[pos]
                                                      ["parameater_name"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppTheme
                                                          .fontBlueColor),
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
                                                      left: 10,
                                                      right: 5,
                                                      top: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                ? Color(
                                                                    0xFFFF2929)
                                                                : isFail
                                                                    ? Color(
                                                                        0xFFF47321)
                                                                    : Color(
                                                                        0xFF1CAA25)),
                                                      ),
                                                      Text(
                                                        isCritical
                                                            ? widget
                                                                .subParamsList[
                                                                    pos][
                                                                    "critical_count"]
                                                                .toString()
                                                            : isFail
                                                                ? widget
                                                                    .subParamsList[
                                                                        pos][
                                                                        "fail_count"]
                                                                    .toString()
                                                                : widget
                                                                    .subParamsList[
                                                                        pos][
                                                                        "pass_count"]
                                                                    .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: isCritical
                                                                ? Color(
                                                                    0xFFFF2929)
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
                                                        BorderRadius.circular(
                                                            6),
                                                    color:
                                                        AppTheme.fontBlueColor),
                                                child: Center(
                                                  child: Text(
                                                    widget.subParamsList[pos][
                                                            "total_sub_para_count"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          height: 28,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
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
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                'Pass : ' +
                                                                    widget
                                                                        .subParamsList[
                                                                            pos]
                                                                            [
                                                                            "critical_count"]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
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
                                                                  color: Colors
                                                                      .red,
                                                                  size: 12),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                'Fail : ' +
                                                                    widget
                                                                        .subParamsList[
                                                                            pos]
                                                                            [
                                                                            "fail_count"]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
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
                                              : isFail
                                                  ? Container(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              height: 28,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
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
                                                                      height:
                                                                          16),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'Critical : ' +
                                                                        widget
                                                                            .subParamsList[pos]["critical_count"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
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
                                                                      horizontal:
                                                                          5),
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
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'Pass : ' +
                                                                        widget
                                                                            .subParamsList[pos]["pass_count"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              height: 28,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
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
                                                                      height:
                                                                          16),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'Critical : ' +
                                                                        widget
                                                                            .subParamsList[pos]["critical_count"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
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
                                                                      horizontal:
                                                                          5),
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
                                                                      color: Colors
                                                                          .red,
                                                                      size: 12),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'Fail : ' +
                                                                        widget
                                                                            .subParamsList[pos]["fail_count"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
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
                        })),
          ],
        ));
  }

  planOFAction() async {
    APIDialog.showAlertDialog(context, "Please wait...");
    FormData formData = FormData.fromMap({
      "agent_feedback_status": 1,
      "feedback_log_id": 249413,
      "feedback_remark": textController.text,
      "audit_id": widget.auditID,
      "agent_feedback_recording": recordingPath == ''
          ? null
          : await MultipartFile.fromFile(recordingPath),
    });
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Authorization'] = AppModel.token;
    print(AppConstant.appBaseURL + "plan_of_action");
    var response = await dio.post(AppConstant.appBaseURL + "plan_of_action",
        data: formData);
    print(response.data);
    Navigator.pop(context);
    if (response.data['message'] == "Success") {
      sendFeedbackDialog(context);
    } else {
      Toast.show(response.data['message'].toString(),
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
        return StatefulBuilder(builder: (context, bottomSheetState) {
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
                      topLeft: Radius.circular(16.0),
                      // Adjust the radius as needed
                      topRight:
                          Radius.circular(16.0), // Adjust the radius as needed
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
                                'assets/close1.png',
                                // Replace with your image path
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
                        Lottie.asset(
                          'assets/done.json',
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
                        'Submitted Successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppTheme.blackColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: AppTheme
                            .blueColor, // Set the background color of the button
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 45),
              ],
            ),
          );
        });
      },
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recordSub = record.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    record.dispose();
    super.dispose();
  }

  _fetchImage1(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image22 = await _picker.pickImage(source: ImageSource.gallery);
    print('Image File From Android' + (image22?.path).toString());
    if (image22 != null) {
      image = image22;
    }
  }
}
