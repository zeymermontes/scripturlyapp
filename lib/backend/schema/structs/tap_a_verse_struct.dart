// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TapAVerseStruct extends FFFirebaseStruct {
  TapAVerseStruct({
    FinalOutputStruct? finalOutput,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _finalOutput = finalOutput,
        super(firestoreUtilData);

  // "finalOutput" field.
  FinalOutputStruct? _finalOutput;
  FinalOutputStruct get finalOutput => _finalOutput ?? FinalOutputStruct();
  set finalOutput(FinalOutputStruct? val) => _finalOutput = val;

  void updateFinalOutput(Function(FinalOutputStruct) updateFn) {
    updateFn(_finalOutput ??= FinalOutputStruct());
  }

  bool hasFinalOutput() => _finalOutput != null;

  static TapAVerseStruct fromMap(Map<String, dynamic> data) => TapAVerseStruct(
        finalOutput: data['finalOutput'] is FinalOutputStruct
            ? data['finalOutput']
            : FinalOutputStruct.maybeFromMap(data['finalOutput']),
      );

  static TapAVerseStruct? maybeFromMap(dynamic data) => data is Map
      ? TapAVerseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'finalOutput': _finalOutput?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'finalOutput': serializeParam(
          _finalOutput,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static TapAVerseStruct fromSerializableMap(Map<String, dynamic> data) =>
      TapAVerseStruct(
        finalOutput: deserializeStructParam(
          data['finalOutput'],
          ParamType.DataStruct,
          false,
          structBuilder: FinalOutputStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TapAVerseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TapAVerseStruct && finalOutput == other.finalOutput;
  }

  @override
  int get hashCode => const ListEquality().hash([finalOutput]);
}

TapAVerseStruct createTapAVerseStruct({
  FinalOutputStruct? finalOutput,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TapAVerseStruct(
      finalOutput:
          finalOutput ?? (clearUnsetFields ? FinalOutputStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TapAVerseStruct? updateTapAVerseStruct(
  TapAVerseStruct? tapAVerse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tapAVerse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTapAVerseStructData(
  Map<String, dynamic> firestoreData,
  TapAVerseStruct? tapAVerse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tapAVerse == null) {
    return;
  }
  if (tapAVerse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tapAVerse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tapAVerseData = getTapAVerseFirestoreData(tapAVerse, forFieldValue);
  final nestedData = tapAVerseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tapAVerse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTapAVerseFirestoreData(
  TapAVerseStruct? tapAVerse, [
  bool forFieldValue = false,
]) {
  if (tapAVerse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tapAVerse.toMap());

  // Handle nested data for "finalOutput" field.
  addFinalOutputStructData(
    firestoreData,
    tapAVerse.hasFinalOutput() ? tapAVerse.finalOutput : null,
    'finalOutput',
    forFieldValue,
  );

  // Add any Firestore field values
  tapAVerse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTapAVerseListFirestoreData(
  List<TapAVerseStruct>? tapAVerses,
) =>
    tapAVerses?.map((e) => getTapAVerseFirestoreData(e, true)).toList() ?? [];
