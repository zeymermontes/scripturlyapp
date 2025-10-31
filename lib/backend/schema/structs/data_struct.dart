// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataStruct extends FFFirebaseStruct {
  DataStruct({
    String? id,
    String? bibleId,
    String? abbreviation,
    String? name,
    String? nameLong,
    List<ChaptersStruct>? chapters,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _bibleId = bibleId,
        _abbreviation = abbreviation,
        _name = name,
        _nameLong = nameLong,
        _chapters = chapters,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "bibleId" field.
  String? _bibleId;
  String get bibleId => _bibleId ?? '';
  set bibleId(String? val) => _bibleId = val;

  bool hasBibleId() => _bibleId != null;

  // "abbreviation" field.
  String? _abbreviation;
  String get abbreviation => _abbreviation ?? '';
  set abbreviation(String? val) => _abbreviation = val;

  bool hasAbbreviation() => _abbreviation != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "nameLong" field.
  String? _nameLong;
  String get nameLong => _nameLong ?? '';
  set nameLong(String? val) => _nameLong = val;

  bool hasNameLong() => _nameLong != null;

  // "chapters" field.
  List<ChaptersStruct>? _chapters;
  List<ChaptersStruct> get chapters => _chapters ?? const [];
  set chapters(List<ChaptersStruct>? val) => _chapters = val;

  void updateChapters(Function(List<ChaptersStruct>) updateFn) {
    updateFn(_chapters ??= []);
  }

  bool hasChapters() => _chapters != null;

  static DataStruct fromMap(Map<String, dynamic> data) => DataStruct(
        id: data['id'] as String?,
        bibleId: data['bibleId'] as String?,
        abbreviation: data['abbreviation'] as String?,
        name: data['name'] as String?,
        nameLong: data['nameLong'] as String?,
        chapters: getStructList(
          data['chapters'],
          ChaptersStruct.fromMap,
        ),
      );

  static DataStruct? maybeFromMap(dynamic data) =>
      data is Map ? DataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'bibleId': _bibleId,
        'abbreviation': _abbreviation,
        'name': _name,
        'nameLong': _nameLong,
        'chapters': _chapters?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'bibleId': serializeParam(
          _bibleId,
          ParamType.String,
        ),
        'abbreviation': serializeParam(
          _abbreviation,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'nameLong': serializeParam(
          _nameLong,
          ParamType.String,
        ),
        'chapters': serializeParam(
          _chapters,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static DataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        bibleId: deserializeParam(
          data['bibleId'],
          ParamType.String,
          false,
        ),
        abbreviation: deserializeParam(
          data['abbreviation'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        nameLong: deserializeParam(
          data['nameLong'],
          ParamType.String,
          false,
        ),
        chapters: deserializeStructParam<ChaptersStruct>(
          data['chapters'],
          ParamType.DataStruct,
          true,
          structBuilder: ChaptersStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DataStruct &&
        id == other.id &&
        bibleId == other.bibleId &&
        abbreviation == other.abbreviation &&
        name == other.name &&
        nameLong == other.nameLong &&
        listEquality.equals(chapters, other.chapters);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, bibleId, abbreviation, name, nameLong, chapters]);
}

DataStruct createDataStruct({
  String? id,
  String? bibleId,
  String? abbreviation,
  String? name,
  String? nameLong,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataStruct(
      id: id,
      bibleId: bibleId,
      abbreviation: abbreviation,
      name: name,
      nameLong: nameLong,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataStruct? updateDataStruct(
  DataStruct? data, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    data
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataStructData(
  Map<String, dynamic> firestoreData,
  DataStruct? data,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (data == null) {
    return;
  }
  if (data.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && data.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dataData = getDataFirestoreData(data, forFieldValue);
  final nestedData = dataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = data.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataFirestoreData(
  DataStruct? data, [
  bool forFieldValue = false,
]) {
  if (data == null) {
    return {};
  }
  final firestoreData = mapToFirestore(data.toMap());

  // Add any Firestore field values
  data.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDataListFirestoreData(
  List<DataStruct>? datas,
) =>
    datas?.map((e) => getDataFirestoreData(e, true)).toList() ?? [];
