// import 'package:flutter/material.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';

// class ModelViewerScreen extends StatelessWidget {
//   final GlobalKey modelViewerKey = GlobalKey();

//   ModelViewerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Model Viewer')),
//         body: const ModelViewer(
//           backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
//           src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
//           alt: 'A 3D model of an astronaut',
//           ar: true,
//           autoRotate: true,
//           iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
//           disableZoom: true,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerScreen extends StatelessWidget {
  final String? modelUrl;

  const ModelViewerScreen({super.key, required this.modelUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Model Viewer'),
        backgroundColor: Colors.green,
      ),
      body: ModelViewer(
        backgroundColor: const Color(0xFFEEEEEE),
        src: modelUrl!,
        alt: '3D model',
        ar: true,
        autoRotate: true,
        iosSrc: modelUrl, // Ensure compatibility for iOS
        disableZoom: false,
      ),
    );
  }
}
