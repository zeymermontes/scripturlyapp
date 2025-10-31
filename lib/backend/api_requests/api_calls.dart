import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start bibleApi Group Code

class BibleApiGroup {
  static String getBaseUrl() => 'https://rest.api.bible/v1';
  static Map<String, String> headers = {
    'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
  };
  static BooksCall booksCall = BooksCall();
  static BiblesCall biblesCall = BiblesCall();
  static ChapterCall chapterCall = ChapterCall();
  static ChapterContentCall chapterContentCall = ChapterContentCall();
  static PassagesCall passagesCall = PassagesCall();
}

class BooksCall {
  Future<ApiCallResponse> call({
    String? bibleId = 'de4e12af7f28f599-01',
  }) async {
    final baseUrl = BibleApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'books',
      apiUrl: '${baseUrl}/bibles/${bibleId}/books?include-chapters=true',
      callType: ApiCallType.GET,
      headers: {
        'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List? chapters(dynamic response) => getJsonField(
        response,
        r'''$.data[:].chapters''',
        true,
      ) as List?;
}

class BiblesCall {
  Future<ApiCallResponse> call({
    String? bibleId = '1c8c5001c8a14d26-01',
  }) async {
    final baseUrl = BibleApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'bibles',
      apiUrl: '${baseUrl}/bibles?language=eng',
      callType: ApiCallType.GET,
      headers: {
        'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ChapterCall {
  Future<ApiCallResponse> call({
    String? bibleId = '06125adad2d5898a-01',
    String? bookId = 'gen',
  }) async {
    final baseUrl = BibleApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'chapter',
      apiUrl: '${baseUrl}/bibles/${bibleId}/books/${bookId}/chapters',
      callType: ApiCallType.GET,
      headers: {
        'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? bibleId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].bibleId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? bookId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].bookId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? number(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ChapterContentCall {
  Future<ApiCallResponse> call({
    String? bibleId = '06125adad2d5898a-01',
    String? chapter = 'gen.43',
  }) async {
    final baseUrl = BibleApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'chapterContent',
      apiUrl:
          '${baseUrl}/bibles/${bibleId}/chapters/${chapter}?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=true&include-verse-numbers=true&include-verse-spans=false',
      callType: ApiCallType.GET,
      headers: {
        'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? content(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.content''',
      ));
  String? previousId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.previous.id''',
      ));
  String? previousNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.previous.number''',
      ));
  String? nextNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.next.number''',
      ));
  String? nextId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.next.id''',
      ));
  String? chapterData(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.reference''',
      ));
}

class PassagesCall {
  Future<ApiCallResponse> call({
    String? bibleId = '06125adad2d5898a-01',
    String? passageId = 'gen.43.1',
  }) async {
    final baseUrl = BibleApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'passages',
      apiUrl:
          '${baseUrl}/bibles/${bibleId}/passages/${passageId}?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false&use-org-id=false',
      callType: ApiCallType.GET,
      headers: {
        'api-key': 'L0AjzgRyoYWJDbqlc0SRd',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? content(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.content''',
      ));
  String? previousId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.previous.id''',
      ));
  String? previousNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.previous.number''',
      ));
  String? nextNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.next.number''',
      ));
  String? nextId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.next.id''',
      ));
  String? chapterData(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.reference''',
      ));
}

/// End bibleApi Group Code

class TapAVerseCall {
  static Future<ApiCallResponse> call({
    String? verseText = '',
    String? verseName = '',
    String? fullChapterText = '',
    String? bibleVersion = '',
    String? userId = '',
    String? spiritualMaturity = '',
    List<String>? currentStrugglesList,
    List<String>? goalsList,
  }) async {
    final currentStruggles = _serializeList(currentStrugglesList);
    final goals = _serializeList(goalsList);

    final ffApiRequestBody = '''
{
  "verse_text": "${escapeStringForJson(verseText)}",
  "verse_name": "${escapeStringForJson(verseName)}",
  "full_chapter_text": "${escapeStringForJson(fullChapterText)}",
  "bible_version": "${escapeStringForJson(bibleVersion)}",
  "user_profile": {
    "user_id": "${escapeStringForJson(userId)}",
    "spiritual_maturity": "${escapeStringForJson(spiritualMaturity)}",
    "current_struggles": ${currentStruggles},
    "goals": ${goals}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'tapAVerse',
      apiUrl:
          'https://scripturly.app.n8n.cloud/webhook/8f835cd6-cc27-4cd0-8ba6-503a9417ec86',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<CrossReferencesStruct>? crossReferences(dynamic response) =>
      (getJsonField(
        response,
        r'''$.finalOutput.cross_references''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CrossReferencesStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static String? explanationText(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.finalOutput.explanation_text''',
      ));
  static FinalOutputStruct? finalOutput(dynamic response) =>
      FinalOutputStruct.maybeFromMap(getJsonField(
        response,
        r'''$.finalOutput''',
      ));
  static List<KeyEntitiesStruct>? keyEntities(dynamic response) =>
      (getJsonField(
        response,
        r'''$.finalOutput.key_entities''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => KeyEntitiesStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class ConverseAVerseCall {
  static Future<ApiCallResponse> call({
    dynamic chatJson,
    String? verseText = '',
    String? verseName = '',
    String? bibleVersion = '',
    String? fullChapterText = '',
    String? explanationText = '',
    String? spiritualMaturity = '',
    List<String>? currentStrugglesList,
    List<String>? goalsList,
  }) async {
    final currentStruggles = _serializeList(currentStrugglesList);
    final goals = _serializeList(goalsList);
    final chat = _serializeJson(chatJson, true);
    final ffApiRequestBody = '''
{
  "original_verse": {
    "name": "${escapeStringForJson(verseName)}",
    "text": "${escapeStringForJson(verseText)}",
    "version": "${escapeStringForJson(bibleVersion)}"
  },
  "full_chapter_text": "${escapeStringForJson(fullChapterText)}",
  "initial_explanation": {
    "explanation_text": "${escapeStringForJson(explanationText)}",
    "sources": [
      "gotquestions.org",
      "Matthew Henry's Commentary"
    ],
    "key_entities": [
  
    ],
    "cross_references": [
      {
        "verse": "Psalm 33:6",
        "reason": "Explicitly connects the 'word of the LORD' with the act of creation."
      }
    ]
  },
  "user_profile": {
    "spiritual_maturity": "${escapeStringForJson(spiritualMaturity)}",
    "current_struggles": ${currentStruggles},
    "goals": ${goals}
  },
  "chat_history": ${chat}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'converseAVerse',
      apiUrl:
          'https://scripturly.app.n8n.cloud/webhook/305e6c03-72a4-44ed-8f20-98493a2f278d',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.finalOutput.response_text''',
      ));
  static List? crossReferences(dynamic response) => getJsonField(
        response,
        r'''$.finalOutput.cross_references''',
        true,
      ) as List?;
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
