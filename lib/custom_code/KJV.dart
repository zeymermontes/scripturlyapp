class BibleVerse {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  BibleVerse({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory BibleVerse.fromKeyValue(String key, String value) {
    final parts = key.split(' ');
    final book = parts[0];
    final chapterVerse = parts[1].split(':');
    final chapter = int.parse(chapterVerse[0]);
    final verse = int.parse(chapterVerse[1]);

    return BibleVerse(
      book: book,
      chapter: chapter,
      verse: verse,
      text: value,
    );
  }
}

class BibleService {
  final Map<String, String> _bibleData;

  BibleService(this._bibleData);

  // Obtener un versículo específico
  String? getVerse(String book, int chapter, int verse) {
    final key = '$book $chapter:$verse';
    return _bibleData[key];
  }

  // Obtener todo un capítulo
  Map<int, String> getChapter(String book, int chapter) {
    final chapterVerses = <int, String>{};

    _bibleData.forEach((key, value) {
      final parts = key.split(' ');
      if (parts[0] == book) {
        final chapterVerse = parts[1].split(':');
        final chapterNum = int.parse(chapterVerse[0]);
        final verseNum = int.parse(chapterVerse[1]);

        if (chapterNum == chapter) {
          chapterVerses[verseNum] = value;
        }
      }
    });

    return chapterVerses;
  }

  // Método principal que usará tu app
  Map<int, String> getChapterFromVerse(String verseReference) {
    // Parsear referencia como "Genesis 1:3"
    final parts = verseReference.split(' ');
    final book = parts[0];
    final chapterVerse = parts[1].split(':');
    final chapter = int.parse(chapterVerse[0]);

    return getChapter(book, chapter);
  }
}
