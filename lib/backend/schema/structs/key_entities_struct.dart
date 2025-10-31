// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class KeyEntitiesStruct extends FFFirebaseStruct {
  KeyEntitiesStruct({
    String? entity,
    String? role,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _entity = entity,
        _role = role,
        super(firestoreUtilData);

  // "entity" field.
  String? _entity;
  String get entity => _entity ?? '';
  set entity(String? val) => _entity = val;

  bool hasEntity() => _entity != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  static KeyEntitiesStruct fromMap(Map<String, dynamic> data) =>
      KeyEntitiesStruct(
        entity: data['entity'] as String?,
        role: data['role'] as String?,
      );

  static KeyEntitiesStruct? maybeFromMap(dynamic data) => data is Map
      ? KeyEntitiesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'entity': _entity,
        'role': _role,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'entity': serializeParam(
          _entity,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
      }.withoutNulls;

  static KeyEntitiesStruct fromSerializableMap(Map<String, dynamic> data) =>
      KeyEntitiesStruct(
        entity: deserializeParam(
          data['entity'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'KeyEntitiesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is KeyEntitiesStruct &&
        entity == other.entity &&
        role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([entity, role]);
}

KeyEntitiesStruct createKeyEntitiesStruct({
  String? entity,
  String? role,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    KeyEntitiesStruct(
      entity: entity,
      role: role,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

KeyEntitiesStruct? updateKeyEntitiesStruct(
  KeyEntitiesStruct? keyEntities, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    keyEntities
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addKeyEntitiesStructData(
  Map<String, dynamic> firestoreData,
  KeyEntitiesStruct? keyEntities,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (keyEntities == null) {
    return;
  }
  if (keyEntities.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && keyEntities.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final keyEntitiesData =
      getKeyEntitiesFirestoreData(keyEntities, forFieldValue);
  final nestedData =
      keyEntitiesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = keyEntities.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getKeyEntitiesFirestoreData(
  KeyEntitiesStruct? keyEntities, [
  bool forFieldValue = false,
]) {
  if (keyEntities == null) {
    return {};
  }
  final firestoreData = mapToFirestore(keyEntities.toMap());

  // Add any Firestore field values
  keyEntities.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getKeyEntitiesListFirestoreData(
  List<KeyEntitiesStruct>? keyEntitiess,
) =>
    keyEntitiess?.map((e) => getKeyEntitiesFirestoreData(e, true)).toList() ??
    [];
