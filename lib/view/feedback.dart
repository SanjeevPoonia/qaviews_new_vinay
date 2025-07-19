import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toast/toast.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/input_field_widget.dart';

class FeedbackScreen extends StatefulWidget{
 final bool showBack;
 final String auditID;
  FeedbackScreen(this.showBack,this.auditID);
  @override
  FeedbackState createState() => FeedbackState();
}
class FeedbackState extends State<FeedbackScreen> {
  bool isLoading = false;
  int selectedIndex=0;
  var reviewController=TextEditingController();
  int selectIndex=-1;
  int modalIndex=0;
  List<String> statusList=["Accepted"];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.themeColor,

      child: SafeArea(
        child: Scaffold(
          appBar: widget.showBack
              ? AppBar(
            backgroundColor: AppTheme.blueColor,

            title:Text(
              'Feedback',
              style: TextStyle(
                fontSize: 14
              ),
            ),
            centerTitle: true,
          )
              : PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar()),
          backgroundColor: Colors.white,
          extendBody: true,
          body:
          isLoading ?
          Center(
              child: Loader()
          ) :
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),

              Expanded(child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the container
                      ),
                      child: Column(

                        children: [
                          Container(
                            width: screenWidth,
                            child: Center(
                              child:

                                  SizedBox(
                            height: 180,
                            child: Lottie.asset('assets/feedback.json'),
                          ),


                              /*  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Lottie.asset('assets/feedback.json',
                                    height: 300,
                                  ),
                                ],
                              ),*/
                            ),
                          ),
                          TextFieldWidget(labeltext: "Date",initialText: "20-06-2023"),

                          SizedBox(height: 15),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Select Status",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1D2226).withOpacity(0.5)),
                                ),
                              ],
                            )

                            ),

                          InkWell(
                            onTap: (){
                              _modalBottomSheetMenu();
                            },
                            child: Container(
                              height: 45,
                              child: Row(
                                children: [

                                  Text(
                                    statusList[modalIndex],
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
                          SizedBox(height: 10),
                          TextFieldMultilineWidget(labeltext: "Feedback",initialText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",controller: reviewController,),

                          SizedBox(height: 35),


                          InkWell(
                            onTap: () {

                              if(reviewController.text=="")
                                {
                                  Toast.show("Feedback cannot be empty !",
                                      duration: Toast.lengthLong,
                                      gravity: Toast.bottom,
                                      backgroundColor: Colors.red);
                                }
                              else{
                                submitFeedback();
                              }




                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                    color: AppTheme.blueColor,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 48,
                                child: const Center(
                                  child: Text('Submit',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                )),
                          ),

                          SizedBox(height: 20),


                        ],
                      ),

                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }


  void _modalBottomSheetMenu() {
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
                          child: Text('Select Status',
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
                     itemCount: statusList.length,
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
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 15),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                             children: [
                               Text(statusList[pos],
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





  submitFeedback() async {

    APIDialog.showAlertDialog(context, "Accepting...");
    var requestModel = {
      "audit_id":widget.auditID,
      "feedback_status":1,
      "feedback_summery":reviewController.text,
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('audit_list/feedback', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);
    if(responseJSON["message"]=="Success")
    {
      sendFeedbackDialog(context);
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
                        'Feedback Accepted Successfully',
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
                        setState(() {

                        });
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