import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import '../widgets/common.dart';
import 'login_screen.dart';

class ListeningAudioScreen extends StatefulWidget {
  List<dynamic> recordingList;

  ListeningAudioScreen(this.recordingList);

  ListeningState createState() => ListeningState();
}

class ListeningState extends State<ListeningAudioScreen>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  List<String> remarkList = ['All', 'Team Leader', 'QA', 'Partner', 'Client'];
  List<dynamic> recordingList = [];
  int clickedIndex = 0;
  String recordingURL = "";
  int heartIndex = 9999;
  var emailController = TextEditingController();
  var remarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int remarkIndex = 9999;

  bool isLoading = false;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppTheme.blueColor,
        title: const Text(
          'Play Audio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
/*
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/logout.svg',
                width: 25,
                height: 25,
              ),
              onPressed: () {
                _logOut();

              }
          ),
        ],*/
      ),
      body: isLoading
          ? Center(
              child: Loader(),
            )
          : recordingList.length == 0
              ? Center(
                  child: Text("No data found"),
                )
              : Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Display play/pause button and volume/speed sliders.
                          ControlButtons(_player),
                          // Display seek bar. Using StreamBuilder, this widget rebuilds
                          // each time the position, buffered position or duration changes.
                          StreamBuilder<PositionData>(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return SeekBar(
                                duration:
                                    positionData?.duration ?? Duration.zero,
                                position:
                                    positionData?.position ?? Duration.zero,
                                bufferedPosition:
                                    positionData?.bufferedPosition ??
                                        Duration.zero,
                                onChangeEnd: _player.seek,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4,
                            //shadowColor: Colors.green,
                            color: AppTheme.fontLightBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                                height: 45,
                                padding: EdgeInsets.only(
                                    left: 15, right: 5, top: 2, bottom: 2),
                                margin: EdgeInsets.only(right: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      'Filter',
                                      style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 15),
                                    Image.asset(
                                      "assets/filter_ic.png",
                                      width: 22,
                                      height: 22,
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Expanded(
                        child: ListView.builder(
                            itemCount: recordingList.length,
                            itemBuilder: (BuildContext context, int pos) {
                              return Column(
                                children: [
                                  Card(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  recordingList[pos]['call_id'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              clickedIndex == pos
                                                  ? Icon(Icons.pause,
                                                      color: Colors.green,
                                                      size: 30)
                                                  : GestureDetector(
                                                      onTap: () {
                                                        clickedIndex = pos;
                                                        setState(() {});
                                                        getPublicUrl(
                                                            recordingList[pos]
                                                                ['call_link']);
                                                      },
                                                      child: Icon(
                                                          Icons.play_arrow,
                                                          size: 30))
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            recordingList[pos]['call_type'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Spacer(),

                                              /*    heartIndex!=pos?

                            GestureDetector(
                                onTap:(){
                                  setState(() {
                                    heartIndex=pos;
                                  });
                                },

                                child: Icon(Icons.favorite_border,size: 27)):

                            GestureDetector(
                                onTap:(){

                                },

                                child: Icon(Icons.favorite,size: 27,color: Colors.red)),

                            SizedBox(width: 10),
*/
                                              GestureDetector(
                                                  onTap: () {
                                                    selectRemarkDialog(
                                                        recordingList[pos]['id']
                                                            .toString());
                                                  },
                                                  child: Icon(Icons.edit,
                                                      color:
                                                          Color(0xFF818FB4))),
                                              SizedBox(width: 10),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    elevation: 3,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 10)
                                ],
                              );
                            }))
                  ],
                ),
    );
  }

  void selectRemarkDialog(String auditID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                insetPadding: const EdgeInsets.all(10),
                scrollable: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                //this right here
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 42.0,
                          decoration: BoxDecoration(
                              /*  borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0), // Adjust the radius as needed
                              topRight: Radius.circular(16.0), // Adjust the radius as needed
                            ),*/
                              ),
                          child: Container(
                            //  margin: EdgeInsets.only(right: 16,left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remark',
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [Icon(Icons.close)],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          'Send To',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 170,
                          child: ListView.builder(
                              itemCount: remarkList.length,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int pos) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        remarkIndex == pos
                                            ? GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.check_box,
                                                  color: AppTheme
                                                      .fontLightBlueColor,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    remarkIndex = pos;
                                                  });
                                                },
                                                child: Icon(Icons
                                                    .check_box_outline_blank),
                                              ),
                                        SizedBox(width: 11),
                                        Text(
                                          remarkList[pos],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(height: 10),
                        Container(
                          /* decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black45,width: 1)
                          ),*/
                          child: TextFormField(
                              controller: emailController,
                              validator: emailValidator,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF707070),
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.black45, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.black45, width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  //contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10.0, 7.0, 13, 5),
                                  //prefixIcon: fieldIC,
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF707070).withOpacity(0.4),
                                  ))),
                        ),
                        SizedBox(height: 16),
                        Container(
                          /*  decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black45,width: 1)
                          ),*/
                          child: TextFormField(
                              controller: remarkController,
                              validator: remarkValidator,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF707070),
                              ),
                              decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.zero,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.black45, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.black45, width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10.0, 7.0, 13, 5),
                                  //prefixIcon: fieldIC,
                                  hintText: "Remark(Free Text)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF707070).withOpacity(0.4),
                                  ))),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
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
                              _submitHandler(auditID);
                            },
                            child: const Text(
                              'SAVE',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ));
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recordingList = widget.recordingList;

    /* for(int i=0;i<5;i++)
      {
        recordingList.add(widget.recordingList[i]);
      }*/
    ambiguate(WidgetsBinding.instance)!.addObserver(this);

    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    //playAudio("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3");
    getPublicUrl(recordingList[0]['call_link']);
    // Try to load audio from a source and catch any errors.
  }

  playAudio(String url) async {
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  String? remarkValidator(String? value) {
    if (value == "") {
      return 'Remark is required';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Email should be valid Email address.';
    }
    return null;
  }

  void _submitHandler(String auditID) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.pop(context);
    submitRemark(auditID);
  }

  submitRemark(String auditId) async {
    APIDialog.showAlertDialog(context, "Please wait...");
    var requestModel = {
      "check_id": remarkList[remarkIndex],
      "audit_id": auditId,
      "remark": remarkController.text,
      "email": emailController.text
    };

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader(
        'listning_call_feedback', requestModel, context);
    var responseJSON = json.decode(response.body);
    Navigator.pop(context);

    if (responseJSON['status'] == 200) {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);
    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }

    print(responseJSON);
  }

  getPublicUrl(String url) async {
    APIDialog.showAlertDialog(context, "Please wait...");
    setState(() {});
    var requestModel = {"link": url};

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPIWithHeader('publicUrlFile', requestModel, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    recordingURL = responseJSON["public_link"];
    playAudio(recordingURL);
    //print('CallUrl:- $callAudioUrl');
    setState(() {});
  }

  _logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up, color: Colors.white),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 50.0,
                height: 50.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay, color: Colors.white),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
