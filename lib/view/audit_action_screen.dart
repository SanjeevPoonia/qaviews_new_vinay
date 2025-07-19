import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qaviews/view/raise_rebuttal_screen.dart';
import 'package:qaviews/view/raise_rebuttal_screen1.dart';
import 'package:toast/toast.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import '../widgets/input_field_widget.dart';
import 'audit_observation_screen.dart';
import 'audit_plan_of_action.dart';
import 'feedback.dart';


class AuditActionScreen extends StatefulWidget {
  final String auditID;
  AuditActionScreen(this.auditID);
  ActionState createState() => ActionState();
}

class ActionState extends State<AuditActionScreen> {
  bool isLoading=false;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer1 = AudioPlayer();
  bool isPlaying = false;
  bool isPlaying1 = false;
  Duration duration = const Duration();
  Duration position = const Duration();
  Duration duration1 = const Duration();
  Duration position1 = const Duration();
  String audioUrl = '';
  String firstUrl = '';
  String callUrl = '';
  String callAudioUrl = '';
  String selectLang = '11';
  String selectLangCode = 'en';
  String strLanChangeFeed = '';
  String feedbackSharedStatus = '';
  int selectIndex = -1;
  Map<String,dynamic> auditDetails={};
  List<dynamic> paraData=[];
  List<Map<String, dynamic>> languages = [
    {'name': 'English'},
    {'name': 'Marathi'},
    {'name': 'Gujarati'},
    {'name': 'Tamil'},
    {'name': 'Telugu'},
    {'name': 'Malyalam'},

  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppTheme.blueColor,
        title: const Text(
          'Audits',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:

      isLoading?


          Center(
            child: Loader(),
          ):

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              child: Text(
                'Basic Details',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),

          SizedBox(height: 5),
          Expanded(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: [

                    TextFieldWidget(
                        labeltext: "Communication Instance ID(Call ID):",
                        initialText: auditDetails["audit_data"]["raw_data"]["call_id"]),
                    SizedBox(height: 10),


                    TextFieldWidget(
                        labeltext: "Client:", initialText: "PORTER"),
                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Partner", initialText: "Porter_Partner"),
                    SizedBox(height: 10),



                TextFieldWidget(
                    labeltext: "Agent Name",
                    initialText: auditDetails["audit_data"]["raw_data"]["agent_name"]),
                SizedBox(height: 15),
               /* Text(
                  "Select Feedback Language",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2226).withOpacity(0.5)),
                ),*/
               /* Container(
                  height: 45,
                  child: Row(
                    children: [
                      Text(
                        auditDetails["audit_data"]["raw_data"]["language"],
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF707070)),
                      ),
                     *//* Spacer(),
                      Icon(Icons.keyboard_arrow_down_outlined)*//*
                    ],
                  ),
                ),*/
                    /*Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.6),
                    ),*/
                    Row(
                      children: [
                        Expanded(child: Text(
                          "Feedback",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1D2226).withOpacity(0.5)),
                        ),),
                        Expanded(child: Text(
                          "Change Language",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1D2226).withOpacity(0.5)),
                        ),

                        )
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex : 2,
                          child: Container(
                          //height: 45,
                          child: Row(
                            children: [
                              Expanded(child: Text(
                                strLanChangeFeed,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF707070)),
                                maxLines: 4,
                              ),
                              )

                              /* Spacer(),
                      Icon(Icons.keyboard_arrow_down_outlined)*/
                            ],
                          ),
                        ),
                        ),
                        Expanded(
                            flex : 1,
                            child: Container(
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
                                        height: 40,
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
                                                  selectLang == '11'
                                                      ? 'English'
                                                      : selectLang,
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
                        )
                      ],
                    ),


                    SizedBox(height: 15),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.6),
                ),
                SizedBox(height: 10),
                Text(
                  "Listen Call",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2226).withOpacity(0.5)),
                ),
                SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Slider(
                          thumbColor: AppTheme.fontBlueColor,
                          value: position.inSeconds.toDouble(), onChanged: (value) async{
                          await audioPlayer.seek(Duration(seconds: value.toInt()));
                          setState(() {

                          });
                        },
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          inactiveColor: Colors.grey,
                          activeColor: AppTheme.fontBlueColor
                        )),


                       Text(formatDuration(position.inSeconds).toString(),style: TextStyle(
                         fontWeight: FontWeight.w500,
                         color: AppTheme.fontBlueColor
                       ),),

                        SizedBox(width: 10),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isPlaying1)
                              InkWell(
                                onTap: _playAudio1,
                                child: Image.asset("assets/play_ic.png")
                              ),
                            if (isPlaying1)
                              InkWell(
                                onTap: _pauseAudio1,
                                child: Image.asset("assets/pause_ic.png")
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Feedback to Agent:",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1D2226).withOpacity(0.5)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Slider(
                          thumbColor: AppTheme.fontBlueColor,
                          value: position1.inSeconds.toDouble(), onChanged: (value) async{
                          await audioPlayer1.seek(Duration(seconds: value.toInt()));
                          setState(() {

                          });
                        },
                          min: 0,
                          max: (position1.inSeconds).toDouble(),
                          inactiveColor: Colors.grey,
                          activeColor: AppTheme.fontBlueColor
                        )),
                        Text(formatDuration(position1.inSeconds).toString(),style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.fontBlueColor
                        )),
                        SizedBox(width: 10),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isPlaying)
                              InkWell(
                                onTap: _playAudio,
                                child: Image.asset("assets/play_ic.png")
                              ),
                            if (isPlaying)
                              InkWell(
                                onTap: _pauseAudio,
                                child: Image.asset("assets/pause_ic.png")
                              ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Text(
                  "Parameter Wise Compliance",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2226).withOpacity(0.5)),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  color: Color(0xFFE3E3E3).withOpacity(0.8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.fontLightBlueColor),
                          ),
                          flex: 2),
                      Expanded(
                          child: Text(
                            "Fatal Count",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.fontLightBlueColor),
                          ),
                          flex: 1),
                      Expanded(
                          child: Text(
                            "Fail Count",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.fontLightBlueColor),
                          ),
                          flex: 1),
                      Expanded(
                          child: Text(
                            "Non- Compliance",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.fontLightBlueColor),
                          ),
                          flex: 2)
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: paraData.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int pos) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                        color: pos % 2 == 0 ? Color(0xFFF7F7F7) : Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                  paraData[pos]["parameater_name"],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color(0xFf565656).withOpacity(0.97)),
                                ),
                                flex: 2),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    paraData[pos]["critical_count"].toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color(0xFf565656).withOpacity(0.97)),
                                  ),
                                ),
                                flex: 1),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    paraData[pos]["fail_count"].toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color(0xFf565656).withOpacity(0.97)),
                                  ),
                                ),
                                flex: 1),
                            Expanded(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 18),
                                      child: Text(
                                        paraData[pos]["score"].toString()+"%",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFf565656)
                                                .withOpacity(0.97)),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),
                                flex: 2)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 15),



                    TextFieldWidget(
                        labeltext: "Audit Date:", initialText:auditDetails["audit_data"]["audit_date"]),
                    SizedBox(height: 10),

                    TextFieldWidget(
                        labeltext: "QA Name:",
                        initialText: "-"),
                    SizedBox(height: 10),
                    TextFieldWidget(labeltext: "Call Type:", initialText: auditDetails["audit_data"]["raw_data"]["call_type"]),
                    SizedBox(height: 10),



                    TextFieldWidget(labeltext: "Call Disposition:", initialText: auditDetails["audit_data"]["raw_data"]["disposition"]),
                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Customer Name:", initialText: auditDetails["audit_data"]["raw_data"]["customer_name"]),
                    SizedBox(height: 10),

                    TextFieldWidget(
                        labeltext: "Customer contact number:", initialText: auditDetails["audit_data"]["raw_data"]["phone_number"]),
                    SizedBox(height: 10),



                    TextFieldWidget(labeltext: "QRC 2:", initialText: "Query"),
                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Language 1:", initialText: auditDetails["audit_data"]["raw_data"]["language"]),
                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Language for QA", initialText: auditDetails["audit_data"]["raw_data"]["language"]),
                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Is Call Fatal:", initialText: "NO"),
                    SizedBox(height: 10),



                    TextFieldWidget(
                        labeltext: "Overall Score:", initialText: auditDetails["audit_data"]["overall_score"].toString()),
                    SizedBox(height: 10),



                    TextFieldWidget(
                        labeltext: "Call timestamp:", initialText:auditDetails["audit_data"]["raw_data"]["call_time"]),
                    SizedBox(height: 10),


                    TextFieldWidget(
                        labeltext: "Call duration:", initialText: auditDetails["audit_data"]["raw_data"]["call_duration"]),
                    SizedBox(height: 10),


                    TextFieldWidget(
                        labeltext: "CRN No./Order ID", initialText: auditDetails["audit_data"]["order_id"]),
                    SizedBox(height: 10),



                    TextFieldWidget(labeltext: "Caller ID:", initialText: auditDetails["audit_data"]["raw_data"]["call_id"]),
                    SizedBox(height: 10),


                TextFieldWidget(labeltext: "Vehicle Type:", initialText: auditDetails["audit_data"]["raw_data"]["vehicle_type"]),

                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Refrence No.:", initialText: auditDetails["audit_data"]["refrence_number"].toString()),

                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Caller Type", initialText: auditDetails["audit_data"]["caller_type"]),

                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Order Stage", initialText: auditDetails["audit_data"]["order_stage"]),

                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Issues", initialText: auditDetails["audit_data"]["issues"]),

                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Sub Issues", initialText: auditDetails["audit_data"]["sub_issues"]),

                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Scanerio", initialText: auditDetails["audit_data"]["scanerio"]),

                    SizedBox(height: 10),


                    TextFieldWidget(labeltext: "Scanerio Codes", initialText: auditDetails["audit_data"]["scanerio_codes"]),

                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Error Reason Type", initialText: auditDetails["audit_data"]["error_reason_type"]),

                    SizedBox(height: 10),

                    TextFieldWidget(labeltext: "Error Reasons", initialText: auditDetails["audit_data"]["error_code_reasons"]),

                    SizedBox(height: 10),



                    TextFieldWidget(labeltext: "Error Code:", initialText: auditDetails["audit_data"]["new_error_code"]),





                    SizedBox(height: 30),
              ])),
          SizedBox(height: 10),
          feedbackSharedStatus == "1" ? Container():
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //         child: Container(
                //           height: 53,
                //           child: ElevatedButton(
                //             style: ButtonStyle(
                //                 foregroundColor:
                //                     MaterialStateProperty.all<Color>(
                //                         Colors.white), // background
                //                 backgroundColor:
                //                     MaterialStateProperty.all<Color>(
                //                         AppTheme.fontLightBlueColor), // fore
                //                 shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                     RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(6.0),
                //                 ))),
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                           ObservationScreen(paraData,auditDetails)));
                //             },
                //             child: const Text(
                //               'Audit Observation Details',
                //               style: TextStyle(fontSize: 11),
                //             ),
                //           ),
                //         ),
                //         flex: 1),
                //     auditDetails["audit_data"]["rebuttal_status"].toString()=="1"?
                //
                //     Container():
                //     SizedBox(width: 15),
                //     auditDetails["audit_data"]["rebuttal_status"].toString()=="1"?
                //
                //     Container():
                //
                //     Expanded(
                //         child: Container(
                //           height: 53,
                //           child: ElevatedButton(
                //             style: ButtonStyle(
                //                 foregroundColor:
                //                     MaterialStateProperty.all<Color>(
                //                         Colors.white), // background
                //                 backgroundColor:
                //                     MaterialStateProperty.all<Color>(
                //                         Color(0xFF1CAA25)), // fore
                //                 shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                     RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(6.0),
                //                 ))),
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                           FeedbackScreen(true,widget.auditID)));
                //             },
                //             child: const Text(
                //               'Action Feedback',
                //               style: TextStyle(fontSize: 11),
                //             ),
                //           ),
                //         ),
                //         flex: 1)
                //   ],
                // ),
                SizedBox(height: 10),
                Row(
                  children: [

                    auditDetails["audit_data"]["rebuttal_status"].toString()=="1"?

                    Container():

                    Expanded(
                        child: Container(
                          height: 53,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white), // background
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF1CAA25)), // fore
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ))),
                            onPressed: () {
                              acceptFeedback();
                             // Navigator.push(context,MaterialPageRoute(builder: (context)=>AuditPlan(widget.auditID,paraData,auditDetails)));

                            },
                            child: const Text(
                              'Feedback Accepted',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        flex: 1),
                    auditDetails["audit_data"]["rebuttal_status"].toString()=="1"?

                    Container():
                    SizedBox(width: 15),

                    auditDetails["audit_data"]["feedback_shared_status"].toString()=="1"?

                        Container():



                    Expanded(
                        child: Container(
                          height: 53,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white), // background
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFFF2929)), // fore
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ))),
                            onPressed: () {

                              AppModel.setRebuttalData([]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RaisereButtal1(paraData,auditDetails)));

                           //   Navigator.push(context, MaterialPageRoute(builder: (context)=>RaiseRubattal(auditDetails["audit_data"]["audit_results"])));


                            },
                            child: const Text(
                              'Raise Rebuttal',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        flex: 1)
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
  convertUrl() async {
    isLoading = true;
    setState(() {});
    var requestModel = {
      "link": firstUrl
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    audioUrl = responseJSON["public_link"];
    print('AudioUrl:- $audioUrl');
    setState(() {});
  }
  callapiUrl() async {
    isLoading = true;
    setState(() {});
    var requestModel = {
      "link": callUrl
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    callAudioUrl = responseJSON["public_link"];
    print('CallUrl:- $callAudioUrl');
    setState(() {});
  }
  gatAuditData() async {
    isLoading = true;
    setState(() {});
    var requestModel = {
      "audit_id":widget.auditID,
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('single_audit_details', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    auditDetails = responseJSON["data"];
    firstUrl = auditDetails["audit_data"]["feedback_to_agent_recording"] ?? '';
    callUrl = auditDetails["audit_data"]["good_bad_call_file"] ?? '';
    feedbackSharedStatus = auditDetails["audit_data"]["feedback_shared_status"] ?? '';
    if (firstUrl != ''){
       await convertUrl();
    }
    if (callUrl != ''){
      await callapiUrl();
    }
    paraData = responseJSON["data"]["qmsheet_para_data"];
    strLanChangeFeed = auditDetails["audit_data"]["feedback"];
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    gatAuditData();
    audioPlayer = AudioPlayer();
    audioPlayer1 = AudioPlayer();

    audioPlayer.onDurationChanged.listen((Duration d) {

      print("Duration is "+d.inSeconds.toString());

       setState(() => duration = d);

    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() => position = p);

    });
    audioPlayer1.onDurationChanged.listen((Duration d1) {

      print("Dura is "+d1.inSeconds.toString());
      setState(() => duration1 = d1);

    });
    audioPlayer1.onPositionChanged.listen((Duration p1) {
      print("Position is "+p1.inSeconds.toString());
      setState(() => position1 = p1);

    });
  }
  Future<void> _playAudio() async {
    if (!isPlaying) {
      await audioPlayer1.play(UrlSource(audioUrl));
      setState(() {
        isPlaying = true;
      });
    }
  }

  Future<void> _pauseAudio() async {
    if (isPlaying) {
      await audioPlayer1.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }
  Future<void> _playAudio1() async {
    if (!isPlaying1) {
      await audioPlayer.play(UrlSource(callAudioUrl));
      setState(() {
        isPlaying1 = true;
      });
    }
  }

  Future<void> _pauseAudio1() async {
    if (isPlaying1) {
      await audioPlayer.pause();
      setState(() {
        isPlaying1 = false;
      });
    }
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    audioPlayer1.dispose();
    super.dispose();
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
                        Text('Select Language',
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
                    itemCount: languages.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int pos) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectLang = languages[pos]['name'];
                            selectIndex = pos;
                            if (selectLang == "English"){
                              selectLangCode = "en";
                            }else if (selectLang == "Marathi"){
                              selectLangCode = "mr";
                            }else if (selectLang == "Gujarati"){
                              selectLangCode = "gu";
                            }else if (selectLang == "Tamil"){
                              selectLangCode = "ta";
                            }else if (selectLang == "Telugu"){
                              selectLangCode = "te";
                            }else if (selectLang == "Malyalam"){
                              selectLangCode = "ml";
                            }else{
                              selectLangCode = "en";
                            }
                            changeLang();
                            print('LangCode:- $selectLangCode');
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          //color: selectIndexResStatus == pos ? _currentColor : Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 4.0), // Add vertical spacing
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0), // Set left padding
                                    child: Text(languages[pos]['name'].toString(),
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: AppTheme.blackColor,
                                      ),

                                    ),

                                  ),
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
                              SizedBox(height: 12.0),
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
  changeLang() async {
    setState(() {});
    var requestModel = {
        "data":{
          "question": auditDetails["audit_data"]["feedback"],
        }, "lang":[selectLangCode]
    };
    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.newPostAPI('translateForRavi', requestModel, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    strLanChangeFeed = responseJSON['data'];
    setState(() {});
  }
  String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }


  acceptFeedback() async {

    APIDialog.showAlertDialog(context, "Accepting...");
    var requestModel = {

      "audit_id": widget.auditID,
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('feedback_accept', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);

    if(responseJSON["status"]== 1)
    {
      Navigator.pop(context, "Hello");
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);

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


