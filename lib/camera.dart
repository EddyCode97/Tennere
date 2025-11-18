import 'dart:io';
import 'package:bereal_clone/states/post_entry.dart';
import 'package:bereal_clone/states/post_entries_state.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraApp({required this.cameras, super.key});
  static Future<void> openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CameraApp(cameras: cameras),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late CameraDescription _currentCamera;
  XFile? backImage;
  XFile? frontImage;
  XFile? temp;
  // ignore: unused_field
  bool _isInitialized = false;
  bool isCapturing = false;

  @override
  void initState() {
    super.initState();
    _currentCamera = widget.cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.back,
    );
    _initializeCamera(_currentCamera);
  }

  Future<void> _initializeCamera(CameraDescription camera) async {
    _controller = CameraController(camera, ResolutionPreset.high);
    await _controller.initialize();
    setState(() => _isInitialized = true);
  }

  Future<void> _switchCamera() async {
    await _controller.dispose();

    if (_currentCamera.lensDirection == CameraLensDirection.back) {
      _currentCamera = widget.cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
      );
    } else {
      _currentCamera = widget.cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
      );
    }

    await _initializeCamera(_currentCamera);
  }

  Future<void> _takePicture() async {
    if (isCapturing) return;
    if (!_controller.value.isInitialized) return;
    setState(() => isCapturing = true);

    final backCamera = widget.cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.back,
    );
    final frontCamera = widget.cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(backCamera, ResolutionPreset.high);
    await _controller.initialize();
    backImage = await _controller.takePicture();

    await _controller.dispose();
    _controller = CameraController(frontCamera, ResolutionPreset.high);
    await _controller.initialize();
    frontImage = await _controller.takePicture();

    Provider.of<PostEntriesState>(context, listen: false).addPostEntry(new PostEntry(backImage!, frontImage!, DateTime.now()));

    await _controller.dispose();

    setState(() {
      isCapturing = false;
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                Text(
                  "BeReal.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.transparent,
                  size: 36,
                ),
              ],
            ),
            SizedBox(height: 5),
            (backImage != null && frontImage != null)
                ? Stack(
                    children: [
                      Image.file(
                        File(backImage!.path),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        width: 120,
                        height: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                temp = frontImage;
                                frontImage = backImage;
                                backImage = temp;
                              });
                            },
                            child: Image.file(
                              File(frontImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        width: 50,
                        height: 50,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            setState(() {
                              backImage = null;
                              frontImage = null;
                            });
                            _initializeCamera(_currentCamera);
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: _controller.value.isInitialized
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width:
                                        _controller.value.previewSize!.height,
                                    height:
                                        _controller.value.previewSize!.width,
                                    child: CameraPreview(_controller),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.lightbulb_rounded,
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: _takePicture,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cameraswitch,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: _switchCamera,
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
