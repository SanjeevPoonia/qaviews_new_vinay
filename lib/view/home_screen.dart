import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qaviews/view/app_screen.dart';
import 'package:qaviews/view/audits_screen.dart';
import 'package:qaviews/view/dashboard_1.dart';
import 'package:qaviews/bloc/cubit/cart_cubit.dart';
import 'package:qaviews/drawer/zoom_scaffold.dart';
import 'package:qaviews/network/loader.dart';
import 'package:qaviews/utils/app_modal.dart';
import 'package:qaviews/utils/app_theme.dart';
import 'package:qaviews/view/profile.dart';
import 'package:qaviews/view/rebuttal.dart';
import 'package:qaviews/view/splash_screen.dart';
import 'package:qaviews/view/url_screen.dart';

import '../drawer/menu_page.dart';
import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'dashboard_screen.dart';
import 'feedback_notification.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  int selectedIndex = 3;
  bool isLoading=false;
  bool showBoxes = false;

  String name='';
  List<Widget> bottomTabItems = <Widget>[
    DashboardScreen(true),
    //AuditsScreen(),
    ProfileScreen(true),
    RebuttalScreen(true),
    NotificationScreen(true),


  ];

  List<String> headerList = [
    'Dashboard',
    'FeedBacks',
    'Rebuttal',
    'Profile'
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.orangeColor,
      child: SafeArea(
        child: Scaffold(
          body:  Stack(
            children: [



              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: bottomTabItems[selectedIndex]),
              Column(
                children: [
                  const Spacer(),
                  Container(
                    height: 100,
                    color: Colors.transparent,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      extendBody: true,
                      bottomNavigationBar: Container(

                        child: BottomAppBar(
                          //bottom navigation bar on scaffold
                          color: Colors.white,
                          shape: const CircularNotchedRectangle(),
                          //shape of notch
                          notchMargin: 5,
                          //notche margin between floating button and bottom appbar
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0),
                            child: Row(
                              //children inside bottom appbar
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(flex :1,child: GestureDetector(
                                  onTap: () {
                                    selectedIndex = 0;
                                    showBoxes = false;
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 5),
                                      Image.asset(
                                          'assets/dashboard.png',
                                          width: 25,
                                          height: 25,
                                          color: selectedIndex == 0
                                              ? AppTheme.blueColor
                                              : AppTheme
                                              .bottomDisabledColor),
                                      const SizedBox(height: 5),
                                      Text('Dashboard',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: selectedIndex ==
                                                  0
                                                  ? AppTheme
                                                  .blueColor
                                                  : AppTheme
                                                  .bottomDisabledColor)),
                                    ],
                                  ),
                                )),
                                Expanded(flex :1,child: GestureDetector(
                                  onTap: () {
                                    selectedIndex = 3;
                                    showBoxes = false;
                                    setState(() {});
                                  },
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 5),
                                      Stack(
                                        children: [
                                          Image.asset(
                                              'assets/feedback.png',
                                              width: 25,
                                              height: 25,
                                              color: selectedIndex == 3
                                                  ? AppTheme.blueColor
                                                  : AppTheme.bottomDisabledColor),



                                        ],
                                      ),

                                      const SizedBox(height: 5),
                                      Text('My Feedback',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: selectedIndex ==
                                                  3
                                                  ? AppTheme.blueColor
                                                  : AppTheme.bottomDisabledColor)),
                                    ],
                                  ),
                                ),),
                                Expanded(flex :1,child: GestureDetector(
                                  onTap: () {
                                    selectedIndex = 2;
                                    showBoxes = true;
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 5),

                                      Stack(
                                        children: [
                                          Image.asset(
                                              'assets/rebuttal.png',
                                              width: 25,
                                              height: 25,
                                              color: selectedIndex == 2
                                                  ? AppTheme.blueColor
                                                  : AppTheme
                                                  .bottomDisabledColor),

                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text('Rebuttal',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: selectedIndex ==
                                                  2
                                                  ? AppTheme
                                                  .blueColor
                                                  : AppTheme
                                                  .bottomDisabledColor)),
                                    ],
                                  ),
                                ),),
                                Expanded(flex :1,child: GestureDetector(
                                  onTap: () {
                                    selectedIndex = 1;
                                    showBoxes = true;
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 5),
                                      Image.asset(
                                          'assets/profile.png',
                                          width: 25,
                                          height: 25,
                                          color: selectedIndex == 1
                                              ? AppTheme.blueColor
                                              : AppTheme
                                              .bottomDisabledColor),
                                      const SizedBox(height: 5),
                                      Text('Profile',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: selectedIndex ==
                                                  1
                                                  ? AppTheme
                                                  .blueColor
                                                  : AppTheme
                                                  .bottomDisabledColor)),
                                    ],
                                  ),
                                ),),
                                // GestureDetector(
                                //   onTap: () {
                                //     selectedIndex = 0;
                                //     showBoxes = false;
                                //     setState(() {});
                                //   },
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       const SizedBox(height: 5),
                                //       Image.asset(
                                //           'assets/dashboard.png',
                                //           width: 25,
                                //           height: 25,
                                //           color: selectedIndex == 0
                                //               ? AppTheme.blueColor
                                //               : AppTheme
                                //               .bottomDisabledColor),
                                //       const SizedBox(height: 5),
                                //       Text('Dashboard',
                                //           style: TextStyle(
                                //               fontSize: 12,
                                //               fontWeight:
                                //               FontWeight.w500,
                                //               color: selectedIndex ==
                                //                   0
                                //                   ? AppTheme
                                //                   .blueColor
                                //                   : AppTheme
                                //                   .bottomDisabledColor)),
                                //     ],
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     selectedIndex = 3;
                                //     setState(() {});
                                //   },
                                //   child: Container(
                                //     margin: const EdgeInsets.only(
                                //         right: 55),
                                //     child: Column(
                                //       mainAxisSize: MainAxisSize.min,
                                //       children: [
                                //         const SizedBox(height: 5),
                                //         Stack(
                                //           children: [
                                //             Image.asset(
                                //                 'assets/feedback.png',
                                //                 width: 25,
                                //                 height: 25,
                                //                 color: selectedIndex == 3
                                //                     ? AppTheme.blueColor
                                //                     : AppTheme.bottomDisabledColor),
                                //
                                //
                                //
                                //           ],
                                //         ),
                                //
                                //         const SizedBox(height: 5),
                                //         Text('My Feedback',
                                //             style: TextStyle(
                                //                 fontSize: 12,
                                //                 fontWeight:
                                //                 FontWeight.w500,
                                //                 color: selectedIndex ==
                                //                     3
                                //                     ? AppTheme.blueColor
                                //                     : AppTheme.bottomDisabledColor)),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                //
                                // GestureDetector(
                                //   onTap: () {
                                //     selectedIndex = 2;
                                //     showBoxes = true;
                                //     setState(() {});
                                //   },
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       SizedBox(height: 5),
                                //
                                //       Stack(
                                //         children: [
                                //           Image.asset(
                                //               'assets/rebuttal.png',
                                //               width: 25,
                                //               height: 25,
                                //               color: selectedIndex == 2
                                //                   ? AppTheme.blueColor
                                //                   : AppTheme
                                //                   .bottomDisabledColor),
                                //
                                //         ],
                                //       ),
                                //       const SizedBox(height: 5),
                                //       Text('Rebuttal',
                                //           style: TextStyle(
                                //               fontSize: 12,
                                //               fontWeight:
                                //               FontWeight.w500,
                                //               color: selectedIndex ==
                                //                   2
                                //                   ? AppTheme
                                //                   .blueColor
                                //                   : AppTheme
                                //                   .bottomDisabledColor)),
                                //     ],
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     selectedIndex = 1;
                                //     showBoxes = true;
                                //     setState(() {});
                                //   },
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       const SizedBox(height: 5),
                                //       Image.asset(
                                //           'assets/profile.png',
                                //           width: 25,
                                //           height: 25,
                                //           color: selectedIndex == 1
                                //               ? AppTheme.blueColor
                                //               : AppTheme
                                //               .bottomDisabledColor),
                                //       const SizedBox(height: 5),
                                //       Text('Profile',
                                //           style: TextStyle(
                                //               fontSize: 12,
                                //               fontWeight:
                                //               FontWeight.w500,
                                //               color: selectedIndex ==
                                //                   1
                                //                   ? AppTheme
                                //                   .blueColor
                                //                   : AppTheme
                                //                   .bottomDisabledColor)),
                                //     ],
                                //   ),
                                // ),

                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       right: 15),
                                //   child:
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // floatingActionButton: SizedBox(
                      //   width: 67,
                      //   height: 67,
                      //   child: FloatingActionButton(
                      //     backgroundColor: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(33.5), // Set the corner radius here
                      //     ),
                      //     onPressed: () {
                      //       selectedIndex = 4;
                      //       setState(() {});
                      //     },
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         const SizedBox(height: 5),
                      //         Image.asset('assets/feedback.png',
                      //             width: 25,
                      //             height: 25,
                      //             color: selectedIndex == 4
                      //                 ? AppTheme.blueColor
                      //                 : AppTheme.bottomDisabledColor),
                      //         const SizedBox(height: 5),
                      //         Text('FeedBack',
                      //             style: TextStyle(
                      //                 fontSize: 7,
                      //                 fontWeight: FontWeight.w500,
                      //                 color: selectedIndex == 4
                      //                     ? AppTheme.blueColor
                      //                     : AppTheme
                      //                     .bottomDisabledColor)),
                      //       ],
                      //     ), //icon inside button
                      //   ),
                      // ),
                      // floatingActionButtonLocation:
                      // FloatingActionButtonLocation.centerDocked,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
}
