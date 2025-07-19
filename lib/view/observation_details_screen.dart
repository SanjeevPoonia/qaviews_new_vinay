

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qaviews/view/raise_rebuttal_screen.dart';
import 'package:qaviews/view/raise_rebuttal_screen1.dart';

import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'audit_plan_of_action.dart';
import 'feedback.dart';

class ObservationDetails extends StatefulWidget
{
  final Map<String,dynamic> auditData;
  final List<dynamic> paramList;
  final int selectedIndex;
  ObservationDetails(this.auditData,this.paramList,this.selectedIndex);
  ObservationState createState()=>ObservationState();
}
class ObservationState extends State<ObservationDetails>
{
  int selectedIndex=0;
  List<dynamic> subParamsList=[];
  Map<String,dynamic> cardData={};
  int currentParamID=0;

  bool isCritical = false;
  bool isFail = false;
  bool isPassed = false;

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

       Card(
         color: Colors.white,
         elevation: 3,
         child:   Container(
           padding: EdgeInsets.symmetric(horizontal: 10),
           width: double.infinity,
           height: 50,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               GestureDetector(
                 onTap: (){
                   if(selectedIndex!=0)
                     {
                       fetchNext(selectedIndex-1);
                     }
                 },
                 child: Row(
                   children: [

                     Image.asset("assets/arrow_left_ic.png",width: 12,height: 12,color: selectedIndex==0?Color(0xFF949494):AppTheme.fontBlueColor),
                     SizedBox(width: 5),

                     Text(
                       'PREVIOUS',
                       style: TextStyle(
                           color:
                           selectedIndex==0?
                           Color(0xFF949494):AppTheme.fontBlueColor,
                           fontSize: 13, fontWeight: FontWeight.w600),
                     ),



                   ],
                 ),
               ),

               selectedIndex==widget.paramList.length-1?


                   Container():



               GestureDetector(
                 onTap: (){
                   fetchNext(selectedIndex+1);
                 },
                 child: Row(
                   children: [



                     Text(
                       'NEXT',
                       style: TextStyle(
                           color:AppTheme.fontBlueColor,
                           fontSize: 13, fontWeight: FontWeight.w600),
                     ),
                     SizedBox(width: 5),

                     Image.asset("assets/arrow_right_ic.png",width: 12,height: 12),

                   ],
                 ),
               )


             ],
           ),
         ),
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
                           widget.paramList[selectedIndex]
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
                                     ? widget.paramList[selectedIndex]
                                 ["critical_count"]
                                     .toString()
                                     : isFail
                                     ? widget
                                     .paramList[selectedIndex]
                                 ["fail_count"]
                                     .toString()
                                     : widget
                                     .paramList[selectedIndex]
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
                             widget.paramList[selectedIndex]
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
                                         selectedIndex][
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
                                         selectedIndex][
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
                                         selectedIndex][
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
                                         selectedIndex][
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
                                         selectedIndex][
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
                                         selectedIndex][
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

       Expanded(child: ListView.builder(
           itemCount: subParamsList.length,
           itemBuilder: (BuildContext context,int pos)

       {
         return Column(
           children: [

             Card(
               margin: EdgeInsets.symmetric(horizontal: 12),
               color: Colors.white,
               elevation: 3,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(5),
               ),
               child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
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
                     subParamsList[pos]["sub_parameter_detail"]["sub_parameter"],
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
                               'Observation',
                               style: TextStyle(
                                   fontSize: 11,
                                   color: Color(0xFF2962FF)),
                             ),

                             SizedBox(height: 5),
                             Text(
                               subParamsList[pos]["selected_option"]==3?
                               'Critical':
                               subParamsList[pos]["selected_option"]==2?
                               'Fail':
                               "Passed",
                               style: TextStyle(
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500,
                                   color:
                                   subParamsList[pos]["selected_option"]==3 ||  subParamsList[pos]["selected_option"]==2?

                                   Color(0xFFDA2F47):Colors.green),
                             ),

                           ],
                         ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Text(
                               'Scored',
                               style: TextStyle(
                                   fontSize: 11,
                                   color: Color(0xFF2962FF)),
                             ),

                             SizedBox(height: 5),
                             Text(
                               subParamsList[pos]["score"].toString(),
                               style: TextStyle(
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.black),
                             ),

                           ],
                         ),








                       ],
                     ),

                     SizedBox(height: 15),


                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [


                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Text(
                               'Reason Type',
                               style: TextStyle(
                                   fontSize: 11,
                                   color: Color(0xFF2962FF)),
                             ),

                             SizedBox(height: 5),
                             Text(
                               subParamsList[pos]["reason_type"]!=null?subParamsList[pos]["reason_type"]:"NA",
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
                               'Reason',
                               style: TextStyle(
                                   fontSize: 11,
                                   color: Color(0xFF2962FF)),
                             ),

                             SizedBox(height: 5),
                             Text(
                               subParamsList[pos]["reason"]!=null?subParamsList[pos]["reason"]:"NA",
                               style: TextStyle(
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.black),
                             ),

                           ],
                         ),








                       ],
                     ),


                     SizedBox(height: 10),


                     Text(
                       'Remarks',
                       style: TextStyle(
                           fontSize: 11,
                           color: Color(0xFF2962FF)),
                     ),



                     SizedBox(height: 5),
                     Text(
                       subParamsList[pos]["remark"]!=null?subParamsList[pos]["remark"]:"NA",
                       style: TextStyle(
                           fontSize: 13,
                           fontWeight: FontWeight.w500,
                           color: Colors.black),
                     ),



                     SizedBox(height: 15),

                     Text(
                       'Screenshot',
                       style: TextStyle(
                           fontSize: 11,
                           color: Color(0xFF2962FF)),
                     ),

                     SizedBox(height: 10),



                     subParamsList[pos]["screenshot"]!=null?


                     Container(
                       width:60,
                       height: 60,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           image: DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/audit_dummy.jpeg")
                           )
                       ),
                     ):


                     Text(
                       "NA",
                       style: TextStyle(
                           fontSize: 13,
                           fontWeight: FontWeight.w500,
                           color: Colors.black),
                     ),



                     SizedBox(height: 15),





                   ],
                 ),
               ),
             ),

             SizedBox(height: 12)


           ],
         );
       }

       )),


         Container(
           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
               Row(
                 children: [


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
                              Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         FeedbackScreen(true,widget.auditData["audit_data"]["id"].toString())));
                           },
                           child: const Text(
                             'Feedback',
                             style: TextStyle(fontSize: 11),
                           ),
                         ),
                       ),
                       flex: 1),

                   SizedBox(width: 5),



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
                                   AppTheme.fontLightBlueColor), // fore
                               shape: MaterialStateProperty.all<
                                   RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(6.0),
                                   ))),
                           onPressed: () {
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>AuditPlan(widget.auditData["audit_data"]["id"].toString(),widget.paramList,widget.auditData)));

                           },
                           child: const Text(
                             'Plan of Action',
                             style: TextStyle(fontSize: 11),
                           ),
                         ),
                       ),
                       flex: 1),
                   SizedBox(width: 5),




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

                         /*    int currentParamID=widget.paramList[selectedIndex]["qmSheeetParameater_id"];
                             print("The ID is "+currentParamID.toString());
                             List<dynamic> rebuttalList=[];

                             for(int i=0;i<widget.auditData["audit_data"]["audit_results"].length;i++)
                             {
                               if(currentParamID==widget.auditData["audit_data"]["audit_results"][i]["parameter_id"])
                               {
                                 rebuttalList.add(widget.auditData["audit_data"]["audit_results"][i]);
                               }
                             }*/
                             AppModel.setRebuttalData([]);
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         RaisereButtal1(widget.paramList,widget.auditData)));

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

             ],
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
    selectedIndex=widget.selectedIndex;
    setUpData();



    print("length of sub Params is "+subParamsList.toString());





  }


  setUpData(){
    isCritical=false;
    isFail=false;
    isPassed=false;



    if (widget.paramList[selectedIndex]["fail_count"] >
        widget.paramList[selectedIndex]["pass_count"] &&
        widget.paramList[selectedIndex]["fail_count"] >
            widget.paramList[selectedIndex]["critical_count"]) {
      isFail = true;
    } else if (widget.paramList[selectedIndex]["critical_count"] >
        widget.paramList[selectedIndex]["pass_count"] &&
        widget.paramList[selectedIndex]["critical_count"] >
            widget.paramList[selectedIndex]["fail_count"]) {
      isCritical = true;
    } else {
      isPassed = true;
    }

    currentParamID=widget.paramList[selectedIndex]["qmSheeetParameater_id"];
    print("The ID is "+currentParamID.toString());

    for(int i=0;i<widget.auditData["audit_data"]["audit_results"].length;i++)
    {
      if(currentParamID==widget.auditData["audit_data"]["audit_results"][i]["parameter_id"])
      {
        subParamsList.add(widget.auditData["audit_data"]["audit_results"][i]);
      }
    }

    setState(() {

    });

  }




  fetchNext(int currentIndex){

    selectedIndex=currentIndex;

    setUpData();
  }


}