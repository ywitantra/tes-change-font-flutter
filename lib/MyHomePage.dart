import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_ss_and_fonts_2/styles.dart';

// For handling byte data and typed arrays (e.g., Uint8List)
import 'dart:typed_data';

// For low-level graphics operations, capturing widgets as images, etc.
import 'dart:ui' as ui;

// Flutter's Material Design framework for building UIs
import 'package:flutter/material.dart';

// For rendering widgets and capturing widget subtrees
import 'package:flutter/rendering.dart';

// For sharing content with other apps on the device
import 'package:share_plus/share_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Global Key for taking screenShot
  final GlobalKey globalKey = GlobalKey();

  MyTextStyle mts = MyTextStyle();
  @override
  void initState() {
    super.initState();
  }

  _changeFont(TextStyle t) {
    setState(() {
      mts.setMyFont(t);
    });
    print("change font");
  }

  Future<void> _captureScreenShot(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      // RenderRepaintBoundary boundary = context.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      await Share.shareXFiles(
          [XFile.fromData(pngBytes, mimeType: 'image/png')]);
    } catch(e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            "App",
            style: GoogleFonts.inter(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is my font',
                style: mts.font16,
              ),
              ElevatedButton(
                  onPressed: () {
                    _changeFont(GoogleFonts.aclonica());
                  },
                  child: const Text("Change Font")
              ),
              ElevatedButton(
                  onPressed: () {
                    /// Needed for getting debugPaint
                    /// https://stackoverflow.com/questions/57645037/unable-to-take-screenshot-in-flutter
                    Future.delayed(Duration(seconds: 1), () async {
                      _captureScreenShot(context);
                    });
                  },
                  child: const Text("screenshot")
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _changeFont(),
        //   tooltip: 'Change Font',
        //   child: const Icon(Icons.font_download),
        // ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//
//
//   MyTextStyle mts = MyTextStyle();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   _changeFont(TextStyle t) {
//     setState(() {
//       mts.setMyFont(t);
//     });
//     print("change font");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(
//           "App",
//           style: GoogleFonts.inter(),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'This is my font',
//               style: mts.font16,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   _changeFont(GoogleFonts.aclonica());
//                 },
//                 child: const Text("Change Font")
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   _changeFont(GoogleFonts.aclonica());
//                 },
//                 child: const Text("screenshot")
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _changeFont(),
//       //   tooltip: 'Change Font',
//       //   child: const Icon(Icons.font_download),
//       // ),
//     );
//   }
// }
