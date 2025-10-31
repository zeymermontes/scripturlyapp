import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';

Future setBooks(BuildContext context) async {
  ApiCallResponse? books;

  books = await BibleApiGroup.booksCall.call(
    bibleId: FFAppState().bibleId,
  );

  if ((books.succeeded ?? true)) {
    FFAppState().books = BooksStruct.maybeFromMap((books.jsonBody ?? ''))!;
  }
}

Future<dynamic> getPassages(
  BuildContext context, {
  required String? chapterCode,
  int? verse,
}) async {
  ApiCallResponse? chapterPrev;
  ApiCallResponse? chapterNext;
  ApiCallResponse? chapterResult;

  if (functions.checkForIntro(chapterCode)) {
    if (chapterCode == 'GEN.intro') {
      return null;
    }
    if (functions.checkForIntro(FFAppState().prevChapter)) {
      chapterPrev = await BibleApiGroup.chapterContentCall.call(
        bibleId: FFAppState().bibleId,
        chapter: chapterCode,
      );

      FFAppState().tempChapterId = BibleApiGroup.chapterContentCall.previousId(
        (chapterPrev.jsonBody ?? ''),
      )!;
    } else if (functions.checkForIntro(FFAppState().nextChapter)) {
      chapterNext = await BibleApiGroup.chapterContentCall.call(
        bibleId: FFAppState().bibleId,
        chapter: chapterCode,
      );

      FFAppState().tempChapterId = BibleApiGroup.chapterContentCall.nextId(
        (chapterNext.jsonBody ?? ''),
      )!;
    } else {
      await actions.debug(
        'DD',
      );
    }
  } else {
    FFAppState().tempChapterId = chapterCode!;
  }

  chapterResult = await BibleApiGroup.chapterContentCall.call(
    bibleId: FFAppState().bibleId,
    chapter: FFAppState().tempChapterId,
  );

  if ((chapterResult.succeeded ?? true)) {
    if (verse != null) {
      FFAppState().highlightedVerse = verse;
    } else {
      FFAppState().highlightedVerse = 0;
    }

    if (chapterCode == 'REV.22') {
      FFAppState().chapterContentCurrent =
          BibleApiGroup.chapterContentCall.content(
        (chapterResult.jsonBody ?? ''),
      )!;
      FFAppState().chapterNameCurrent =
          BibleApiGroup.chapterContentCall.chapterData(
        (chapterResult.jsonBody ?? ''),
      )!;
      FFAppState().nextChapter = '';
      FFAppState().prevChapter = BibleApiGroup.chapterContentCall.previousId(
                    (chapterResult.jsonBody ?? ''),
                  ) !=
                  null &&
              BibleApiGroup.chapterContentCall.previousId(
                    (chapterResult.jsonBody ?? ''),
                  ) !=
                  ''
          ? BibleApiGroup.chapterContentCall.previousId(
              (chapterResult.jsonBody ?? ''),
            )!
          : null;
      FFAppState().update(() {});
    } else {
      if (BibleApiGroup.chapterContentCall.previousId(
                (chapterResult.jsonBody ?? ''),
              ) ==
              null ||
          BibleApiGroup.chapterContentCall.previousId(
                (chapterResult.jsonBody ?? ''),
              ) ==
              '') {
        FFAppState().chapterContentCurrent =
            BibleApiGroup.chapterContentCall.content(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().chapterNameCurrent =
            BibleApiGroup.chapterContentCall.chapterData(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().nextChapter = BibleApiGroup.chapterContentCall.nextId(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().update(() {});
      } else {
        FFAppState().chapterContentCurrent =
            BibleApiGroup.chapterContentCall.content(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().chapterNameCurrent =
            BibleApiGroup.chapterContentCall.chapterData(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().nextChapter = BibleApiGroup.chapterContentCall.nextId(
          (chapterResult.jsonBody ?? ''),
        )!;
        FFAppState().prevChapter = BibleApiGroup.chapterContentCall.previousId(
                  (chapterResult.jsonBody ?? ''),
                ) ==
                'null'
            ? ''
            : BibleApiGroup.chapterContentCall.previousId(
                (chapterResult.jsonBody ?? ''),
              )!;
        FFAppState().update(() {});
      }
    }

    return (chapterResult.jsonBody ?? '');
  }

  return null;
}

Future<dynamic> getChapterContent(
  BuildContext context, {
  required String? chapterId,
}) async {
  ApiCallResponse? chapterContent;

  chapterContent = await BibleApiGroup.chapterContentCall.call(
    bibleId: FFAppState().bibleId,
    chapter: chapterId,
  );

  if ((chapterContent.succeeded ?? true)) {
    return (chapterContent.jsonBody ?? '');
  }

  return null;
}

Future checkEdgeToEdge(BuildContext context) async {
  bool? isEdgeToEdge;

  isEdgeToEdge = await actions.isEdgeToEdge(
    context,
  );
  FFAppState().isEdgeToEdge = isEdgeToEdge;
  FFAppState().update(() {});
}

Future changeBible(
  BuildContext context, {
  BiblesStruct? bibleSelected,
}) async {
  if (bibleSelected?.language == Languages.eng) {
    setAppLanguage(context, 'en');
  } else if (bibleSelected?.language == Languages.spa) {
    setAppLanguage(context, 'es');
  } else {
    setAppLanguage(context, 'en');
  }

  FFAppState().bibleId = bibleSelected!.bibleID;
  FFAppState().BibleAcronim = bibleSelected.bibleAcronim;
  FFAppState().selectedlanguage = bibleSelected.language;
  FFAppState().update(() {});
  FFAppState().selectedVerse = -1;
  FFAppState().selectedChapterCode = 'GEN.1';
  FFAppState().update(() {});
}

Future checkUser(BuildContext context) async {
  if (!(currentUserReference != null)) {
    context.goNamed(LandingWidget.routeName);

    return;
  }
}
