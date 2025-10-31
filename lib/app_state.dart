import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _biblesAvailable = prefs
              .getStringList('ff_biblesAvailable')
              ?.map((x) {
                try {
                  return BiblesStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _biblesAvailable;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_books')) {
        try {
          final serializedData = prefs.getString('ff_books') ?? '{}';
          _books = BooksStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _BibleAcronim = prefs.getString('ff_BibleAcronim') ?? _BibleAcronim;
    });
    _safeInit(() {
      _chapterNameCurrent =
          prefs.getString('ff_chapterNameCurrent') ?? _chapterNameCurrent;
    });
    _safeInit(() {
      _chapterContentCurrent =
          prefs.getString('ff_chapterContentCurrent') ?? _chapterContentCurrent;
    });
    _safeInit(() {
      _highlightedVerse =
          prefs.getInt('ff_highlightedVerse') ?? _highlightedVerse;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_readersettings')) {
        try {
          final serializedData = prefs.getString('ff_readersettings') ?? '{}';
          _readersettings = ThemeSettingsStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _nextChapter = prefs.getString('ff_nextChapter') ?? _nextChapter;
    });
    _safeInit(() {
      _prevChapter = prefs.getString('ff_prevChapter') ?? _prevChapter;
    });
    _safeInit(() {
      _selectedChapterCode =
          prefs.getString('ff_selectedChapterCode') ?? _selectedChapterCode;
    });
    _safeInit(() {
      _selectedVerse = prefs.getInt('ff_selectedVerse') ?? _selectedVerse;
    });
    _safeInit(() {
      _isEdgeToEdge = prefs.getBool('ff_isEdgeToEdge') ?? _isEdgeToEdge;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userProfile')) {
        try {
          final serializedData = prefs.getString('ff_userProfile') ?? '{}';
          _userProfile =
              UserProfileStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _selectedlanguage = prefs.containsKey('ff_selectedlanguage')
          ? deserializeEnum<Languages>(prefs.getString('ff_selectedlanguage'))
          : _selectedlanguage;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<BiblesStruct> _biblesAvailable = [
    BiblesStruct.fromSerializableMap(jsonDecode(
        '{\"bibleID\":\"de4e12af7f28f599-01\",\"bibleAcronim\":\"KJV\",\"language\":\"eng\",\"bibleName\":\"King James Version\",\"description\":\"The traditional, poetic language of the 1611 translation.\"}')),
    BiblesStruct.fromSerializableMap(jsonDecode(
        '{\"bibleID\":\"63097d2a0a2f7db3-01\",\"bibleAcronim\":\"NKJV\",\"language\":\"eng\",\"bibleName\":\"New King James Version\",\"description\":\"A modern update to the classic KJV, preserving its structure.\"}')),
    BiblesStruct.fromSerializableMap(jsonDecode(
        '{\"bibleID\":\"d6e14a625393b4da-01\",\"bibleAcronim\":\"NLT\",\"language\":\"eng\",\"bibleName\":\"New Living Translation\",\"description\":\"Clear, modern English. Great for devotional reading.\"}')),
    BiblesStruct.fromSerializableMap(jsonDecode(
        '{\"bibleID\":\"592420522e16049f-01\",\"bibleAcronim\":\"RVR09\",\"language\":\"spa\",\"bibleName\":\"Reina Valera 1909\",\"description\":\"A classic and highly regarded Spanish-language Bible translation known for its direct and literal translation,\"}'))
  ];
  List<BiblesStruct> get biblesAvailable => _biblesAvailable;
  set biblesAvailable(List<BiblesStruct> value) {
    _biblesAvailable = value;
    prefs.setStringList(
        'ff_biblesAvailable', value.map((x) => x.serialize()).toList());
  }

  void addToBiblesAvailable(BiblesStruct value) {
    biblesAvailable.add(value);
    prefs.setStringList('ff_biblesAvailable',
        _biblesAvailable.map((x) => x.serialize()).toList());
  }

  void removeFromBiblesAvailable(BiblesStruct value) {
    biblesAvailable.remove(value);
    prefs.setStringList('ff_biblesAvailable',
        _biblesAvailable.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromBiblesAvailable(int index) {
    biblesAvailable.removeAt(index);
    prefs.setStringList('ff_biblesAvailable',
        _biblesAvailable.map((x) => x.serialize()).toList());
  }

  void updateBiblesAvailableAtIndex(
    int index,
    BiblesStruct Function(BiblesStruct) updateFn,
  ) {
    biblesAvailable[index] = updateFn(_biblesAvailable[index]);
    prefs.setStringList('ff_biblesAvailable',
        _biblesAvailable.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInBiblesAvailable(int index, BiblesStruct value) {
    biblesAvailable.insert(index, value);
    prefs.setStringList('ff_biblesAvailable',
        _biblesAvailable.map((x) => x.serialize()).toList());
  }

  BooksStruct _books = BooksStruct();
  BooksStruct get books => _books;
  set books(BooksStruct value) {
    _books = value;
    prefs.setString('ff_books', value.serialize());
  }

  void updateBooksStruct(Function(BooksStruct) updateFn) {
    updateFn(_books);
    prefs.setString('ff_books', _books.serialize());
  }

  String _bibleId = '63097d2a0a2f7db3-01';
  String get bibleId => _bibleId;
  set bibleId(String value) {
    _bibleId = value;
  }

  String _BibleAcronim = 'NKJV';
  String get BibleAcronim => _BibleAcronim;
  set BibleAcronim(String value) {
    _BibleAcronim = value;
    prefs.setString('ff_BibleAcronim', value);
  }

  String _chapterNameCurrent = '';
  String get chapterNameCurrent => _chapterNameCurrent;
  set chapterNameCurrent(String value) {
    _chapterNameCurrent = value;
    prefs.setString('ff_chapterNameCurrent', value);
  }

  String _chapterContentCurrent = '';
  String get chapterContentCurrent => _chapterContentCurrent;
  set chapterContentCurrent(String value) {
    _chapterContentCurrent = value;
    prefs.setString('ff_chapterContentCurrent', value);
  }

  int _highlightedVerse = 0;
  int get highlightedVerse => _highlightedVerse;
  set highlightedVerse(int value) {
    _highlightedVerse = value;
    prefs.setInt('ff_highlightedVerse', value);
  }

  ThemeSettingsStruct _readersettings = ThemeSettingsStruct.fromSerializableMap(
      jsonDecode('{\"size\":\"14.0\",\"font\":\"inter\",\"theme\":\"light\"}'));
  ThemeSettingsStruct get readersettings => _readersettings;
  set readersettings(ThemeSettingsStruct value) {
    _readersettings = value;
    prefs.setString('ff_readersettings', value.serialize());
  }

  void updateReadersettingsStruct(Function(ThemeSettingsStruct) updateFn) {
    updateFn(_readersettings);
    prefs.setString('ff_readersettings', _readersettings.serialize());
  }

  String _nextChapter = '';
  String get nextChapter => _nextChapter;
  set nextChapter(String value) {
    _nextChapter = value;
    prefs.setString('ff_nextChapter', value);
  }

  String _prevChapter = '';
  String get prevChapter => _prevChapter;
  set prevChapter(String value) {
    _prevChapter = value;
    prefs.setString('ff_prevChapter', value);
  }

  String _tempChapterId = '';
  String get tempChapterId => _tempChapterId;
  set tempChapterId(String value) {
    _tempChapterId = value;
  }

  String _selectedChapterCode = 'GEN.1';
  String get selectedChapterCode => _selectedChapterCode;
  set selectedChapterCode(String value) {
    _selectedChapterCode = value;
    prefs.setString('ff_selectedChapterCode', value);
  }

  int _selectedVerse = 0;
  int get selectedVerse => _selectedVerse;
  set selectedVerse(int value) {
    _selectedVerse = value;
    prefs.setInt('ff_selectedVerse', value);
  }

  bool _isEdgeToEdge = false;
  bool get isEdgeToEdge => _isEdgeToEdge;
  set isEdgeToEdge(bool value) {
    _isEdgeToEdge = value;
    prefs.setBool('ff_isEdgeToEdge', value);
  }

  bool _keepExpandedState = false;
  bool get keepExpandedState => _keepExpandedState;
  set keepExpandedState(bool value) {
    _keepExpandedState = value;
  }

  UserProfileStruct _userProfile = UserProfileStruct();
  UserProfileStruct get userProfile => _userProfile;
  set userProfile(UserProfileStruct value) {
    _userProfile = value;
    prefs.setString('ff_userProfile', value.serialize());
  }

  void updateUserProfileStruct(Function(UserProfileStruct) updateFn) {
    updateFn(_userProfile);
    prefs.setString('ff_userProfile', _userProfile.serialize());
  }

  Languages? _selectedlanguage = Languages.eng;
  Languages? get selectedlanguage => _selectedlanguage;
  set selectedlanguage(Languages? value) {
    _selectedlanguage = value;
    value != null
        ? prefs.setString('ff_selectedlanguage', value.serialize())
        : prefs.remove('ff_selectedlanguage');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
