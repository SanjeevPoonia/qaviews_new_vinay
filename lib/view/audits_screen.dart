import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qaviews/widgets/audit_list_widget.dart';
import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'calender_screen.dart';

class AuditsScreen extends StatefulWidget {
  const AuditsScreen({super.key});

  @override
  AuditState createState() => AuditState();
}

class AuditState extends State<AuditsScreen> {
  bool isLoading = false;
  List<dynamic> auditList = [];
  String startDate="";
  String endDate="";
  String dateRange="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.blueColor,
        title: const Text(
          'Audits',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body:  isLoading?
      Center(
          child:Loader()
      ):
      ListView(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 60),
        children: [
          const SizedBox(height: 10),
          const Text(
            'Audits',
            style: TextStyle(fontSize: 12, color: Color(0xFF949494)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
               Text(
                dateRange,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
               final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderView()));
               if(result!=null)
                 {
                   List<String> list=result.toString().split(',');
                   dateRange = '${DateFormat('dd MMM(yyyy)').format(DateTime.parse(list[0].trim()+" 11:27:00"))} -'
                   // ignore: lines_longer_than_80_chars
                       ' ${DateFormat('dd MMM(yyyy)').format(DateTime.parse(list[1].trim()+" 11:27:00"))}';
                  
                   print(list[0]);
                   startDate=list[0].trim();
                   endDate=list[1].trim();
                   print("date range");
                   print(startDate);
                   print(endDate);
                   gatAuditData();


                  setState(() {

                  });
                 }
                },
                child: Container(
                  height: 28,
                  width: 62,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF707070).withOpacity(0.1)),
                  child: const Center(
                    child: Text(
                      'Date',
                      style: TextStyle(fontSize: 11, color: Color(0xFF888888)),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              Text(
                'List',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.fontBlueColor),
              ),
              SizedBox(width: 5),
              Icon(Icons.sort, color: AppTheme.fontBlueColor, size: 17)
            ],
          ),
          const SizedBox(height: 10),

          auditList.length==0?


              Container(
                height: 350,
                child: Center(
                  child: Text("No data found for these dates !"),
                ),
              ):


          ListView.builder(
              itemCount: auditList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int pos) {
                return Column(
                  children: [AuditListWidget(auditList[pos]['agent_details']['name'],auditList[pos]['agent_details']['email'],auditList[pos]['call_id'],
                      auditList[pos]['audit']['audit_date'],auditList[pos]['phone_number'],auditList[pos]['audit']['rebuttal_tat'],
                      auditList[pos]['audit']['feedback_status'].toString(),auditList[pos]['audit']['with_fatal_score_per'].toDouble(),auditList[pos]['audit']['id'].toString(),auditList[pos],auditList[pos]['audit']['rebuttal_status']),
                    SizedBox(height: 13)],
                );
              }),
          const SizedBox(height: 15),
         /* Container(
            height: 53,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
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
              onPressed: () {},
              child: const Text(
                'Show More',
                style: TextStyle(fontSize: 14.5),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              '10 out of 50 records',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF949494).withOpacity(0.74)),
            ),
          ),*/
          const SizedBox(height: 55),
        ],
      ),
    );
  }
  void initState() {
    super.initState();

    startDate=DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate=DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 27)));
    print("date range");
    print(startDate);
    print(endDate);
    gatAuditData();
    dateRange = '${DateFormat('dd MMM(yyyy)').format(DateTime.now())} -'
    // ignore: lines_longer_than_80_chars
        ' ${DateFormat('dd MMM(yyyy)').format(DateTime.now().add(Duration(days: 27)))}';
  }
  gatAuditData() async {
    isLoading = true;
    setState(() {});
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id":userId,
      "start_date":startDate,
      "end_date":endDate
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('audit_list', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    auditList = responseJSON["data"];
    setState(() {});
  }
}
