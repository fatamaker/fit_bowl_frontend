import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerScreen extends StatelessWidget {
  final GlobalKey modelViewerKey = GlobalKey();

  ModelViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('3D Model Viewer'),
        ),
        body: const ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'assets/Astronaut.glb',
          alt: 'A 3D model of an astronaut',
          ar: true,
          arModes: ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: true,
          iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
          disableZoom: true,
        ));
  }
}
