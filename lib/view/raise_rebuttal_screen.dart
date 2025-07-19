
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/constants.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class RaiseRubattal extends StatefulWidget
{
  final int cardIndex;
  final List<dynamic> subParamsList;
  final List<dynamic> paraList;
  RaiseRubattal(this.subParamsList,this.cardIndex,this.paraList);
  RaiseState createState()=>RaiseState();
}
class RaiseState extends State<RaiseRubattal>
{
  int selectedTabIndex=0;
  XFile? image;
  bool dataLoaded=false;
  List<dynamic> criticalList=[];
  List<dynamic> failList=[];
  List<dynamic> passedList=[];
  List<TextEditingController> _controllerTab3=[];
  List<TextEditingController> _controllerTab1=[];
  List<TextEditingController> _controllerTab2=[];
  List<String> dropdownValueTab1=[];
  List<String> dropdownValueTab2=[];
  List<String> dropdownValueTab3=[];
  List<String> imageLinksTab1=[];
  List<String> imageLinksTab2=[];
  List<String> imageLinksTab3=[];

  bool isCritical = false;
  bool isFail = false;
  bool isPassed = false;
  int modalIndex=0;
  List<String> statusList=["Correct","Incorrect"];

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
          'Raise Rebuttal',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Colors.grey.withOpacity(0.4),
                ),

                SizedBox(height: 17),


                Container(
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
                                height: 30,
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
                                  widget.paraList[widget.cardIndex]
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
                                            ? widget.paraList[widget.cardIndex]
                                        ["critical_count"]
                                            .toString()
                                            : isFail
                                            ? widget.paraList[widget.cardIndex]
                                        ["fail_count"]
                                            .toString()
                                            : widget.paraList[widget.cardIndex]
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
                                    widget.paraList[widget.cardIndex]
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
                                                widget.paraList[widget.cardIndex][
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
                                                widget.paraList[widget.cardIndex][
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
                                                widget.paraList[widget.cardIndex][
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
                                                widget.paraList[widget.cardIndex][
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
                                                widget.paraList[widget.cardIndex][
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
                                                widget.paraList[widget.cardIndex][
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

                SizedBox(height: 20),


                Card(
                  elevation: 4,
                  child: Container(
                    height: 45,
                    child: Row(
                      children: [

                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedTabIndex=0;
                                });
                              },
                              child: Column(children: [

                                Text(
                                  'Critical',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:

                                      selectedTabIndex==0?
                                      Colors.black:Color(0xFFD1D1D1)),
                                ),


                                SizedBox(height: 10),


                                Container(
                                  height: 5,
                                  margin: EdgeInsets.only(left: 15),
                                  color:
                                  selectedTabIndex==0?
                                  AppTheme.fontBlueColor:Color(0xFFD1D1D1),
                                )





                              ]),
                            )),


                        Expanded(

                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedTabIndex=1;
                                });
                              },
                              child: Column(children: [

                                Text(
                                  'Fail',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTabIndex==1?
                                      Colors.black:Color(0xFFD1D1D1)),
                                ),


                                SizedBox(height: 10),


                                Container(
                                  height: 5,
                                  color:  selectedTabIndex==1?
                                  AppTheme.fontBlueColor:Color(0xFFD1D1D1),
                                )





                              ]),
                            )),


                        Expanded(

                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedTabIndex=2;
                                });
                              },
                              child: Column(children: [

                                Text(
                                  'Pass',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTabIndex==2?
                                      Colors.black:Color(0xFFD1D1D1)),
                                ),


                                SizedBox(height: 10),


                                Container(
                                  height: 5,
                                  margin: EdgeInsets.only(right: 15),
                                  color: selectedTabIndex==2?
                                  AppTheme.fontBlueColor:Color(0xFFD1D1D1),
                                )





                              ]),
                            ))


                      ],
                    ),

                  ),
                ),

                SizedBox(height: 20),


             dataLoaded?


             Container(
               child:



               selectedTabIndex==0?

                   criticalList.length==0?

                       Center(
                         child: Text("No data found"),
                       ):


               ListView.builder(
                   itemCount: criticalList.length,
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (BuildContext context,int pos)

               {
                 return Column(
                   children: [

                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 15),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         boxShadow: <BoxShadow>[
                           BoxShadow(
                             color: Colors.black38.withOpacity(0.2),
                             blurRadius: 6,
                             offset: Offset(0, 0.5),
                           ),
                         ],
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           Row(
                             children: [

                               Text(
                                 'Sub-Parameter',
                                 style: TextStyle(
                                     fontSize: 11,
                                     color: Color(0xFF2962FF)),
                               ),


                               Spacer(),


                               Container(
                                 width: 35,
                                 height: 35,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(6),
                                     color: AppTheme.fontBlueColor
                                 ),
                                 child: Center(
                                   child:Text(
                                     (pos+1).toString(),
                                     style: TextStyle(
                                         fontSize: 15,
                                         fontWeight: FontWeight.w600,
                                         color: Colors.white),
                                   ),

                                 ),
                               )



                             ],
                           ),

                           SizedBox(height: 5),


                           Text(
                             criticalList[pos]["sub_parameter_detail"]["sub_parameter"],
                             style: TextStyle(
                                 fontSize: 11,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black),
                           ),

                           SizedBox(height: 10),


                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Text(
                                     'Score',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 5),
                                   Text(
                                    criticalList[pos]["score"].toString(),
                                     style: TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.black),
                                   ),

                                 ],
                               ),


                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Text(
                                     'Observation',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 5),
                                   Text(
                                     criticalList[pos]["selected_option"]==3?
                                     'Critical':criticalList[pos]["selected_option"]==2?
                                     'Fail':'Passed',
                                     style: TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.w500,
                                         color:

               criticalList[pos]["selected_option"]==3 || criticalList[pos]["selected_option"]==2?

                                         Color(0xFFDA2F47):Colors.green),
                                   ),

                                 ],
                               )





                             ],
                           ),

                           SizedBox(height: 15),




                           Text(
                             'Upload Realted Artifacts',
                             style: TextStyle(
                                 fontSize: 11,
                                 color: Color(0xFF2962FF)),
                           ),

                           SizedBox(height: 10),


                           GestureDetector(
                             onTap: (){
                               _fetchImage1(context,1,pos);
                             },
                             child: Row(
                               children: [

                                 Container(
                                   width: 35,
                                   height: 35,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Color(0xFF354C9E)
                                   ),
                                   child: Center(
                                     child: Icon(Icons.attachment_outlined,color: Colors.white,size: 18,),
                                   ),
                                 ),

                                 SizedBox(width: 7),


                                 Text(
                                   'Choose file',
                                   style: TextStyle(
                                       fontSize: 13,
                                       fontWeight: FontWeight.w500,
                                       color: Colors.black),
                                 ),


                                 Spacer(),



                                 imageLinksTab1[pos]=="no file"?Container():


                                 DottedBorder(
                                   borderType: BorderType.RRect,
                                   padding: EdgeInsets.zero,
                                   radius: Radius.circular(6),
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.all(Radius.circular(6)),
                                     child: Container(
                                       height: 43,
                                       width: 140,
                                       color: Color(0xFFF3F3F3),
                                       child: Row(
                                         children: [

                                           SizedBox(width: 10),

                                           Expanded(
                                             child: Text(
                                               imageLinksTab1[pos].toString().split('/').last,
                                               style: TextStyle(fontSize: 11, color: Color(0xFF707070)),

                                               maxLines: 1,
                                               overflow: TextOverflow.ellipsis,

                                             ),
                                           ),
                                           SizedBox(width: 5),
                                           GestureDetector(
                                             child: Icon(Icons.close),
                                             onTap: (){
                                               imageLinksTab1[pos]="no file";
                                               setState(() {

                                               });
                                             },


                                           ),
                                           SizedBox(width: 5)

                                         ],
                                       ),

                                     ),
                                   ),

                                 )




                               ],
                             ),
                           ),

                           SizedBox(height: 12),



                           Text(
                             'Auditee Observation',
                             style: TextStyle(
                                 fontSize: 11,
                                 color: Color(0xFF2962FF)),
                           ),

                           SizedBox(height: 3),


                           InkWell(
                             onTap: (){

                               List<String> statusItems=[];

                               if(criticalList[pos]["sub_parameter_detail"]["pass"]==1)
                               {
                                 statusItems.add("Pass");
                               }

                               if(criticalList[pos]["sub_parameter_detail"]["fail"]==1)
                               {
                                 statusItems.add("Fail");
                               }

                               if(criticalList[pos]["sub_parameter_detail"]["na"]==1)
                               {
                                 statusItems.add("NA");
                               }

                               if(criticalList[pos]["sub_parameter_detail"]["pwd"]==1)
                               {
                                 statusItems.add("PWD");
                               }

                               modalIndex=9999;
                               _modalBottomSheetMenu(1,pos,statusItems);
                             },
                             child: Container(
                               height: 45,
                               child: Row(
                                 children: [

                                   Text(
                                     dropdownValueTab1[pos],
                                     style: TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.w700,
                                         color: Color(0xFF707070)),
                                   ),

                                   Spacer(),

                                   Icon(Icons.keyboard_arrow_down_outlined)



                                 ],
                               ),
                             ),
                           ),

                           Container(
                             height: 1,
                             width: double.infinity,
                             color: Colors.grey.withOpacity(0.6),
                           ),




                           SizedBox(height: 12),


                           Text(
                             'Remarks',
                             style: TextStyle(
                                 fontSize: 11,
                                 color: Color(0xFF2962FF)),
                           ),


                           SizedBox(height: 5),


                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(6),
                                 border: Border.all(color: Color(0xFF707070),width: 0.5)
                             ),
                             child: TextFormField(
                                 maxLines: 4,
                                 style: const TextStyle(
                                   fontSize: 13.0,
                                   fontWeight: FontWeight.w700,
                                   color: Color(0xFF707070),
                                 ),
                                 decoration: InputDecoration(
                                     border: InputBorder.none,
                                     //contentPadding: EdgeInsets.zero,
                                     contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 13, 5),
                                     //prefixIcon: fieldIC,
                                     hintText: "Enter Remarks",
                                     hintStyle: TextStyle(
                                       fontSize: 13,
                                       fontWeight: FontWeight.w500,
                                       color: Colors.black.withOpacity(0.3),
                                     ),),controller: _controllerTab1[pos],),
                           ),

                           SizedBox(height: 15),


                         ],
                       ),
                     ),

                     SizedBox(height: 7)


                   ],
                 );
               }

               ):

               selectedTabIndex==1?
               failList.length==0?

               Center(
                 child: Text("No data found"),
               ):


                   ListView.builder(
                       itemCount: failList.length,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context,int pos)

                       {
                         return Column(
                           children: [

                             Container(
                               padding: EdgeInsets.symmetric(horizontal: 15),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 boxShadow: <BoxShadow>[
                                   BoxShadow(
                                     color: Colors.black38.withOpacity(0.2),
                                     blurRadius: 6,
                                     offset: Offset(0, 0.5),
                                   ),
                                 ],
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Row(
                                     children: [

                                       Text(
                                         'Sub-Parameter',
                                         style: TextStyle(
                                             fontSize: 11,
                                             color: Color(0xFF2962FF)),
                                       ),


                                       Spacer(),


                                       Container(
                                         width: 35,
                                         height: 35,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(6),
                                             color: AppTheme.fontBlueColor
                                         ),
                                         child: Center(
                                           child:Text(
                                             (pos+1).toString(),
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.white),
                                           ),

                                         ),
                                       )



                                     ],
                                   ),

                                   SizedBox(height: 5),


                                   Text(
                                     failList[pos]["sub_parameter_detail"]["sub_parameter"],
                                     style: TextStyle(
                                         fontSize: 11,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.black),
                                   ),

                                   SizedBox(height: 10),


                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [

                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                           Text(
                                             'Score',
                                             style: TextStyle(
                                                 fontSize: 11,
                                                 color: Color(0xFF2962FF)),
                                           ),

                                           SizedBox(height: 5),
                                           Text(
                                             failList[pos]["score"].toString(),
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w500,
                                                 color: Colors.black),
                                           ),

                                         ],
                                       ),


                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                           Text(
                                             'Observation',
                                             style: TextStyle(
                                                 fontSize: 11,
                                                 color: Color(0xFF2962FF)),
                                           ),

                                           SizedBox(height: 5),
                                           Text(
                                             failList[pos]["selected_option"]==3?
                                             'Critical':failList[pos]["selected_option"]==2?
                                             'Fail':'Passed',
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w500,
                                                 color:

                                                 failList[pos]["selected_option"]==3 || failList[pos]["selected_option"]==2?

                                                 Color(0xFFDA2F47):Colors.green),
                                           ),

                                         ],
                                       )





                                     ],
                                   ),

                                   SizedBox(height: 15),




                                   Text(
                                     'Upload Realted Artifacts',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 10),


                                   GestureDetector(
                                     onTap: (){
                                       _fetchImage1(context,2,pos);
                                     },
                                     child: Row(
                                       children: [

                                         Container(
                                           width: 35,
                                           height: 35,
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: Color(0xFF354C9E)
                                           ),
                                           child: Center(
                                             child: Icon(Icons.attachment_outlined,color: Colors.white,size: 18,),
                                           ),
                                         ),

                                         SizedBox(width: 7),


                                         Text(
                                           'Choose file',
                                           style: TextStyle(
                                               fontSize: 13,
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black),
                                         ),


                                         Spacer(),



                                         imageLinksTab2[pos]=="no file"?Container():


                                         DottedBorder(
                                           borderType: BorderType.RRect,
                                           padding: EdgeInsets.zero,
                                           radius: Radius.circular(6),
                                           child: ClipRRect(
                                             borderRadius: BorderRadius.all(Radius.circular(6)),
                                             child: Container(
                                               height: 43,
                                               width: 140,
                                               color: Color(0xFFF3F3F3),
                                               child: Row(
                                                 children: [

                                                   SizedBox(width: 10),

                                                   Expanded(
                                                     child: Text(
                                                       imageLinksTab2[pos].toString().split('/').last,
                                                       style: TextStyle(fontSize: 11, color: Color(0xFF707070)),

                                                       maxLines: 1,
                                                       overflow: TextOverflow.ellipsis,

                                                     ),
                                                   ),
                                                   SizedBox(width: 5),
                                                   GestureDetector(
                                                     child: Icon(Icons.close),
                                                     onTap: (){
                                                       imageLinksTab2[pos]="no file";
                                                       setState(() {

                                                       });
                                                     },


                                                   ),
                                                   SizedBox(width: 5)

                                                 ],
                                               ),

                                             ),
                                           ),

                                         )




                                       ],
                                     ),
                                   ),

                                   SizedBox(height: 12),



                                   Text(
                                     'Auditee Observation',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 3),


                                   InkWell(
                                     onTap: (){

                                       List<String> statusItems=[];

                                       if(failList[pos]["sub_parameter_detail"]["pass"]==1)
                                       {
                                         statusItems.add("Pass");
                                       }

                                       if(failList[pos]["sub_parameter_detail"]["critical"]==1)
                                       {
                                         statusItems.add("Critical");
                                       }

                                       if(failList[pos]["sub_parameter_detail"]["na"]==1)
                                       {
                                         statusItems.add("NA");
                                       }

                                       if(failList[pos]["sub_parameter_detail"]["pwd"]==1)
                                       {
                                         statusItems.add("PWD");
                                       }

                                       modalIndex=9999;
                                       _modalBottomSheetMenu(2,pos,statusItems);
                                     },
                                     child: Container(
                                       height: 45,
                                       child: Row(
                                         children: [

                                           Text(
                                             dropdownValueTab2[pos],
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w700,
                                                 color: Color(0xFF707070)),
                                           ),

                                           Spacer(),

                                           Icon(Icons.keyboard_arrow_down_outlined)



                                         ],
                                       ),
                                     ),
                                   ),

                                   Container(
                                     height: 1,
                                     width: double.infinity,
                                     color: Colors.grey.withOpacity(0.6),
                                   ),




                                   SizedBox(height: 12),


                                   Text(
                                     'Remarks',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),


                                   SizedBox(height: 5),


                                   Container(
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(6),
                                         border: Border.all(color: Color(0xFF707070),width: 0.5)
                                     ),
                                     child: TextFormField(
                                         maxLines: 4,
                                         style: const TextStyle(
                                           fontSize: 13.0,
                                           fontWeight: FontWeight.w700,
                                           color: Color(0xFF707070),
                                         ),
                                         decoration: InputDecoration(
                                             border: InputBorder.none,
                                             //contentPadding: EdgeInsets.zero,
                                             contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 13, 5),
                                             //prefixIcon: fieldIC,
                                             hintText: "Enter Remarks",
                                             hintStyle: TextStyle(
                                               fontSize: 13,
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black.withOpacity(0.3),
                                             )),controller: _controllerTab2[pos]),
                                   ),

                                   SizedBox(height: 15),


                                 ],
                               ),
                             ),

                             SizedBox(height: 7)


                           ],
                         );
                       }

                   ):
               selectedTabIndex==2?
                   passedList.length==0?

                   Center(
                     child: Text("No data found"),
                   ):
                   ListView.builder(
                       itemCount: passedList.length,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context,int pos)

                       {
                         return Column(
                           children: [

                             Container(
                               padding: EdgeInsets.symmetric(horizontal: 15),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 boxShadow: <BoxShadow>[
                                   BoxShadow(
                                     color: Colors.black38.withOpacity(0.2),
                                     blurRadius: 6,
                                     offset: Offset(0, 0.5),
                                   ),
                                 ],
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Row(
                                     children: [

                                       Text(
                                         'Sub-Parameter',
                                         style: TextStyle(
                                             fontSize: 11,
                                             color: Color(0xFF2962FF)),
                                       ),


                                       Spacer(),


                                       Container(
                                         width: 35,
                                         height: 35,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(6),
                                             color: AppTheme.fontBlueColor
                                         ),
                                         child: Center(
                                           child:Text(
                                             (pos+1).toString(),
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.white),
                                           ),

                                         ),
                                       )



                                     ],
                                   ),

                                   SizedBox(height: 5),


                                   Text(
                                     passedList[pos]["sub_parameter_detail"]["sub_parameter"],
                                     style: TextStyle(
                                         fontSize: 11,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.black),
                                   ),

                                   SizedBox(height: 10),


                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [

                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                           Text(
                                             'Score',
                                             style: TextStyle(
                                                 fontSize: 11,
                                                 color: Color(0xFF2962FF)),
                                           ),

                                           SizedBox(height: 5),
                                           Text(
                                             passedList[pos]["score"].toString(),
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w500,
                                                 color: Colors.black),
                                           ),

                                         ],
                                       ),


                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                           Text(
                                             'Observation',
                                             style: TextStyle(
                                                 fontSize: 11,
                                                 color: Color(0xFF2962FF)),
                                           ),

                                           SizedBox(height: 5),
                                           Text(
                                             passedList[pos]["selected_option"]==3?
                                             'Critical':passedList[pos]["selected_option"]==2?
                                             'Fail':'Passed',
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w500,
                                                 color:

                                                 passedList[pos]["selected_option"]==3 || passedList[pos]["selected_option"]==2?

                                                 Color(0xFFDA2F47):Colors.green),
                                           ),

                                         ],
                                       )





                                     ],
                                   ),

                                   SizedBox(height: 15),




                                   Text(
                                     'Upload Realted Artifacts',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 10),


                                   GestureDetector(
                                     onTap: (){
                                       _fetchImage1(context,3,pos);
                                     },
                                     child: Row(
                                       children: [

                                         Container(
                                           width: 35,
                                           height: 35,
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: Color(0xFF354C9E)
                                           ),
                                           child: Center(
                                             child: Icon(Icons.attachment_outlined,color: Colors.white,size: 18,),
                                           ),
                                         ),

                                         SizedBox(width: 7),


                                         Text(
                                           'Choose file',
                                           style: TextStyle(
                                               fontSize: 13,
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black),
                                         ),


                                         Spacer(),



                                         imageLinksTab3[pos]=="no file"?Container():


                                         DottedBorder(
                                           borderType: BorderType.RRect,
                                           padding: EdgeInsets.zero,
                                           radius: Radius.circular(6),
                                           child: ClipRRect(
                                             borderRadius: BorderRadius.all(Radius.circular(6)),
                                             child: Container(
                                               height: 43,
                                               width: 140,
                                               color: Color(0xFFF3F3F3),
                                               child: Row(
                                                 children: [

                                                   SizedBox(width: 10),

                                                   Expanded(
                                                     child: Text(
                                                       imageLinksTab3[pos].toString().split('/').last,
                                                       style: TextStyle(fontSize: 11, color: Color(0xFF707070)),

                                                       maxLines: 1,
                                                       overflow: TextOverflow.ellipsis,

                                                     ),
                                                   ),
                                                   SizedBox(width: 5),
                                                   GestureDetector(
                                                       child: Icon(Icons.close),
                                                   onTap: (){
                                                         imageLinksTab3[pos]="no file";
                                                         setState(() {

                                                         });
                                                   },


                                                   ),
                                                   SizedBox(width: 5)

                                                 ],
                                               ),

                                             ),
                                           ),

                                         )







                                       ],
                                     ),
                                   ),

                                   SizedBox(height: 12),



                                   Text(
                                     'Auditee Observation',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),

                                   SizedBox(height: 3),


                                   InkWell(
                                     onTap: (){

                                       List<String> statusItems=[];

                                       if(passedList[pos]["sub_parameter_detail"]["fail"]==1)
                                         {
                                           statusItems.add("Fail");
                                         }

                                       if(passedList[pos]["sub_parameter_detail"]["critical"]==1)
                                       {
                                         statusItems.add("Critical");
                                       }

                                       if(passedList[pos]["sub_parameter_detail"]["na"]==1)
                                       {
                                         statusItems.add("NA");
                                       }

                                       if(passedList[pos]["sub_parameter_detail"]["pwd"]==1)
                                       {
                                         statusItems.add("PWD");
                                       }
                                       modalIndex=9999;




                                       _modalBottomSheetMenu(3,pos,statusItems);
                                     },
                                     child: Container(
                                       height: 45,
                                       child: Row(
                                         children: [

                                           Text(
                                             dropdownValueTab3[pos],
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w700,
                                                 color: Color(0xFF707070)),
                                           ),

                                           Spacer(),

                                           Icon(Icons.keyboard_arrow_down_outlined)



                                         ],
                                       ),
                                     ),
                                   ),

                                   Container(
                                     height: 1,
                                     width: double.infinity,
                                     color: Colors.grey.withOpacity(0.6),
                                   ),




                                   SizedBox(height: 12),




                                   Text(
                                     'Remarks',
                                     style: TextStyle(
                                         fontSize: 11,
                                         color: Color(0xFF2962FF)),
                                   ),


                                   SizedBox(height: 5),


                                   Container(
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(6),
                                         border: Border.all(color: Color(0xFF707070),width: 0.5)
                                     ),
                                     child: TextFormField(
                                         maxLines: 4,
                                         style: const TextStyle(
                                           fontSize: 13.0,
                                           fontWeight: FontWeight.w700,
                                           color: Color(0xFF707070),
                                         ),
                                         decoration: InputDecoration(
                                             border: InputBorder.none,
                                             //contentPadding: EdgeInsets.zero,
                                             contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 13, 5),
                                             //prefixIcon: fieldIC,
                                             hintText: "Enter Remarks",
                                             hintStyle: TextStyle(
                                               fontSize: 13,
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black.withOpacity(0.3),
                                             )),controller: _controllerTab3[pos]),
                                   ),

                                   SizedBox(height: 15),


                                 ],
                               ),
                             ),

                             SizedBox(height: 7)


                           ],
                         );
                       }

                   ):Container()






               ,
             ):Container(),



















              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            child:  Container(
              height: 50,
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

                  if(selectedTabIndex==2)
                  {
                    List<dynamic> rebuttalData=[];
                    for(int i=0;i<passedList.length;i++)
                    {
                      print("Index");
                      print(i.toString());
                      if(_controllerTab3[i].text!="")
                      {
                        int selectedOption=1;

                        if(dropdownValueTab3[i]=="Pass")
                          {
                            selectedOption=1;
                          }

                       else if(dropdownValueTab3[i]=="Fail")
                        {
                          selectedOption=2;
                        }
                        else if(dropdownValueTab3[i]=="Critical")
                        {
                          selectedOption=3;
                        }
                        else if(dropdownValueTab3[i]=="NA")
                        {
                          selectedOption=4;
                        }
                        else if(dropdownValueTab3[i]=="PWD")
                        {
                          selectedOption=5;
                        }
                        Map<String,dynamic> data={
                          "audit_id":passedList[i]["audit_id"],
                          "parameter_id":passedList[i]["parameter_id"],
                          "sub_parameter_id":passedList[i]["sub_parameter_id"],
                          "remark":_controllerTab3[i].text.toString(),
                          "artifact":imageLinksTab3[i],
                          "desired_option":selectedOption,

                        };
                        AppModel.rebuttalData.add(data);

                      }
                    }

                    print(rebuttalData.toString());

                  }
                  else if(selectedTabIndex==0)
                  {
                    List<dynamic> rebuttalData=[];
                    for(int i=0;i<criticalList.length;i++)
                    {
                      if(_controllerTab1[i].text!="")
                      {
                        int selectedOption=3;

                        if(dropdownValueTab1[i]=="Pass")
                        {
                          selectedOption=1;
                        }

                        else if(dropdownValueTab1[i]=="Fail")
                        {
                          selectedOption=2;
                        }
                        else if(dropdownValueTab1[i]=="Critical")
                        {
                          selectedOption=3;
                        }
                        else if(dropdownValueTab1[i]=="NA")
                        {
                          selectedOption=4;
                        }
                        else if(dropdownValueTab1[i]=="PWD")
                        {
                          selectedOption=5;
                        }




                        Map<String,dynamic> data={

                          "audit_id":criticalList[i]["audit_id"],
                          "parameter_id":criticalList[i]["parameter_id"],
                          "sub_parameter_id":criticalList[i]["sub_parameter_id"],
                          "remark":_controllerTab1[i].text.toString(),
                          "artifact":imageLinksTab1[i],
                          "desired_option":selectedOption,

                        };
                        AppModel.rebuttalData.add(data);
                      }
                    }
                    // raiseRebuttal(rebuttalData);
                    print(AppModel.rebuttalData.toString());
                  }

                  else if(selectedTabIndex==1)
                  {
                    List<dynamic> rebuttalData=[];
                    for(int i=0;i<failList.length;i++)
                    {
                      if(_controllerTab2[i].text!="")
                      {

                        int selectedOption=2;

                        if(dropdownValueTab2[i]=="Pass")
                        {
                          selectedOption=1;
                        }

                        else if(dropdownValueTab2[i]=="Fail")
                        {
                          selectedOption=2;
                        }
                        else if(dropdownValueTab2[i]=="Critical")
                        {
                          selectedOption=3;
                        }
                        else if(dropdownValueTab2[i]=="NA")
                        {
                          selectedOption=4;
                        }
                        else if(dropdownValueTab2[i]=="PWD")
                        {
                          selectedOption=5;
                        }


                        Map<String,dynamic> data={

                          "audit_id":failList[i]["audit_id"],
                          "parameter_id":failList[i]["parameter_id"],
                          "sub_parameter_id":failList[i]["sub_parameter_id"],
                          "remark":_controllerTab2[i].text.toString(),
                          "artifact":imageLinksTab2[i],
                          "desired_option":selectedOption,
                        };
                        AppModel.rebuttalData.add(data);
                      }
                    }
                    print(rebuttalData.toString());
                  }


                  if(AppModel.rebuttalData.length==0)
                  {
                    Toast.show("Please enter atleast one remark !",
                        duration: Toast.lengthLong,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red);
                  }
                  else
                  {

                    Toast.show("Saved successfully !!",
                        duration: Toast.lengthLong,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green);
                    Navigator.pop(context,"Refresh");
                  }






                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCritical=false;
    isFail=false;
    isPassed=false;
    if (widget.paraList[widget.cardIndex]["fail_count"] >
        widget.paraList[widget.cardIndex]["pass_count"] &&
        widget.paraList[widget.cardIndex]["fail_count"] >
            widget.paraList[widget.cardIndex]["critical_count"]) {
      isFail = true;
    } else if (widget.paraList[widget.cardIndex]["critical_count"] >
        widget.paraList[widget.cardIndex]["pass_count"] &&
        widget.paraList[widget.cardIndex]["critical_count"] >
            widget.paraList[widget.cardIndex]["fail_count"]) {
      isCritical = true;
    } else {
      isPassed = true;
    }



    for(int i=0;i<widget.subParamsList.length;i++)
      {
        if(widget.subParamsList[i]["selected_option"]==3)
          {
            criticalList.add(widget.subParamsList[i]);
            _controllerTab1.add(TextEditingController());
            dropdownValueTab1.add("Critical");
            imageLinksTab1.add("no file");
          }
        else if(widget.subParamsList[i]["selected_option"]==2)
          {
            failList.add(widget.subParamsList[i]);
            _controllerTab2.add(TextEditingController());
            dropdownValueTab2.add("Fail");
            imageLinksTab2.add("no file");
          }
        else
          {
            passedList.add(widget.subParamsList[i]);
            _controllerTab3.add(TextEditingController());
            dropdownValueTab3.add("Pass");
            imageLinksTab3.add("no file");
          }
      }



    print("Length of Passed List "+passedList.length.toString());


    dataLoaded=true;
    setState(() {

    });



  }








  _fetchImage1(BuildContext context,int tabNumber,int pos) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image22 = await _picker.pickImage(source: ImageSource.gallery);
    print('Image File From Android' + (image22?.path).toString());
    if (image22 != null) {
     uploadImage(tabNumber, image22, pos);
    }
  }






  void _modalBottomSheetMenu(int tabNumber,int pos,List<String> statusListLocal) {
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
                          child: Text('Auditee Observation',
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


                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: statusListLocal.length,
                      physics: NeverScrollableScrollPhysics(),

                      itemBuilder: (BuildContext context,int pos)

                      {
                        return Column(
                          children: [

                            GestureDetector(
                              onTap:(){

                                setModalState(() {
                                  modalIndex=pos;
                                });


                              },
                              child: Container(
                                color: Colors.white,
                                width:double.infinity,
                                height:40,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text(statusListLocal[pos],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),



                                      modalIndex==pos?
                                      Icon(Icons.check_circle,color: Colors.greenAccent):Container()




                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 13),
                              child: Divider(),

                            ),

                            SizedBox(height: 5)

                          ],
                        );
                      }

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
                            if(modalIndex!=9999)
                            {
                              Navigator.pop(context);

                              if(tabNumber==1)
                                {
                                  dropdownValueTab1[pos]=statusListLocal[modalIndex];
                                }
                              else if(tabNumber==2)
                                {
                                  dropdownValueTab2[pos]=statusListLocal[modalIndex];

                                }
                              else if(tabNumber==3)
                                {
                                  dropdownValueTab3[pos]=statusListLocal[modalIndex];
                                }
                              setState(() {

                              });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: AppTheme.blueColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 43,
                              child: const Center(
                                child: Text('Submit',
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


  uploadImage(int tabNumber,XFile imageFile,int pos) async {
    APIDialog.showAlertDialog(context, 'Uploading image...');
    FormData formData = FormData.fromMap({
      "file_upload": await MultipartFile.fromFile(imageFile.path),
    });
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Authorization'] = AppModel.token;
    print(AppConstant.appBaseURL+"upload_image");
    var response =
    await dio.post(AppConstant.appBaseURL+"upload_image", data: formData);
    print(response.data);
    Navigator.pop(context);
    if (response.data['status']==200) {
      Toast.show(response.data['message'].toString(),
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);


      if(tabNumber==1)
        {
          imageLinksTab1[pos]=response.data["file_image"];
        }
      else if(tabNumber==2)
        {
          imageLinksTab2[pos]=response.data["file_image"];

        }
      else if(tabNumber==3)
      {
        imageLinksTab3[pos]=response.data["file_image"];

      }
      setState(() {

      });

      print("Updated Image Links");

      print(imageLinksTab1.toString());
      print(imageLinksTab2.toString());
      print(imageLinksTab3.toString());









    } else {
      Toast.show(response.data['message'].toString(),
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }
  }


}