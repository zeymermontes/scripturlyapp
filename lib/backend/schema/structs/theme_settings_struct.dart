// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ThemeSettingsStruct extends FFFirebaseStruct {
  ThemeSettingsStruct({
    double? size,
    String? font,
    String? theme,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _size = size,
        _font = font,
        _theme = theme,
        super(firestoreUtilData);

  // "size" field.
  double? _size;
  double get size => _size ?? 0.0;
  set size(double? val) => _size = val;

  void incrementSize(double amount) => size = size + amount;

  bool hasSize() => _size != null;

  // "font" field.
  String? _font;
  String get font => _font ?? '';
  set font(String? val) => _font = val;

  bool hasFont() => _font != null;

  // "theme" field.
  String? _theme;
  String get theme => _theme ?? '';
  set theme(String? val) => _theme = val;

  bool hasTheme() => _theme != null;

  static ThemeSettingsStruct fromMap(Map<String, dynamic> data) =>
      ThemeSettingsStruct(
        size: castToType<double>(data['size']),
        font: data['font'] as String?,
        theme: data['theme'] as String?,
      );

  static ThemeSettingsStruct? maybeFromMap(dynamic data) => data is Map
      ? ThemeSettingsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'size': _size,
        'font': _font,
        'theme': _theme,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'size': serializeParam(
          _size,
          ParamType.double,
        ),
        'font': serializeParam(
          _font,
          ParamType.String,
        ),
        'theme': serializeParam(
          _theme,
          ParamType.String,
        ),
      }.withoutNulls;

  static ThemeSettingsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ThemeSettingsStruct(
        size: deserializeParam(
          data['size'],
          ParamType.double,
          false,
        ),
        font: deserializeParam(
          data['font'],
          ParamType.String,
          false,
        ),
        theme: deserializeParam(
          data['theme'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ThemeSettingsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ThemeSettingsStruct &&
        size == other.size &&
        font == other.font &&
        theme == other.theme;
  }

  @override
  int get hashCode => const ListEquality().hash([size, font, theme]);
}

ThemeSettingsStruct createThemeSettingsStruct({
  double? size,
  String? font,
  String? theme,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ThemeSettingsStruct(
      size: size,
      font: font,
      theme: theme,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ThemeSettingsStruct? updateThemeSettingsStruct(
  ThemeSettingsStruct? themeSettings, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    themeSettings
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addThemeSettingsStructData(
  Map<String, dynamic> firestoreData,
  ThemeSettingsStruct? themeSettings,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (themeSettings == null) {
    return;
  }
  if (themeSettings.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && themeSettings.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final themeSettingsData =
      getThemeSettingsFirestoreData(themeSettings, forFieldValue);
  final nestedData =
      themeSettingsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = themeSettings.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getThemeSettingsFirestoreData(
  ThemeSettingsStruct? themeSettings, [
  bool forFieldValue = false,
]) {
  if (themeSettings == null) {
    return {};
  }
  final firestoreData = mapToFirestore(themeSettings.toMap());

  // Add any Firestore field values
  themeSettings.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getThemeSettingsListFirestoreData(
  List<ThemeSettingsStruct>? themeSettingss,
) =>
    themeSettingss
        ?.map((e) => getThemeSettingsFirestoreData(e, true))
        .toList() ??
    [];
