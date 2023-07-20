import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? bmi(
  double? weight,
  double? height,
) {
  // code to calculate bmi using height and weight
  double bmi = weight! / math.pow(height! / 100, 2);
  return bmi.toStringAsFixed(2);
}

String? bmiStatement(
  double? weight,
  double? height,
) {
  // code to calculate bmi using height and weight
  double bmi = weight! / math.pow(height! / 100, 2);
  String bmiResult = bmi.toStringAsFixed(1);
  if (bmi < 18.5) {
    return 'You are underweight.';
  } else if (bmi < 25) {
    return 'Your BMI is in the normal range.';
  } else if (bmi < 30) {
    return 'You are overweight.';
  } else {
    return 'You are obese.';
  }
}
