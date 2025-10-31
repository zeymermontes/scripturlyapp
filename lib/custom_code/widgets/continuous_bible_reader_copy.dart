// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_fonts/google_fonts.dart';

class BibleVerse {
  final int number;
  final String text;
  final String chapterCode;

  BibleVerse(
      {required this.number, required this.text, required this.chapterCode});
}

class BibleParagraph {
  final List<BibleVerse> verses;
  final bool isNewParagraph;
  final String chapterCode;

  BibleParagraph(
      {required this.verses,
      this.isNewParagraph = false,
      required this.chapterCode});
}

class ChapterData {
  final String chapterCode;
  final String content;
  final String? bookName;
  final String? chapterNumber;
  final String? previousChapterCode;
  final String? nextChapterCode;

  ChapterData({
    required this.chapterCode,
    required this.content,
    this.bookName,
    this.chapterNumber,
    this.previousChapterCode,
    this.nextChapterCode,
  });
}

class ContinuousBibleReaderCopy extends StatefulWidget {
  const ContinuousBibleReaderCopy({
    super.key,
    this.width,
    this.height,
    required this.apiContent,
    this.highlightedVerse,
    this.bookName,
    this.chapterNumber,
    this.showTestNavigation = false,
    this.fontSize = 12,
    this.font = 'inter',
    this.theme = 'light',
    this.previousChapterCode,
    this.nextChapterCode,
    required this.chapterCode, // NUEVO PARÁMETRO
  });

  final double? width;
  final double? height;
  final String apiContent;
  final int? highlightedVerse;
  final String? bookName;
  final String? chapterNumber;
  final bool showTestNavigation;
  final double fontSize;
  final String font;
  final String theme;
  final String? previousChapterCode;
  final String? nextChapterCode;
  final String chapterCode; // NUEVO: Código único del capítulo actual

  @override
  State<ContinuousBibleReaderCopy> createState() =>
      _ContinuousBibleReaderCopyState();
}

