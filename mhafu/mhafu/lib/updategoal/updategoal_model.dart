import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdategoalModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for weight widget.
  TextEditingController? weightController;
  String? Function(BuildContext, String?)? weightControllerValidator;
  // State field(s) for water widget.
  TextEditingController? waterController;
  String? Function(BuildContext, String?)? waterControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    weightController?.dispose();
    waterController?.dispose();
  }

  /// Additional helper methods are added here.

}
