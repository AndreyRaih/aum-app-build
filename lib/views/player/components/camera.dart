import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PlayerCamera extends StatefulWidget {
  @override
  _PlayerCameraState createState() => _PlayerCameraState();
}

class _PlayerCameraState extends State<PlayerCamera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_Camera(), _CameraTargetAreaMask()],
    );
  }
}

class _Camera extends StatefulWidget {
  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<_Camera> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    if (cameras == null || cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        cameras[1],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return RotatedBox(
      quarterTurns: -1,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }
}

class _CameraTargetAreaMask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.black38, BlendMode.srcOut),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: size.height - 50,
                width: size.width - 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
