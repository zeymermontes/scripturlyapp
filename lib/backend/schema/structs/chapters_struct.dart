// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ChaptersStruct extends FFFirebaseStruct {
  ChaptersStruct({
    String? id,
    String? bibleId,
    String? bookId,
    String? number,
    int? position,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _bibleId = bibleId,
        _bookId = bookId,
        _number = number,
        _position = position,
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

  // "bookId" field.
  String? _bookId;
  String get bookId => _bookId ?? '';
  set bookId(String? val) => _bookId = val;

  bool hasBookId() => _bookId != null;

  // "number" field.
  String? _number;
  String get number => _number ?? '';
  set number(String? val) => _number = val;

  bool hasNumber() => _number != null;

  // "position" field.
  int? _position;
  int get position => _position ?? 0;
  set position(int? val) => _position = val;

  void incrementPosition(int amount) => position = position + amount;

  bool hasPosition() => _position != null;

  static ChaptersStruct fromMap(Map<String, dynamic> data) => ChaptersStruct(
        id: data['id'] as String?,
        bibleId: data['bibleId'] as String?,
        bookId: data['bookId'] as String?,
        number: data['number'] as String?,
        position: castToType<int>(data['position']),
      );

  static ChaptersStruct? maybeFromMap(dynamic data) =>
      data is Map ? ChaptersStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'bibleId': _bibleId,
        'bookId': _bookId,
        'number': _number,
        'position': _position,
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
        'bookId': serializeParam(
          _bookId,
          ParamType.String,
        ),
        'number': serializeParam(
          _number,
          ParamType.String,
        ),
        'position': serializeParam(
          _position,
          ParamType.int,
        ),
      }.withoutNulls;

  static ChaptersStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChaptersStruct(
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
        bookId: deserializeParam(
          data['bookId'],
          ParamType.String,
          false,
        ),
        number: deserializeParam(
          data['number'],
          ParamType.String,
          false,
        ),
        position: deserializeParam(
          data['position'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ChaptersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChaptersStruct &&
        id == other.id &&
        bibleId == other.bibleId &&
        bookId == other.bookId &&
        number == other.number &&
        position == other.position;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, bibleId, bookId, number, position]);
}

ChaptersStruct createChaptersStruct({
  String? id,
  String? bibleId,
  String? bookId,
  String? number,
  int? position,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChaptersStruct(
      id: id,
      bibleId: bibleId,
      bookId: bookId,
      number: number,
      position: position,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChaptersStruct? updateChaptersStruct(
  ChaptersStruct? chapters, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chapters
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChaptersStructData(
  Map<String, dynamic> firestoreData,
  ChaptersStruct? chapters,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chapters == null) {
    return;
  }
  if (chapters.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chapters.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chaptersData = getChaptersFirestoreData(chapters, forFieldValue);
  final nestedData = chaptersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chapters.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChaptersFirestoreData(
  ChaptersStruct? chapters, [
  bool forFieldValue = false,
]) {
  if (chapters == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chapters.toMap());

  // Add any Firestore field values
  chapters.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChaptersListFirestoreData(
  List<ChaptersStruct>? chapterss,
) =>
    chapterss?.map((e) => getChaptersFirestoreData(e, true)).toList() ?? [];
