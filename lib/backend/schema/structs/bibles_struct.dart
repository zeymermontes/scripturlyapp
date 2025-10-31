// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BiblesStruct extends FFFirebaseStruct {
  BiblesStruct({
    String? bibleID,
    String? bibleAcronim,
    Languages? language,
    String? bibleName,
    String? description,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _bibleID = bibleID,
        _bibleAcronim = bibleAcronim,
        _language = language,
        _bibleName = bibleName,
        _description = description,
        super(firestoreUtilData);

  // "bibleID" field.
  String? _bibleID;
  String get bibleID => _bibleID ?? '';
  set bibleID(String? val) => _bibleID = val;

  bool hasBibleID() => _bibleID != null;

  // "bibleAcronim" field.
  String? _bibleAcronim;
  String get bibleAcronim => _bibleAcronim ?? '';
  set bibleAcronim(String? val) => _bibleAcronim = val;

  bool hasBibleAcronim() => _bibleAcronim != null;

  // "language" field.
  Languages? _language;
  Languages? get language => _language;
  set language(Languages? val) => _language = val;

  bool hasLanguage() => _language != null;

  // "bibleName" field.
  String? _bibleName;
  String get bibleName => _bibleName ?? '';
  set bibleName(String? val) => _bibleName = val;

  bool hasBibleName() => _bibleName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  static BiblesStruct fromMap(Map<String, dynamic> data) => BiblesStruct(
        bibleID: data['bibleID'] as String?,
        bibleAcronim: data['bibleAcronim'] as String?,
        language: data['language'] is Languages
            ? data['language']
            : deserializeEnum<Languages>(data['language']),
        bibleName: data['bibleName'] as String?,
        description: data['description'] as String?,
      );

  static BiblesStruct? maybeFromMap(dynamic data) =>
      data is Map ? BiblesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'bibleID': _bibleID,
        'bibleAcronim': _bibleAcronim,
        'language': _language?.serialize(),
        'bibleName': _bibleName,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'bibleID': serializeParam(
          _bibleID,
          ParamType.String,
        ),
        'bibleAcronim': serializeParam(
          _bibleAcronim,
          ParamType.String,
        ),
        'language': serializeParam(
          _language,
          ParamType.Enum,
        ),
        'bibleName': serializeParam(
          _bibleName,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static BiblesStruct fromSerializableMap(Map<String, dynamic> data) =>
      BiblesStruct(
        bibleID: deserializeParam(
          data['bibleID'],
          ParamType.String,
          false,
        ),
        bibleAcronim: deserializeParam(
          data['bibleAcronim'],
          ParamType.String,
          false,
        ),
        language: deserializeParam<Languages>(
          data['language'],
          ParamType.Enum,
          false,
        ),
        bibleName: deserializeParam(
          data['bibleName'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BiblesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BiblesStruct &&
        bibleID == other.bibleID &&
        bibleAcronim == other.bibleAcronim &&
        language == other.language &&
        bibleName == other.bibleName &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([bibleID, bibleAcronim, language, bibleName, description]);
}

BiblesStruct createBiblesStruct({
  String? bibleID,
  String? bibleAcronim,
  Languages? language,
  String? bibleName,
  String? description,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BiblesStruct(
      bibleID: bibleID,
      bibleAcronim: bibleAcronim,
      language: language,
      bibleName: bibleName,
      description: description,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BiblesStruct? updateBiblesStruct(
  BiblesStruct? bibles, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bibles
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBiblesStructData(
  Map<String, dynamic> firestoreData,
  BiblesStruct? bibles,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bibles == null) {
    return;
  }
  if (bibles.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bibles.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final biblesData = getBiblesFirestoreData(bibles, forFieldValue);
  final nestedData = biblesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = bibles.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBiblesFirestoreData(
  BiblesStruct? bibles, [
  bool forFieldValue = false,
]) {
  if (bibles == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bibles.toMap());

  // Add any Firestore field values
  bibles.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBiblesListFirestoreData(
  List<BiblesStruct>? bibless,
) =>
    bibless?.map((e) => getBiblesFirestoreData(e, true)).toList() ?? [];
