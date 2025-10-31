// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BooksStruct extends FFFirebaseStruct {
  BooksStruct({
    List<DataStruct>? data,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _data = data,
        super(firestoreUtilData);

  // "data" field.
  List<DataStruct>? _data;
  List<DataStruct> get data => _data ?? const [];
  set data(List<DataStruct>? val) => _data = val;

  void updateData(Function(List<DataStruct>) updateFn) {
    updateFn(_data ??= []);
  }

  bool hasData() => _data != null;

  static BooksStruct fromMap(Map<String, dynamic> data) => BooksStruct(
        data: getStructList(
          data['data'],
          DataStruct.fromMap,
        ),
      );

  static BooksStruct? maybeFromMap(dynamic data) =>
      data is Map ? BooksStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'data': _data?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static BooksStruct fromSerializableMap(Map<String, dynamic> data) =>
      BooksStruct(
        data: deserializeStructParam<DataStruct>(
          data['data'],
          ParamType.DataStruct,
          true,
          structBuilder: DataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'BooksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BooksStruct && listEquality.equals(data, other.data);
  }

  @override
  int get hashCode => const ListEquality().hash([data]);
}

BooksStruct createBooksStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BooksStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BooksStruct? updateBooksStruct(
  BooksStruct? books, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    books
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBooksStructData(
  Map<String, dynamic> firestoreData,
  BooksStruct? books,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (books == null) {
    return;
  }
  if (books.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && books.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final booksData = getBooksFirestoreData(books, forFieldValue);
  final nestedData = booksData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = books.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBooksFirestoreData(
  BooksStruct? books, [
  bool forFieldValue = false,
]) {
  if (books == null) {
    return {};
  }
  final firestoreData = mapToFirestore(books.toMap());

  // Add any Firestore field values
  books.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBooksListFirestoreData(
  List<BooksStruct>? bookss,
) =>
    bookss?.map((e) => getBooksFirestoreData(e, true)).toList() ?? [];
