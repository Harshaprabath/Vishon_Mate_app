import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraFront = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _initCameraController();
  }

  Future<void> _initCameraController() async {
    try {
      await _controller.initialize();
      setState(() {});
    } catch (e) {
      // Handle initialization exception
      print('Error initializing camera: $e');
    }
  }

  void _captureImage() async {
    if (!_controller.value.isTakingPicture) {
      try {
        await _initializeControllerFuture;
        final image = await _controller.takePicture();
        setState(() {
          _capturedImage = image;
        });
      } catch (e) {
        // Handle capture exception
        print('Error capturing image: $e');
      }
    }
  }

  void _toggleCamera() async {
    final cameras = await availableCameras();
    final newCameraIndex = _isCameraFront ? 0 : 1;
    final newCamera = cameras[newCameraIndex];
    setState(() {
      _isCameraFront = !_isCameraFront;
      _controller = CameraController(
        newCamera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _initCameraController();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(Colors.white10, Colors.lightBlue),
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                if (_capturedImage == null)
                  CameraPreview(_controller)
                else
                  Image.file(File(_capturedImage!.path)),
                Align(
                  alignment: Alignment.bottomCenter,
                  
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _toggleCamera,
                          icon: const Icon(Icons.switch_camera, color: Colors.white, size: 45),
                        ),

                      const SizedBox(
                        width: 30,
                      ),

                        ElevatedButton(
                          onPressed: _captureImage,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Icon(Icons.camera, color: Colors.black,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
