// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CrossReferencesStruct extends FFFirebaseStruct {
  CrossReferencesStruct({
    String? verse,
    String? reason,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _verse = verse,
        _reason = reason,
        super(firestoreUtilData);

  // "verse" field.
  String? _verse;
  String get verse => _verse ?? '';
  set verse(String? val) => _verse = val;

  bool hasVerse() => _verse != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  set reason(String? val) => _reason = val;

  bool hasReason() => _reason != null;

  static CrossReferencesStruct fromMap(Map<String, dynamic> data) =>
      CrossReferencesStruct(
        verse: data['verse'] as String?,
        reason: data['reason'] as String?,
      );

  static CrossReferencesStruct? maybeFromMap(dynamic data) => data is Map
      ? CrossReferencesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'verse': _verse,
        'reason': _reason,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'verse': serializeParam(
          _verse,
          ParamType.String,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
      }.withoutNulls;

  static CrossReferencesStruct fromSerializableMap(Map<String, dynamic> data) =>
      CrossReferencesStruct(
        verse: deserializeParam(
          data['verse'],
          ParamType.String,
          false,
        ),
        reason: deserializeParam(
          data['reason'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CrossReferencesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CrossReferencesStruct &&
        verse == other.verse &&
        reason == other.reason;
  }

  @override
  int get hashCode => const ListEquality().hash([verse, reason]);
}

CrossReferencesStruct createCrossReferencesStruct({
  String? verse,
  String? reason,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CrossReferencesStruct(
      verse: verse,
      reason: reason,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CrossReferencesStruct? updateCrossReferencesStruct(
  CrossReferencesStruct? crossReferences, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    crossReferences
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCrossReferencesStructData(
  Map<String, dynamic> firestoreData,
  CrossReferencesStruct? crossReferences,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (crossReferences == null) {
    return;
  }
  if (crossReferences.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && crossReferences.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final crossReferencesData =
      getCrossReferencesFirestoreData(crossReferences, forFieldValue);
  final nestedData =
      crossReferencesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = crossReferences.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCrossReferencesFirestoreData(
  CrossReferencesStruct? crossReferences, [
  bool forFieldValue = false,
]) {
  if (crossReferences == null) {
    return {};
  }
  final firestoreData = mapToFirestore(crossReferences.toMap());

  // Add any Firestore field values
  crossReferences.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCrossReferencesListFirestoreData(
  List<CrossReferencesStruct>? crossReferencess,
) =>
    crossReferencess
        ?.map((e) => getCrossReferencesFirestoreData(e, true))
        .toList() ??
    [];
