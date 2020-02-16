import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class MarkAttendanceScreen extends StatefulWidget {
  MarkAttendanceScreen({Key key}) : super(key: key);

  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 1 / 1,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(),
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: AppBorderRadius.medium_all,
              child: CameraMlVision<List<Barcode>>(
                onDispose: () {},
                detector: FirebaseVision.instance.barcodeDetector().detectInImage,
                onResult: (List<Barcode> barcodes) {
                  if (barcodes.isNotEmpty) {
                    print(barcodes.first.displayValue.split(":"));
                  }
                  // Navigator.pop(context, barcodes.first);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
