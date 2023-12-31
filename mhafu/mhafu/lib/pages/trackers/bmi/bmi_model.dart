import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BmiModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for BMI_H widget.
  TextEditingController? bmiHController;
  String? Function(BuildContext, String?)? bmiHControllerValidator;
  // State field(s) for BMI_W widget.
  TextEditingController? bmiWController;
  String? Function(BuildContext, String?)? bmiWControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    bmiHController?.dispose();
    bmiWController?.dispose();
  }

  /// Additional helper methods are added here.

}
