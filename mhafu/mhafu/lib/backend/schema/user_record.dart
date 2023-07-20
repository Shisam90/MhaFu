import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "Weight_intake" field.
  int? _weightIntake;
  int get weightIntake => _weightIntake ?? 0;
  bool hasWeightIntake() => _weightIntake != null;

  // "Height_intake" field.
  int? _heightIntake;
  int get heightIntake => _heightIntake ?? 0;
  bool hasHeightIntake() => _heightIntake != null;

  // "Goal_Weight" field.
  int? _goalWeight;
  int get goalWeight => _goalWeight ?? 0;
  bool hasGoalWeight() => _goalWeight != null;

  // "Goal_Water" field.
  int? _goalWater;
  int get goalWater => _goalWater ?? 0;
  bool hasGoalWater() => _goalWater != null;

  // "water_intake" field.
  int? _waterIntake;
  int get waterIntake => _waterIntake ?? 0;
  bool hasWaterIntake() => _waterIntake != null;

  // "BMI_W" field.
  double? _bmiW;
  double get bmiW => _bmiW ?? 0.0;
  bool hasBmiW() => _bmiW != null;

  // "BMI_H" field.
  double? _bmiH;
  double get bmiH => _bmiH ?? 0.0;
  bool hasBmiH() => _bmiH != null;

  // "Steps_taken" field.
  int? _stepsTaken;
  int get stepsTaken => _stepsTaken ?? 0;
  bool hasStepsTaken() => _stepsTaken != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _weightIntake = snapshotData['Weight_intake'] as int?;
    _heightIntake = snapshotData['Height_intake'] as int?;
    _goalWeight = snapshotData['Goal_Weight'] as int?;
    _goalWater = snapshotData['Goal_Water'] as int?;
    _waterIntake = snapshotData['water_intake'] as int?;
    _bmiW = castToType<double>(snapshotData['BMI_W']);
    _bmiH = castToType<double>(snapshotData['BMI_H']);
    _stepsTaken = snapshotData['Steps_taken'] as int?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  DateTime? createdTime,
  int? weightIntake,
  int? heightIntake,
  int? goalWeight,
  int? goalWater,
  int? waterIntake,
  double? bmiW,
  double? bmiH,
  int? stepsTaken,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'created_time': createdTime,
      'Weight_intake': weightIntake,
      'Height_intake': heightIntake,
      'Goal_Weight': goalWeight,
      'Goal_Water': goalWater,
      'water_intake': waterIntake,
      'BMI_W': bmiW,
      'BMI_H': bmiH,
      'Steps_taken': stepsTaken,
    }.withoutNulls,
  );

  return firestoreData;
}
