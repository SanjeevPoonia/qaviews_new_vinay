
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/view/dashboard_1.dart';
import 'package:qaviews/view/login_screen.dart';
import 'package:qaviews/view/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'calender_screen.dart';
import 'dashboard2.dart';

class DashboardScreen extends StatefulWidget{
  bool showBack;
  DashboardScreen(this.showBack);
  @override
  DashboardState createState() => DashboardState();
}
class DashboardState extends State<DashboardScreen> with TickerProviderStateMixin {
  bool isLoading = false;
  String selectParameter = '11';
  StateSetter? setStateGlobal;

  String startDate="";
  String endDate="";
  String dateRange="";
  int selectedIndex=0;
  String agentID = '';
  String name = '';
  String timeGreeting="";
  Map<String,dynamic> dashboardCountData={};
  String email = '';
  List<GDPData> _chartData=[];
  Map<String,dynamic> agentData = {};
  List<dynamic> lobList=[];
  List<String> lobListAsString=[];
  String profileImage="";
  int selectedLobIndex=9999;
  Map<String,dynamic> lobTableData={};
  List<dynamic> callTypeList=[];
  List<dynamic> parameterComplianceList=[];
  int selectedCallTypeIndex=0;
  TabController? tabController;

  @override

  Widget build(BuildContext context) {
    double progressValue = 1;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: widget.showBack
              ? AppBar(
            backgroundColor: AppTheme.blueColor,
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/logout.svg',
                width: 25,
                height: 25,
              ),
              onPressed: () {

                _logOut();
                // Add your right button action here
              },
            ),

