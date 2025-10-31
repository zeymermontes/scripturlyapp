// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FinalOutputStruct extends FFFirebaseStruct {
  FinalOutputStruct({
    String? explanationText,
    List<String>? sources,
    List<KeyEntitiesStruct>? keyEntities,
    List<CrossReferencesStruct>? crossReferences,
    Role? role,
    String? responseText,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _explanationText = explanationText,
        _sources = sources,
        _keyEntities = keyEntities,
        _crossReferences = crossReferences,
        _role = role,
        _responseText = responseText,
        super(firestoreUtilData);

  // "explanation_text" field.
  String? _explanationText;
  String get explanationText => _explanationText ?? '';
  set explanationText(String? val) => _explanationText = val;

  bool hasExplanationText() => _explanationText != null;

  // "sources" field.
  List<String>? _sources;
  List<String> get sources => _sources ?? const [];
  set sources(List<String>? val) => _sources = val;

  void updateSources(Function(List<String>) updateFn) {
    updateFn(_sources ??= []);
  }

  bool hasSources() => _sources != null;

  // "key_entities" field.
  List<KeyEntitiesStruct>? _keyEntities;
  List<KeyEntitiesStruct> get keyEntities => _keyEntities ?? const [];
  set keyEntities(List<KeyEntitiesStruct>? val) => _keyEntities = val;

  void updateKeyEntities(Function(List<KeyEntitiesStruct>) updateFn) {
    updateFn(_keyEntities ??= []);
  }

  bool hasKeyEntities() => _keyEntities != null;

  // "cross_references" field.
  List<CrossReferencesStruct>? _crossReferences;
  List<CrossReferencesStruct> get crossReferences =>
      _crossReferences ?? const [];
  set crossReferences(List<CrossReferencesStruct>? val) =>
      _crossReferences = val;

  void updateCrossReferences(Function(List<CrossReferencesStruct>) updateFn) {
    updateFn(_crossReferences ??= []);
  }

  bool hasCrossReferences() => _crossReferences != null;

  // "role" field.
  Role? _role;
  Role? get role => _role;
  set role(Role? val) => _role = val;

  bool hasRole() => _role != null;

  // "response_text" field.
  String? _responseText;
  String get responseText => _responseText ?? '';
  set responseText(String? val) => _responseText = val;

  bool hasResponseText() => _responseText != null;

  static FinalOutputStruct fromMap(Map<String, dynamic> data) =>
      FinalOutputStruct(
        explanationText: data['explanation_text'] as String?,
        sources: getDataList(data['sources']),
        keyEntities: getStructList(
          data['key_entities'],
          KeyEntitiesStruct.fromMap,
        ),
        crossReferences: getStructList(
          data['cross_references'],
          CrossReferencesStruct.fromMap,
        ),
        role: data['role'] is Role
            ? data['role']
            : deserializeEnum<Role>(data['role']),
        responseText: data['response_text'] as String?,
      );

  static FinalOutputStruct? maybeFromMap(dynamic data) => data is Map
      ? FinalOutputStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'explanation_text': _explanationText,
        'sources': _sources,
        'key_entities': _keyEntities?.map((e) => e.toMap()).toList(),
        'cross_references': _crossReferences?.map((e) => e.toMap()).toList(),
        'role': _role?.serialize(),
        'response_text': _responseText,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'explanation_text': serializeParam(
          _explanationText,
          ParamType.String,
        ),
        'sources': serializeParam(
          _sources,
          ParamType.String,
          isList: true,
        ),
        'key_entities': serializeParam(
          _keyEntities,
          ParamType.DataStruct,
          isList: true,
        ),
        'cross_references': serializeParam(
          _crossReferences,
          ParamType.DataStruct,
          isList: true,
        ),
        'role': serializeParam(
          _role,
          ParamType.Enum,
        ),
        'response_text': serializeParam(
          _responseText,
          ParamType.String,
        ),
      }.withoutNulls;

  static FinalOutputStruct fromSerializableMap(Map<String, dynamic> data) =>
      FinalOutputStruct(
        explanationText: deserializeParam(
          data['explanation_text'],
          ParamType.String,
          false,
        ),
        sources: deserializeParam<String>(
          data['sources'],
          ParamType.String,
          true,
        ),
        keyEntities: deserializeStructParam<KeyEntitiesStruct>(
          data['key_entities'],
          ParamType.DataStruct,
          true,
          structBuilder: KeyEntitiesStruct.fromSerializableMap,
        ),
        crossReferences: deserializeStructParam<CrossReferencesStruct>(
          data['cross_references'],
          ParamType.DataStruct,
          true,
          structBuilder: CrossReferencesStruct.fromSerializableMap,
        ),
        role: deserializeParam<Role>(
          data['role'],
          ParamType.Enum,
          false,
        ),
        responseText: deserializeParam(
          data['response_text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FinalOutputStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FinalOutputStruct &&
        explanationText == other.explanationText &&
        listEquality.equals(sources, other.sources) &&
        listEquality.equals(keyEntities, other.keyEntities) &&
        listEquality.equals(crossReferences, other.crossReferences) &&
        role == other.role &&
        responseText == other.responseText;
  }

  @override
  int get hashCode => const ListEquality().hash([
        explanationText,
        sources,
        keyEntities,
        crossReferences,
        role,
        responseText
      ]);
}

FinalOutputStruct createFinalOutputStruct({
  String? explanationText,
  Role? role,
  String? responseText,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FinalOutputStruct(
      explanationText: explanationText,
      role: role,
      responseText: responseText,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FinalOutputStruct? updateFinalOutputStruct(
  FinalOutputStruct? finalOutput, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    finalOutput
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFinalOutputStructData(
  Map<String, dynamic> firestoreData,
  FinalOutputStruct? finalOutput,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (finalOutput == null) {
    return;
  }
  if (finalOutput.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && finalOutput.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final finalOutputData =
      getFinalOutputFirestoreData(finalOutput, forFieldValue);
  final nestedData =
      finalOutputData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = finalOutput.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFinalOutputFirestoreData(
  FinalOutputStruct? finalOutput, [
  bool forFieldValue = false,
]) {
  if (finalOutput == null) {
    return {};
  }
  final firestoreData = mapToFirestore(finalOutput.toMap());

  // Add any Firestore field values
  finalOutput.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFinalOutputListFirestoreData(
  List<FinalOutputStruct>? finalOutputs,
) =>
    finalOutputs?.map((e) => getFinalOutputFirestoreData(e, true)).toList() ??
    [];
