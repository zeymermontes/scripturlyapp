// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserProfileStruct extends FFFirebaseStruct {
  UserProfileStruct({
    String? spiritualMaturity,
    List<String>? currentStruggles,
    List<String>? goals,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _spiritualMaturity = spiritualMaturity,
        _currentStruggles = currentStruggles,
        _goals = goals,
        super(firestoreUtilData);

  // "spiritual_maturity" field.
  String? _spiritualMaturity;
  String get spiritualMaturity => _spiritualMaturity ?? '';
  set spiritualMaturity(String? val) => _spiritualMaturity = val;

  bool hasSpiritualMaturity() => _spiritualMaturity != null;

  // "current_struggles" field.
  List<String>? _currentStruggles;
  List<String> get currentStruggles => _currentStruggles ?? const [];
  set currentStruggles(List<String>? val) => _currentStruggles = val;

  void updateCurrentStruggles(Function(List<String>) updateFn) {
    updateFn(_currentStruggles ??= []);
  }

  bool hasCurrentStruggles() => _currentStruggles != null;

  // "goals" field.
  List<String>? _goals;
  List<String> get goals => _goals ?? const [];
  set goals(List<String>? val) => _goals = val;

  void updateGoals(Function(List<String>) updateFn) {
    updateFn(_goals ??= []);
  }

  bool hasGoals() => _goals != null;

  static UserProfileStruct fromMap(Map<String, dynamic> data) =>
      UserProfileStruct(
        spiritualMaturity: data['spiritual_maturity'] as String?,
        currentStruggles: getDataList(data['current_struggles']),
        goals: getDataList(data['goals']),
      );

  static UserProfileStruct? maybeFromMap(dynamic data) => data is Map
      ? UserProfileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'spiritual_maturity': _spiritualMaturity,
        'current_struggles': _currentStruggles,
        'goals': _goals,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'spiritual_maturity': serializeParam(
          _spiritualMaturity,
          ParamType.String,
        ),
        'current_struggles': serializeParam(
          _currentStruggles,
          ParamType.String,
          isList: true,
        ),
        'goals': serializeParam(
          _goals,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static UserProfileStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserProfileStruct(
        spiritualMaturity: deserializeParam(
          data['spiritual_maturity'],
          ParamType.String,
          false,
        ),
        currentStruggles: deserializeParam<String>(
          data['current_struggles'],
          ParamType.String,
          true,
        ),
        goals: deserializeParam<String>(
          data['goals'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'UserProfileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserProfileStruct &&
        spiritualMaturity == other.spiritualMaturity &&
        listEquality.equals(currentStruggles, other.currentStruggles) &&
        listEquality.equals(goals, other.goals);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([spiritualMaturity, currentStruggles, goals]);
}

UserProfileStruct createUserProfileStruct({
  String? spiritualMaturity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserProfileStruct(
      spiritualMaturity: spiritualMaturity,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserProfileStruct? updateUserProfileStruct(
  UserProfileStruct? userProfile, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userProfile
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserProfileStructData(
  Map<String, dynamic> firestoreData,
  UserProfileStruct? userProfile,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userProfile == null) {
    return;
  }
  if (userProfile.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userProfile.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userProfileData =
      getUserProfileFirestoreData(userProfile, forFieldValue);
  final nestedData =
      userProfileData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userProfile.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserProfileFirestoreData(
  UserProfileStruct? userProfile, [
  bool forFieldValue = false,
]) {
  if (userProfile == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userProfile.toMap());

  // Add any Firestore field values
  userProfile.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserProfileListFirestoreData(
  List<UserProfileStruct>? userProfiles,
) =>
    userProfiles?.map((e) => getUserProfileFirestoreData(e, true)).toList() ??
    [];