            actions: [
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/filter.svg',
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    _bottomSheetFilter();

                  }
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/notification.svg',
                    width: 25,
                    height: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotifyScreen(true)));
                  }
              ),
            ],

            title: Image.asset(
              'assets/porter.png',
              width: 100,
              height: 60,
            ),
            centerTitle: true,
          )
              : PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar()),
          backgroundColor: AppTheme.backgroundColor,
          extendBody: true,
          body:

          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 5,),
                        decoration: BoxDecoration(
                          color:
                          Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  // Left: Profile Image
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 49.0, // Set the desired width
                                    height: 55.0, // Set the desired height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      image: DecorationImage(
                                        image: NetworkImage(profileImage), // Replace with your image path
                                        fit: BoxFit.fill, // Adjust the fit as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0), // Add some space between the image and text
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text(
                                        timeGreeting,
                                        style: TextStyle(fontSize: 12.0,
                                            color: Color(0xFFFEDF00)
                                        ),
                                      ),

                                      SizedBox(height:2),
                                      Text(
                                        name,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height:2),
                                      Text(
                                        'Agent id: $agentID',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),

                Container(
                  height: 53,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: AppBar(
                    backgroundColor: AppTheme.fontLightBlueColor.withOpacity(0.8),
                    bottom: TabBar(
                      indicatorColor: AppTheme.themeColor,
                      unselectedLabelColor: Colors.black38,
                      labelColor: Colors.white,
                      labelStyle:
                      const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      controller: tabController,
                      tabs: const [
                        Tab(
                          text: 'Dashboard 1',
                        ),
                        Tab(
                          text: 'Dashboard 2',
                        ),

                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Dashboard1(true),
                      Dashboard2(),


                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
  void initState() {

    super.initState();
    tabController = TabController(vsync: this, length: 2);
    //  getDashboardData();
    startDate=DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDate=DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 27)));
    timeGreeting=greeting();
    fetchProfileData();
  }


  getLOBList() async {
    setState(() {
      isLoading=true;
    });


    var requestModel = {
      /* "agent_id": userId,*/
    };

    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard/lob_list',requestModel, context);
    // isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    lobList=responseJSON["lob_details"];
    selectedLobIndex=0;
    setState(() {});
    getLOBData(lobList[0]["process_id"].toString());
  }

  getDashboardCounts() async {
    var requestModel = {
      "start_date":startDate,
      "end_date":endDate
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard_counts',requestModel, context);

    var responseJSON = json.decode(response.body);
    dashboardCountData=responseJSON["data"];
    print("The counts are");
    print(responseJSON);
    setState(() {});
  }
  getLOBData(String lobID) async {
    /*  setState(() {
      isLoading=true;
    });*/


    var requestModel = {
      "process_id":lobID,
      "start_date":startDate,
      "end_date":endDate
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('agent_dashboard/lob',requestModel, context);

    var responseJSON = json.decode(response.body);
    lobTableData=responseJSON["final_data"];
    callTypeList=lobTableData["qrc"];
    parameterComplianceList=lobTableData["parameter_compiance"];
    _chartData = getChartData();
    isLoading = false;
    print(responseJSON);
    setState(() {});
  }
  showLogOutDialog(BuildContext context) {
    Widget cancelButton = GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Text("Cancel"));
    Widget continueButton = GestureDetector(
        onTap: (){
          Navigator.pop(context);
          // _logOut();
        },

        child: Text("Logout",style: TextStyle(
            color: Colors.red
        ),));

    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to Log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
          setStateGlobal=bottomSheetState;
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
                        Text('LOB Parameters Filter',
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
                    itemCount: lobList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int pos) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      return GestureDetector(
                        onTap: (){

                          bottomSheetState(() {
                            selectedLobIndex=pos;
                          });
                          Navigator.pop(context);

                          getLOBData(lobList[selectedLobIndex]["process"]["id"].toString());






                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          //color: selectIndexResStatus == pos ? _currentColor : Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0), // Set left padding
                                    child: Text(lobList[pos]["process"]["name"],
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                  ),


                                  selectedLobIndex==pos?

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.check_circle,color: AppTheme.fontBlueColor,size: 18),
                                  ):
                                  Container(),


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

  _logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [];


    for(int i=0;i<lobTableData["pareto_data"]["per"].length;i++)
    {
      chartData.add(GDPData("Reason "+(i+1).toString(), double.parse(lobTableData["pareto_data"]["per"][i].toString())));
    }
    return chartData;
  }


  fetchProfileData() async {
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id":userId,
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('user_profile', requestModel, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    name = responseJSON["data"]["name"];
    email = responseJSON["data"]["email"];
    profileImage = responseJSON["data"]["avatar"];
    agentID = responseJSON["data"]["id"].toString();
    setState(() {});
    callapiUrl();
  }

  void _bottomSheetFilter() {
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Text('Filter',
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


                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Select Date Range",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 15),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),

                    child: GestureDetector(
                      onTap: () async {
                        final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderView()));
                        if(result!=null)
                        {
                          List<String> list=result.toString().split(',');
                          print(list[0]);
                          startDate=list[0].trim();
                          endDate=list[1].trim();
                          print("date range");
                          print(startDate);
                          print(endDate);

                          dateRange=startDate+" - "+endDate;



                          setModalState(() {

                          });
                        }
                      },
                      child: Row(
                        children: [

                          Image.asset("assets/calender_icc.png",width: 12,height: 12),

                          SizedBox(width: 10),

                          Text(
                            dateRange,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black),
                          ),








                        ],
                      ),
                    ),

                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
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
/*

                            if(dateRange!="")
                            {
                              Navigator.pop(context);

                              getLOBData(lobList[selectedLobIndex]["process_id"].toString());
                              getDashboardCounts();

                            }
*/



                          Navigator.pop(context);



                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: AppTheme.blueColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 43,
                              child: const Center(
                                child: Text('Apply',
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







  callapiUrl() async {
    setState(() {});
    var requestModel = {
      "link": profileImage
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    var responseJSON = json.decode(response.body);
    profileImage = responseJSON["public_link"];
    //print('CallUrl:- $callAudioUrl');
    setState(() {});
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning !';
    }
    if (hour < 17) {
      return 'Good Afternoon !';
    }
    return 'Good Evening!';
  }

}
class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}

