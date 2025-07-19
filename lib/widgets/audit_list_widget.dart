

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utils/app_theme.dart';
import '../view/audit_action_screen.dart';

class AuditListWidget extends StatelessWidget {

  AuditListWidget(this.agentName,this.email, this.callID,this.auditDate,this.cusNumber,this.rebuttalRisedBy,this.feedbackStatus,this.score,this.auditID,this.auditData,this.rebuttalStatus, {super.key});
  String agentName = '';
  String email = '';
  String callID = '';
  String auditDate = '';
  String cusNumber = '';
  int rebuttalStatus = -1;
  String rebuttalRisedBy = '';
  String feedbackStatus = '';
  String strFeedbackStatus = '';
  double score = 0.0;
  String auditID="";
  String strRebuttal = "";
  Map<String,dynamic> auditData;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (feedbackStatus == '1'){
      strFeedbackStatus = 'Accepted';
    }else if (feedbackStatus == '2'){
      strFeedbackStatus = 'Rejected';
    }else{
      strFeedbackStatus = 'Not shared';
    }
    if (rebuttalStatus == 0){
      strRebuttal = 'Un-seen';
    }else if (rebuttalStatus == 1){
      strRebuttal = 'Seen';
    }else if (rebuttalStatus == 2){
      strRebuttal = 'Raised';
    }
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emp. Details',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFBFBFBF)),
                ),
                Text(
                  'Audit Status',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFBFBFBF)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  agentName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.fontBlueColor),
                ),
                const SizedBox(width: 10),


                auditData["audit"]["is_critical"].toString()=="1"?
                Container(
                  height: 25,
                  width: 62,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red, width: 1.5)),
                  child: const Center(
                    child: Text(
                      'Fatal',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                ):
                Container(
                  height: 25,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green, width: 1.5)),
                  child: const Center(
                    child: Text(
                      'Non Fatal',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: List.generate(
            //       140 ~/ 2,
            //       (index) => Expanded(
            //             child: Container(
            //               color: index % 2 == 0
            //                   ? Colors.transparent
            //                   : Colors.grey.withOpacity(0.6),
            //               height: 2,
            //             ),
            //           )),
            // ),
            Image.asset(
              'assets/corner.png', // Replace with your PNG image path
              width: screenWidth, // Adjust the image width as needed
              height: 50,
              fit: BoxFit.fill, // Adjust the image height as needed
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Call Id',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
                Text(
                  'Cust. Number',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    callID,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    cusNumber,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Audit Date',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
                Text(
                  'Rebuttal Raised by',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  auditDate,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  rebuttalRisedBy,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rebuttal Seen Status',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
                Text(
                  'Feedback Status',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  strRebuttal,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  strFeedbackStatus,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: feedbackStatus == '1' ? AppTheme.darkGreen : feedbackStatus == '2' ? Colors.red:Colors.orange,
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 10),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Rebuttal Accepted',
            //       style: TextStyle(
            //           fontSize: 11.5, color: AppTheme.fontLightBlueColor),
            //     ),
            //     Text(
            //       'Rebuttal Rejected',
            //       style: TextStyle(
            //           fontSize: 11.5, color: AppTheme.fontLightBlueColor),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 3),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       '0',
            //       style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.black),
            //     ),
            //     Text(
            //       '0',
            //       style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.black),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score',
                  style: TextStyle(
                      fontSize: 11.5, color: AppTheme.fontLightBlueColor),
                ),
                Text(
                  score.toString() + '%',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFEDF00),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(5),
              lineHeight: 8.0,
              percent: score/100,
              progressColor: const Color(0xFFFEDF00),
            ),
            const SizedBox(height: 20),
            Container(
              height: 53,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // background
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.fontLightBlueColor), // fore
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ))),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditActionScreen(auditID)));

                },
                child: const Text(
                  'Action',
                  style: TextStyle(fontSize: 14.5),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
