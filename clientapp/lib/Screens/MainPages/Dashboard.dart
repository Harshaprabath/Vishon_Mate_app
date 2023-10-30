import 'package:blind/Screens/Camara/billCamara.dart';
import 'package:blind/Screens/Camara/Navigation.dart';
import 'package:blind/Screens/Camara/SuperMarkets.dart';
import 'package:blind/Screens/Camara/ColorDetector.dart';
import 'package:flutter/material.dart';
import 'package:blind/Screens/Camara/camara.dart';
import 'package:camera/camera.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _recWords = '';
  bool _camOpened = false;
  late FlutterTts flutterTts;


  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        listenMode: ListenMode.search,
        listenFor: const Duration(seconds: 60));
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
  
 

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _recWords = result.recognizedWords;
    });
    print(_recWords);
    if (_recWords.contains('in')) {
      print('contains invoice');
      // final cameras = await availableCameras();
      // final camera = cameras.first;
      // Navigator.of(context).
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BillCameraScreen(),
        ),
      );
      await _speechToText.stop();
      print(Navigator.of(context).widget.runtimeType);
      // return;
    } else if (_recWords.contains('navigation')) {
      print('contains navigation');
      // final cameras = await availableCameras();
      // final camera = cameras.first;
      // Navigator.of(context).
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Navigation(),
        ),
      );
      await _speechToText.stop();
      print(Navigator.of(context).widget.runtimeType);
      // return;
    } else if (_recWords.contains('super')) {
      print('contains supermarket');
      // final cameras = await availableCameras();
      // final camera = cameras.first;
      // Navigator.of(context).
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuperMarket(),
        ),
      );
      await _speechToText.stop();
      print(Navigator.of(context).widget.runtimeType);
      // return;
    } else if (_recWords.contains('detection')) {
      print('contains detection');
      // final cameras = await availableCameras();
      // final camera = cameras.first;
      // Navigator.of(context).
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BillCameraScreen(),
        ),
      );
      await _speechToText.stop();
      print(Navigator.of(context).widget.runtimeType);
      // return;
    }else {
      _startListening();
    }
    //await _speechToText.stop();
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();

     
    
   

    Future.delayed(Duration(milliseconds: 200), () {
     _startListening(); // Call the function mic button click
    });
    
  }



 

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(Colors.white10, Colors.black38),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            MaterialButton(
              onPressed: () async {
                // Open the camera
                final cameras = await availableCameras();
                final camera = cameras.first;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigation(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 75,
                width: 350,
                decoration: const BoxDecoration(
                  color: Color(0xff01ACC2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Navigation Guide',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                // Open the camera
                final cameras = await availableCameras();
                final camera = cameras.first;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuperMarket(),
                  ),
                );
              },
              child: Container(
                height: 75,
                width: 350,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff01ACC2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Row(children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Supermarket Guide',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BillCameraScreen(),
                  ),
                );
              },
              // onPressed: () {
              //   _speechToText.isNotListening
              //       ? _startListening()
              //       : _stopListening();
              // },
              child: Container(
                height: 75,
                width: 350,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff01ACC2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Row(children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image4.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 170,
                    width: 140,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Invoice Guide',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                // Open the camera
                final cameras = await availableCameras();
                final camera = cameras.first;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorDetector(),
                  ),
                );
              },
              child: Container(
                height: 75,
                width: 350,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff01ACC2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image3.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 200,
                      width: 140,
                      alignment: Alignment.center,
                      child: const Text(
                        'Dress Color Guide',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 100,
                width: 350,
                margin: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 90,
                    ),
                    SizedBox(
                      height: 2000,
                      width: 140,
                      // Container 2 content
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(''),
                          SizedBox(
                            width:
                                10000, // Adjust the width to your desired size
                            height:
                                84, // Adjust the height to your desired size
                            child: IconButton(
                              onPressed: () {
                                _speechToText.isNotListening
                                    ? _startListening()
                                    : _stopListening();
                              },
                              icon: Icon(Icons.mic,
                                  color: Color(0xff01ACC2), size: 60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              _speechToText.isListening
                  ? _recWords
                  : _speechEnabled
                      ? 'Tap the microphone to start listening...'
                      : 'Speech not available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
