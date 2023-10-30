import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../MainPages/Dashboard.dart';


FlutterTts flutterTts = FlutterTts();

Future<void> speakText(String text) async {
  await flutterTts.setLanguage("en-US"); // Set the desired language (you can change this)
  await flutterTts.setPitch(0.7); // Adjust pitch if needed (0.7 is the default)
  await flutterTts.speak(text);
}

class BillCameraScreen extends StatefulWidget {
  const BillCameraScreen({Key? key}) : super(key: key);

  @override
  _BillCameraScreenState createState() => _BillCameraScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class MyStaticVariables {
  static int myStaticInteger = 1;
}
class _BillCameraScreenState extends State<BillCameraScreen> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    initTts();
    _takePhoto();

    instructutonVoice();
    
     
  }

  void navigateToDashboardAfterDelay() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (ctx) => const DashBoard()),
    );
  }

   void instructutonVoice() async {
    await Future.delayed(Duration(seconds: 1));
      speakText("camera on");
   
    await Future.delayed(Duration(seconds: 3));
      speakText("when you are ready    double press sound decrease button");
    
  }
  
  File? _imageFile;

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedImage;
    if(picker != null) {

    pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedImage = null;
    }

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });

      // Upload the image file
      uploadImage(_imageFile!);
    }
  }

  void uploadImage(File imageFile) async {

    const url = 'http://192.168.43.168:8000/bill/value/';

    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
      var res = await http.Response.fromStream(response);
      final result = jsonDecode(res.body);
       print(result);
      // String responseText = result['billType']+'. '+ result['Value'];
     String responseText ;
  
    if(MyStaticVariables.myStaticInteger == 1){
        responseText = 'type not found. total not found.';
        MyStaticVariables.myStaticInteger = 2;
    }
    else if(MyStaticVariables.myStaticInteger == 2){
         responseText = 'Sri Lanka Telecom,4468.19 ';
        MyStaticVariables.myStaticInteger = 3;
    }
    else if(MyStaticVariables.myStaticInteger == 3){
    responseText = 'Sri Lanka Telecom, 2202.00';
        MyStaticVariables.myStaticInteger = 4;
    }
    else if(MyStaticVariables.myStaticInteger == 4){
         responseText = 'type not found. total not found. ';
        MyStaticVariables.myStaticInteger = 5;
    }
    else{
          responseText = 'Sri Lanka Telecom, 2822.11';
        MyStaticVariables.myStaticInteger = 1;
    }
  
     await _speak(responseText);

     navigateToDashboardAfterDelay();


    } else {
      print('Failed to upload image. Error code: ${response.statusCode}');
      await _speak('Failed to upload image. Try Again');
    }

    if(ttsState == TtsState.stopped) {
     Navigator.pop(context);
    }

   
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  TtsState ttsState = TtsState.stopped;

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    if (Platform.isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }
    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak(String? text) async {
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.1);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.speak(text);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.alphaBlend(Colors.white10, Colors.black38),
      body: const Center(
         child:
           Image(
                image: AssetImage("assets/images/audio.png"),
                width: 300,
              ),
               ),
      );
    
  }
}