class _ContinuousBibleReaderCopyState extends State<ContinuousBibleReaderCopy> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _verseKeys = {};
  List<BibleParagraph> _allParagraphs = [];

  // Control de chunks de capítulos
  List<ChapterData> _loadedChapters = [];
  final Set<String> _loadingChapters = {};
  bool _isInitialLoad = true;
  String? _currentChapterCode; // Trackear el chapter code actual

  // Variables para el scroll y progreso
  int? _currentHighlightedVerse;
  double _scrollProgress = 0.0;
  int _totalVerses = 0;
  int _currentVerseInView = 0;

  // Configuración
  static const int CHAPTERS_TO_PRELOAD =
      1; // Reducido a 1 para mejor performance

  @override
  void initState() {
    super.initState();
    _currentHighlightedVerse = widget.highlightedVerse;
    _currentChapterCode = widget.chapterCode;

    // Inicializar con el capítulo actual
    _initializeWithCurrentChapter();

    _scrollController.addListener(_scrollListener);

    if (_currentHighlightedVerse != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToVerse(_currentHighlightedVerse!, widget.chapterNumber ?? '1');
      });
    }
  }

  // NUEVO MÉTODO: Resetear y cargar nuevo capítulo
  void _resetAndLoadChapter(String newChapterCode) {
    if (_currentChapterCode == newChapterCode) return;

    print('Resetting and loading new chapter: $newChapterCode');

    setState(() {
      // Limpiar todo
      _loadedChapters.clear();
      _allParagraphs.clear();
      _verseKeys.clear();
      _loadingChapters.clear();
      _totalVerses = 0;
      _currentVerseInView = 0;
      _scrollProgress = 0.0;
      _isInitialLoad = true;
      _currentChapterCode = newChapterCode;

      // Resetear scroll position
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });

    // Inicializar con el nuevo capítulo
    _initializeWithCurrentChapter();
  }

  void _initializeWithCurrentChapter() {
    final currentChapter = ChapterData(
      chapterCode: widget.chapterCode,
      content: widget.apiContent,
      bookName: widget.bookName,
      chapterNumber: widget.chapterNumber,
      previousChapterCode: widget.previousChapterCode,
      nextChapterCode: widget.nextChapterCode,
    );

    _loadedChapters.add(currentChapter);
    _processChapterContent(currentChapter);

    // Precargar capítulos adyacentes (solo 1 para mejor performance)
    _preloadAdjacentChapters();
  }

  String _getChapterCode(String? bookName, String? chapterNumber) {
    if (bookName != null && chapterNumber != null) {
      return '$bookName.$chapterNumber';
    }
    return 'unknown';
  }

  void _processChapterContent(ChapterData chapter) {
    try {
      final paragraphs = _parseContent(chapter.content, chapter.chapterCode);
      _allParagraphs.addAll(paragraphs);

      // Actualizar contadores
      _totalVerses = _allParagraphs.fold(
          0, (sum, paragraph) => sum + paragraph.verses.length);

      // Crear keys para los versículos
      for (final paragraph in paragraphs) {
        for (final verse in paragraph.verses) {
          final key = '${verse.chapterCode}_${verse.number}';
          _verseKeys[key] = GlobalKey();
        }
      }

      if (_isInitialLoad) {
        _isInitialLoad = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _calculateScrollProgress();
        });
      }
    } catch (e) {
      print('Error processing chapter ${chapter.chapterCode}: $e');
    }
  }

  List<BibleParagraph> _parseContent(String content, String chapterCode) {
    final List<BibleParagraph> paragraphs = [];
    final List<BibleVerse> currentParagraph = [];

    final lines =
        content.split('\n').where((line) => line.trim().isNotEmpty).toList();

    for (final line in lines) {
      final trimmedLine = line.trim();

      // Detectar nuevo párrafo
      final isNewParagraph = trimmedLine.startsWith('¶') ||
          line.contains('     ') ||
          (paragraphs.isNotEmpty && currentParagraph.isNotEmpty);

      if (isNewParagraph && currentParagraph.isNotEmpty) {
        paragraphs.add(BibleParagraph(
          verses: List.from(currentParagraph),
          isNewParagraph: true,
          chapterCode: chapterCode,
        ));
        currentParagraph.clear();
      }

      // Procesar versos
      final verseMatches =
          RegExp(r'\[(\d+)\](.*?)(?=\[\d+\]|$)').allMatches(trimmedLine);

      for (final match in verseMatches) {
        if (match.groupCount >= 2) {
          final number = int.parse(match.group(1)!);
          String text = match.group(2)!.trim();
          text = text.replaceAll('¶', '').trim();

          currentParagraph.add(
              BibleVerse(number: number, text: text, chapterCode: chapterCode));
        }
      }
    }

    // Agregar el último párrafo
    if (currentParagraph.isNotEmpty) {
      paragraphs.add(
          BibleParagraph(verses: currentParagraph, chapterCode: chapterCode));
    }

    return paragraphs;
  }

  void _preloadAdjacentChapters() {
    // Precargar capítulo siguiente
    final lastChapter = _loadedChapters.last;
    if (lastChapter.nextChapterCode != null &&
        lastChapter.nextChapterCode!.isNotEmpty) {
      _loadChapter(lastChapter.nextChapterCode!);
    }

    // Precargar capítulo anterior
    final firstChapter = _loadedChapters.first;
    if (firstChapter.previousChapterCode != null &&
        firstChapter.previousChapterCode!.isNotEmpty &&
        firstChapter.previousChapterCode != 'GEN.intro') {
      _loadChapter(firstChapter.previousChapterCode!);
    }
  }

  Future<void> _loadChapter(String chapterCode) async {
    if (_loadingChapters.contains(chapterCode) ||
        _loadedChapters.any((chapter) => chapter.chapterCode == chapterCode)) {
      return;
    }

    _loadingChapters.add(chapterCode);

    try {
      final response = await getChapterContent(chapterCode);

      // VERIFICACIÓN Y EXTRACCIÓN SEGURA DE DATOS
      if (response != null && response is Map<String, dynamic>) {
        final data = response['data'];
        if (data != null && data is Map<String, dynamic>) {
          final content = data['content'];

          if (content != null && content is String && content.isNotEmpty) {
            // Extraer información adicional de la respuesta
            final bookId = data['bookId']?.toString();
            final chapterNum = data['number']?.toString();
            final nextChapter = data['next'] != null && data['next'] is Map
                ? data['next']['id']?.toString()
                : null;
            final previousChapter =
                data['previous'] != null && data['previous'] is Map
                    ? data['previous']['id']?.toString()
                    : null;

            if (mounted) {
              setState(() {
                final newChapter = ChapterData(
                  chapterCode: chapterCode,
                  content: content,
                  bookName: bookId,
                  chapterNumber: chapterNum,
                  previousChapterCode: previousChapter,
                  nextChapterCode: nextChapter,
                );

                final isPrevious = _isPreviousChapter(chapterCode);
                if (isPrevious) {
                  _loadedChapters.insert(0, newChapter);
                } else {
                  _loadedChapters.add(newChapter);
                }
                _processChapterContent(newChapter);
              });
            }
          } else {
            print('Content is null or empty for chapter $chapterCode');
          }
        } else {
          print('Data is null or not a Map for chapter $chapterCode');
        }
      } else {
        print('Response is null or not a Map for chapter $chapterCode');
      }
    } catch (e) {
      print('Error loading chapter $chapterCode: $e');
    } finally {
      _loadingChapters.remove(chapterCode);
    }
  }

  bool _isPreviousChapter(String chapterCode) {
    if (_loadedChapters.isEmpty) return false;
    final firstChapter = _loadedChapters.first;
    return chapterCode.compareTo(firstChapter.chapterCode) < 0;
  }

  void _scrollListener() {
    _calculateScrollProgress();
    _checkAndLoadMoreChapters();
  }

  void _checkAndLoadMoreChapters() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;

    // Cargar más capítulos cuando esté cerca del final
    if (maxScroll - currentScroll < 500) {
      final lastChapter = _loadedChapters.last;
      if (lastChapter.nextChapterCode != null &&
          lastChapter.nextChapterCode!.isNotEmpty) {
        _loadChapter(lastChapter.nextChapterCode!);
      }
    }

    // Cargar más capítulos cuando esté cerca del inicio
    if (currentScroll < 500) {
      final firstChapter = _loadedChapters.first;
      if (firstChapter.previousChapterCode != null &&
          firstChapter.previousChapterCode!.isNotEmpty &&
          firstChapter.previousChapterCode != 'GEN.intro') {
        _loadChapter(firstChapter.previousChapterCode!);
      }
    }
  }

  void _calculateScrollProgress() {
    if (_scrollController.hasClients && _totalVerses > 0) {
      final scrollPosition = _scrollController.position;
      final maxScroll = scrollPosition.maxScrollExtent;
      final currentScroll = scrollPosition.pixels;

      double progress = 0.0;
      if (maxScroll > 0) {
        progress = (currentScroll / maxScroll).clamp(0.0, 1.0);
      }

      setState(() {
        _scrollProgress = progress;
        _currentVerseInView =
            (1 + ((progress * 100) * (_totalVerses - 1)) / 100).round();
      });
    }
  }

  void _scrollToVerse(int verseNumber, String chapterNumber) {
    final key = _verseKeys[
        '${_getChapterCode(widget.bookName, chapterNumber)}_$verseNumber'];
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    }
  }

  void _highlightVerse(int verseNumber, String chapterCode) {
    setState(() {
      _currentHighlightedVerse = verseNumber;
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollToVerse(verseNumber, chapterCode);
    });
  }

  dynamic getChapterContent(String chapterCode) async {
    return await action_blocks.getPassages(context, chapterCode: chapterCode);
  }

  List<InlineSpan> _buildVerseSpans(BibleVerse verse) {
    final isHighlighted = verse.number == _currentHighlightedVerse;
    final verseKey = '${verse.chapterCode}_${verse.number}';

    Color getTextColor(bool isVerseNumber) {
      if (widget.theme == 'light') {
        return isVerseNumber
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).bodyMedium?.color ?? Colors.black;
      } else if (widget.theme == 'sephia') {
        return isVerseNumber ? Color(0xFF8B7355) : Color(0xFF5D4037);
      } else {
        return isVerseNumber ? Color(0xFFD4B896) : Colors.white;
      }
    }

    return [
      WidgetSpan(
        child: Container(
          key: _verseKeys[verseKey],
          margin: const EdgeInsets.only(right: 4.0),
          child: Text(
            '${verse.number}',
            style: widget.font == 'tienne'
                ? GoogleFonts.tienne(
                    color: getTextColor(true),
                    fontSize: widget.fontSize,
                    height: 1.6,
                    backgroundColor: isHighlighted
                        ? Colors.yellow.withOpacity(0.3)
                        : Colors.transparent,
                    fontWeight: FontWeight.bold)
                : GoogleFonts.inter(
                    color: getTextColor(true),
                    fontSize: widget.fontSize,
                    height: 1.6,
                    backgroundColor: isHighlighted
                        ? Colors.yellow.withOpacity(0.3)
                        : Colors.transparent,
                    fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: '${verse.text} ',
        style: widget.font == 'tienne'
            ? GoogleFonts.tienne(
                color: getTextColor(false),
                fontSize: widget.fontSize,
                height: 1.6,
                backgroundColor: isHighlighted
                    ? Colors.yellow.withOpacity(0.3)
                    : Colors.transparent,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              )
            : GoogleFonts.inter(
                color: getTextColor(false),
                fontSize: widget.fontSize,
                height: 1.6,
                backgroundColor: isHighlighted
                    ? Colors.yellow.withOpacity(0.3)
                    : Colors.transparent,
                fontWeight:
                    isHighlighted ? FontWeight.bold : FontWeight.normal),
      ),
    ];
  }

  Widget _buildChapterHeader(String bookName, String chapterNumber) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Text(
        '$bookName $chapterNumber',
        style: FlutterFlowTheme.of(context).titleLarge?.copyWith(
              color: FlutterFlowTheme.of(context).primary,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: widget.theme == 'light'
            ? FlutterFlowTheme.of(context).secondaryBackground
            : widget.theme == 'sephia'
                ? Color(0xFFF4ECD8)
                : Color.fromARGB(255, 30, 30, 30),
        border: Border(
          bottom: BorderSide(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.theme == 'light'
                  ? Colors.grey[300]
                  : widget.theme == 'sephia'
                      ? Color(0xFFD4B896)
                      : Colors.grey[700],
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * _scrollProgress,
                  height: 4.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary,
                        FlutterFlowTheme.of(context).primary.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_currentVerseInView verses',
                style: FlutterFlowTheme.of(context).bodySmall?.copyWith(
                      color: widget.theme == 'light'
                          ? FlutterFlowTheme.of(context).secondaryText
                          : widget.theme == 'sephia'
                              ? Color(0xFF8B7355)
                              : Colors.grey[400],
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                '${_loadedChapters.length} chapters loaded',
                style: FlutterFlowTheme.of(context).bodySmall?.copyWith(
                      color: widget.theme == 'light'
                          ? FlutterFlowTheme.of(context).secondaryText
                          : widget.theme == 'sephia'
                              ? Color(0xFF8B7355)
                              : Colors.grey[400],
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _allParagraphs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading Bible content...',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                _buildProgressBar(),
                Expanded(
                  child: Container(
                    color: widget.theme == 'light'
                        ? FlutterFlowTheme.of(context).secondaryBackground
                        : widget.theme == 'sephia'
                            ? Color(0xFFF4ECD8)
                            : Color.fromARGB(255, 0, 0, 0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildContent(),
                          if (_loadingChapters.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildContent() {
    final List<Widget> widgets = [];
    String? currentChapterCode;

    for (final paragraph in _allParagraphs) {
      if (paragraph.chapterCode != currentChapterCode) {
        final chapterData = _loadedChapters.firstWhere(
          (chapter) => chapter.chapterCode == paragraph.chapterCode,
          orElse: () => ChapterData(
            chapterCode: paragraph.chapterCode,
            content: '',
            bookName: paragraph.chapterCode.split('.').first,
            chapterNumber: paragraph.chapterCode.split('.').last,
          ),
        );

        widgets.add(_buildChapterHeader(
          chapterData.bookName ?? 'Unknown',
          chapterData.chapterNumber ?? '1',
        ));
        currentChapterCode = paragraph.chapterCode;
      }

      widgets.add(
        Container(
          margin: EdgeInsets.only(
            bottom: paragraph.isNewParagraph ? 24.0 : 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: RichText(
            text: TextSpan(
              style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                    fontSize: widget.fontSize,
                    height: 1.6,
                    color: widget.theme == 'light'
                        ? FlutterFlowTheme.of(context).primaryText
                        : widget.theme == 'sephia'
                            ? Color(0xFF5D4037)
                            : Colors.white,
                  ),
              children: [
                for (final verse in paragraph.verses)
                  ..._buildVerseSpans(verse),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  void didUpdateWidget(ContinuousBibleReaderCopy oldWidget) {
    super.didUpdateWidget(oldWidget);

    // NUEVO: Detectar cambio de chapterCode y resetear
    if (oldWidget.chapterCode != widget.chapterCode) {
      _resetAndLoadChapter(widget.chapterCode);
    }

    if (oldWidget.apiContent != widget.apiContent && _isInitialLoad) {
      _initializeWithCurrentChapter();
    }

    if (oldWidget.highlightedVerse != widget.highlightedVerse) {
      setState(() {
        _currentHighlightedVerse = widget.highlightedVerse;
      });

      if (widget.highlightedVerse != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToVerse(widget.highlightedVerse!, widget.chapterNumber ?? '1');
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
