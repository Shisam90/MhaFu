import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'steps_tracker_model.dart';
export 'steps_tracker_model.dart';

class StepsTrackerWidget extends StatefulWidget {
  const StepsTrackerWidget({Key? key}) : super(key: key);

  @override
  _StepsTrackerWidgetState createState() => _StepsTrackerWidgetState();
}

class _StepsTrackerWidgetState extends State<StepsTrackerWidget> {
  late StepsTrackerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  int _stepCount = 0;
  bool _isStepCounting = false;

  DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepsTrackerModel());

    // Start listening to accelerometer events
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the magnitude of the acceleration vector
      double acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      // Check if acceleration magnitude is above a certain threshold
      if (acceleration > 10 && !_isStepCounting) {
        setState(() {
          _isStepCounting = true;
        });
      } else if (acceleration < 10 && _isStepCounting) {
        setState(() {
          _stepCount++;
          _isStepCounting = false;
        });
      }

      // Check if 24 hours have passed since the start time
      checkResetTimer();
    });
  }

  void checkResetTimer() {
    DateTime currentTime = DateTime.now();
    if (currentTime.difference(_startTime).inHours >= 24) {
      setState(() {
        _stepCount = 0;
        _startTime = currentTime;
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'DAILY STEPS',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Rubik',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 14.0,
                          letterSpacing: 1.0,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(48.0, 8.0, 48.0, 0.0),
                    child: Text(
                      'You have walked',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Rubik',
                            fontSize: 24.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        CircularPercentIndicator(
                          percent: 0.8,
                          radius: 90.0,
                          lineWidth: 12.0,
                          animation: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor: Color(0x00F1F4F8),
                          startAngle: 216.0,
                        ),
                        CircularPercentIndicator(
                          percent: 0.7,
                          radius: 72.0,
                          lineWidth: 2.0,
                          animation: true,
                          progressColor: Color(0xFFE9E9E9),
                          backgroundColor: Colors.transparent,
                          startAngle: 232.0,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.apiResulttsz = await GoogleFitCall.call();
                            if ((_model.apiResulttsz?.succeeded ?? true)) {
                              final userUpdateData = createUserRecordData();
                              await currentUserReference!
                                  .update(userUpdateData);
                            }

                            setState(() {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SvgPicture.asset(
                                'assets/images/step.svg',
                                width: 36.0,
                                height: 36.0,
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  '$_stepCount',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        fontSize: 24.0,
                                      ),
                                ),
                              ),
                              Text(
                                'steps',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: Color(0xFF828282),
                                      fontSize: 12.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 36.0, 24.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          CircularPercentIndicator(
                            percent: 0.5,
                            radius: 30.0,
                            lineWidth: 8.0,
                            animation: true,
                            progressColor: Color(0xFF7EE4F0),
                            backgroundColor: Color(0x4D7EE4F0),
                          ),
                          SvgPicture.asset(
                            'assets/images/trending.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          '310 kcal',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Rubik',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            CircularPercentIndicator(
                              percent: 0.5,
                              radius: 30.0,
                              lineWidth: 8.0,
                              animation: true,
                              progressColor: Color(0xFF7165E3),
                              backgroundColor: Color(0x4D8B80F8),
                            ),
                            SvgPicture.asset(
                              'assets/images/Location.svg',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          '4 km',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Rubik',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          CircularPercentIndicator(
                            percent: 0.5,
                            radius: 30.0,
                            lineWidth: 8.0,
                            animation: true,
                            progressColor: Color(0xFF1E87FD),
                            backgroundColor: Color(0x4D1E87FD),
                          ),
                          SvgPicture.asset(
                            'assets/images/stopwatch.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          '32 min',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Rubik',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
