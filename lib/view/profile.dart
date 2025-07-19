import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qaviews/network/api_dialog.dart';
import 'package:toast/toast.dart';

import '../network/Utils.dart';
import '../network/api_helper.dart';
import '../network/constants.dart';
import '../network/loader.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/input_field_widget.dart';

class ProfileScreen extends StatefulWidget{
  bool showBack;
  ProfileScreen(this.showBack);
  @override
  ProfileState createState() => ProfileState();
}
class ProfileState extends State<ProfileScreen> {
  bool isLoading = false;
  int selectedIndex=0;
  int selectIndex=-1;
  String profileImage="";
  String email="";
  XFile? selectedImage;
  String mobile="";
  var nameController=TextEditingController();

  bool isObscureOld = true;
  bool isObscureConfirm = true;
  bool isObscureNew = true;
  final _formKeyChangePassword = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
              'Profile',
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
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the container
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  width: 80.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Image.network(
                                      profileImage,
                                      width: 80.0,
                                      height: 90.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),

                                onTap: (){
                                  _fetchImage1(context);
                                },

                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                changePasswordSheet();
                              },
                              child: Text(
                                'Change Password?',
                                style: TextStyle(
                                  color: AppTheme.blueColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFieldWidget(labeltext: "Agent Name",controller: nameController),
                          SizedBox(height: 15),
                          DisabledTextFieldWidget(labeltext: "Email",initialText: email),
                          SizedBox(height: 15),
                          DisabledTextFieldWidget(labeltext: "Mobile",initialText: mobile),
                          SizedBox(height: 80),
                          Row(
                            children: [
                              Expanded(child: InkWell(
                                onTap: () {

                                  if(nameController.text=="")
                                  {
                                    Toast.show("Name cannot be empty !",
                                        duration: Toast.lengthLong,
                                        gravity: Toast.bottom,
                                        backgroundColor: Colors.red);
                                  }
                                  else
                                  {
                                    updateProfile();
                                  }


                                },
                                child: Container(
                                    margin:
                                    const EdgeInsets.only(left: 25,right: 25),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppTheme.blueColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 50,
                                    child: const Center(
                                      child: Text('Save',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    )),
                              ),),
                            ],
                          ),

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


  fetchProfileData() async {
    isLoading = true;
    setState(() {});
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id":userId,
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('user_profile', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    nameController.text = responseJSON["data"]["name"];
    email = responseJSON["data"]["email"];
    mobile = responseJSON["data"]["mobile"].toString();
    profileImage = responseJSON["data"]["avatar"];
    setState(() {});
    callapiUrl();
  }


  updateProfile() async {
    APIDialog.showAlertDialog(context,"Updating Profile...");
    setState(() {});
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");
    var requestModel = {
      "user_id":userId,
      "name":nameController.text,
      "email":email,
      "image":profileImage,
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('user_details/update', requestModel, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    if(responseJSON["status"]==1)
    {
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

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }


  _fetchImage1(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image22 = await _picker.pickImage(source: ImageSource.gallery);
    print('Image File From Android' + (image22?.path).toString());
    if (image22 != null) {
      selectedImage=image22;

      uploadImage();

    }
  }


  callapiUrl() async {
    isLoading = true;
    setState(() {});
    var requestModel = {
      "link": profileImage
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    profileImage = responseJSON["public_link"];
    //print('CallUrl:- $callAudioUrl');
    setState(() {});
  }

  uploadImage() async {
    APIDialog.showAlertDialog(context, 'Uploading image...');
    FormData formData = FormData.fromMap({
      "file_upload": await MultipartFile.fromFile(selectedImage!.path),
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

      profileImage=response.data["file_image"];
      setState(() {

      });

    } else {
      Toast.show(response.data['message'].toString(),
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }
  }





  void changePasswordSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKeyChangePassword,
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
                              child: Text('Change Password',
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            obscureText: isObscureOld,
                            controller: currentPasswordController,
                            validator: checkOldPasswordValidator,
                            style: const TextStyle(
                              fontSize: 15.0,
                              height: 1.6,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              /*    contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            0.0, 20.0, 0.0, 10.0),*/
                              suffixIcon: IconButton(
                                icon: isObscureOld
                                    ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                ),
                                onPressed: () {
                                  Future.delayed(Duration.zero, () async {
                                    if (isObscureOld) {
                                      isObscureOld = false;
                                    } else {
                                      isObscureOld = true;
                                    }

                                    setModalState(() {});
                                  });
                                },
                              ),
                              labelText: 'Old Password',
                              labelStyle: const TextStyle(
                                fontSize: 13.5,
                                color: Colors.grey,
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            obscureText: isObscureConfirm,
                            controller: newPasswordController,
                            validator: checkPasswordValidator,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              /*    contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            0.0, 20.0, 0.0, 10.0),*/
                              suffixIcon: IconButton(
                                icon: isObscureConfirm
                                    ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                ),
                                onPressed: () {
                                  Future.delayed(Duration.zero, () async {
                                    if (isObscureConfirm) {
                                      isObscureConfirm = false;
                                    } else {
                                      isObscureConfirm = true;
                                    }

                                    setModalState(() {});
                                  });
                                },
                              ),
                              labelText: 'New Password',
                              labelStyle: const TextStyle(
                                fontSize: 13.5,
                                color: Colors.grey,
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                            obscureText: isObscureNew,
                            controller: confirmPasswordController,
                            validator: checkConfirmPasswordValidator,
                            style: const TextStyle(
                              fontSize: 15.0,
                              height: 1.6,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              /*    contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            0.0, 20.0, 0.0, 10.0),*/
                              suffixIcon: IconButton(
                                icon: isObscureNew
                                    ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: AppTheme.fontLightBlueColor,
                                ),
                                onPressed: () {
                                  Future.delayed(Duration.zero, () async {
                                    if (isObscureNew) {
                                      isObscureNew = false;
                                    } else {
                                      isObscureNew = true;
                                    }

                                    setModalState(() {});
                                  });
                                },
                              ),
                              labelText: 'Re-enter Your New Password',
                              labelStyle: const TextStyle(
                                fontSize: 13.5,
                                color: Colors.grey,
                              ),
                            )),
                      ),










                      const SizedBox(height: 25),
                      Row(
                        children: [

                          const SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () {

                                _submitHandler();
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppTheme.blueColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 46,
                                  child: const Center(
                                    child: Text('Update',
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
                )
              ),
            );
          }),
    );
  }


  String? checkConfirmPasswordValidator(String? value) {
    if (newPasswordController.text.toString()!=value) {
      return "Password and Confirm Password must be same";
    } else {
      return null;
    }
  }

  void _submitHandler() async {
    if (!_formKeyChangePassword.currentState!.validate()) {
      return;
    }
    _formKeyChangePassword.currentState!.save();
    changePassword();
  }


  String? checkPasswordValidator(String? value) {
    if (value!.length<6) {
      return "Password must be of at least 6 digits";
    } else {
      return null;
    }
  }

  String? checkOldPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Old Password cannot be left as empty";
    } else {
      return null;
    }
  }
  changePassword() async {

    APIDialog.showAlertDialog(context, "Changing Password...");
    int? userId=await MyUtils.getSharedPreferencesInt("user_id");

    var requestModel = {
      "id":userId.toString(),
      "password":currentPasswordController.text,
      "password_new":confirmPasswordController.text,
    };
    print(requestModel);
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('reset_password', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);
    if(responseJSON["status"]==1)
    {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);
      Navigator.pop(context);
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

