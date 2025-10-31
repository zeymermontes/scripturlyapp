import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "chatHistory" field.
  List<FinalOutputStruct>? _chatHistory;
  List<FinalOutputStruct> get chatHistory => _chatHistory ?? const [];
  bool hasChatHistory() => _chatHistory != null;

  // "created" field.
  DateTime? _created;
  DateTime? get created => _created;
  bool hasCreated() => _created != null;

  // "chapter" field.
  String? _chapter;
  String get chapter => _chapter ?? '';
  bool hasChapter() => _chapter != null;

  // "chapterContent" field.
  String? _chapterContent;
  String get chapterContent => _chapterContent ?? '';
  bool hasChapterContent() => _chapterContent != null;

  // "verse" field.
  String? _verse;
  String get verse => _verse ?? '';
  bool hasVerse() => _verse != null;

  // "verseContent" field.
  String? _verseContent;
  String get verseContent => _verseContent ?? '';
  bool hasVerseContent() => _verseContent != null;

  // "explanation" field.
  FinalOutputStruct? _explanation;
  FinalOutputStruct get explanation => _explanation ?? FinalOutputStruct();
  bool hasExplanation() => _explanation != null;

  void _initializeFields() {
    _userID = snapshotData['userID'] as String?;
    _chatHistory = getStructList(
      snapshotData['chatHistory'],
      FinalOutputStruct.fromMap,
    );
    _created = snapshotData['created'] as DateTime?;
    _chapter = snapshotData['chapter'] as String?;
    _chapterContent = snapshotData['chapterContent'] as String?;
    _verse = snapshotData['verse'] as String?;
    _verseContent = snapshotData['verseContent'] as String?;
    _explanation = snapshotData['explanation'] is FinalOutputStruct
        ? snapshotData['explanation']
        : FinalOutputStruct.maybeFromMap(snapshotData['explanation']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  String? userID,
  DateTime? created,
  String? chapter,
  String? chapterContent,
  String? verse,
  String? verseContent,
  FinalOutputStruct? explanation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userID': userID,
      'created': created,
      'chapter': chapter,
      'chapterContent': chapterContent,
      'verse': verse,
      'verseContent': verseContent,
      'explanation': FinalOutputStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "explanation" field.
  addFinalOutputStructData(firestoreData, explanation, 'explanation');

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userID == e2?.userID &&
        listEquality.equals(e1?.chatHistory, e2?.chatHistory) &&
        e1?.created == e2?.created &&
        e1?.chapter == e2?.chapter &&
        e1?.chapterContent == e2?.chapterContent &&
        e1?.verse == e2?.verse &&
        e1?.verseContent == e2?.verseContent &&
        e1?.explanation == e2?.explanation;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.userID,
        e?.chatHistory,
        e?.created,
        e?.chapter,
        e?.chapterContent,
        e?.verse,
        e?.verseContent,
        e?.explanation
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
