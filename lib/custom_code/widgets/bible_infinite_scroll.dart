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

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

class BibleInfiniteScroll extends StatefulWidget {
  const BibleInfiniteScroll({
    super.key,
    this.width,
    this.height,
    required this.initialChapterCode,
    this.initialVerse = -1,
    this.fontSize = 12,
    this.font = 'inter',
    this.theme = 'light',
    this.tapVerse,
    required this.header,
  });

  final double? width;
  final double? height;
  final String initialChapterCode;
  final int initialVerse;
  final double fontSize;
  final String font;
  final String theme;
  final Future Function(String verseNumber, String verseContent, String chapter,
      String chapterContent)? tapVerse;
  final Widget Function(String chapter) header;

  @override
  State<BibleInfiniteScroll> createState() => _BibleInfiniteScrollState();
}

class _BibleInfiniteScrollState extends State<BibleInfiniteScroll> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chapters = [];
  bool _isLoading = false;
  bool _hasMoreNext = true;
  bool _hasMorePrevious = true;
  bool _isLoadingPrevious = false;
  bool _isLoadingNext = false;
  DateTime? _lastLoadTime = DateTime.now();
  String _currentChapter = '';
  double _currentProgress = 0.0;
  int _currentVerse = 1;
  int _totalVerses = 1;
  String? _lastChapterCode;
  bool isResetingAndScrolling = true;

  // Variables para controlar el scroll y carga
  bool _isUserScrolling = false;
  bool _initialLoadCompleted = false;
  bool _justLoadedChapter = false;
  Timer? _scrollEndTimer;
  Timer? _loadCooldownTimer;
  final double _scrollThreshold = 0.1;
  int? _highlightedVerse;
  bool _isInitialScroll = true;

  // Keys para medir las alturas
  final Map<int, GlobalKey> _chapterKeys = {};
  final Map<int, double> _chapterHeights = {};

  @override
  void initState() {
    super.initState();
    _lastChapterCode = widget.initialChapterCode;
    _highlightedVerse = widget.initialVerse;
    _isInitialScroll = (widget.initialVerse != null && widget.initialVerse > 0);
    _loadInitialChapter();
    _setupScrollListener();
  }

  @override
  void didUpdateWidget(BibleInfiniteScroll oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialVerse == -1) {
      print('Chapter reset }');
      //_resetAndLoadNewChapter();
    }

    if (oldWidget.initialChapterCode != widget.initialChapterCode &&
        widget.initialChapterCode != _lastChapterCode) {
      print(
          'Chapter code changed from ${_lastChapterCode} to ${widget.initialChapterCode}');
      _resetAndLoadNewChapter();
    }

    if (oldWidget.initialVerse != widget.initialVerse &&
        widget.initialVerse != _highlightedVerse) {
      print(
          'Chapter verse changed from ${_highlightedVerse} to ${widget.initialVerse}');
      _resetAndLoadNewChapter();
    }
  }

  void _resetAndLoadNewChapter() {
    _scrollEndTimer?.cancel();
    _loadCooldownTimer?.cancel();
    print('Resetting and loading new chapter');

    setState(() {
      _lastChapterCode = widget.initialChapterCode;
      _chapters.clear();
      _chapterKeys.clear();
      _chapterHeights.clear();
      _currentChapter = '';
      _currentProgress = 0.0;
      _currentVerse = 1;
      _totalVerses = 1;
      _hasMoreNext = true;
      _hasMorePrevious = true;
      _isLoadingPrevious = false;
      _isLoadingNext = false;
      _initialLoadCompleted = false;
      _justLoadedChapter = false;
      _isUserScrolling = false;
      _highlightedVerse = widget.initialVerse;
      _isInitialScroll =
          (widget.initialVerse != null && widget.initialVerse > 0);
      isResetingAndScrolling = true;
    });

    _loadInitialChapter();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollEndTimer?.cancel();
    _loadCooldownTimer?.cancel();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      _checkScrollForLoading();
      _updateCurrentChapterAndProgress(); // Esta es la nueva función
    });
  }

  void _checkScrollForLoading() {
    // print('scrolling');
    //print('1');
    if (_isInitialScroll) return;
    //print('2');
    if (_isUserScrolling) return;
    //print('3');
    if (!_initialLoadCompleted) return;
    //print('4');
    if (_justLoadedChapter) return;
    //print('5');
    if (_isLoadingPrevious || _isLoadingNext) return;
    // print('6');
    if (_lastLoadTime != null &&
        DateTime.now().difference(_lastLoadTime!).inMilliseconds < 500) {
      return;
    }
    //print('7');
    if (isResetingAndScrolling) return;
    //print('8');
    final scrollPosition = _scrollController.position;
    final viewportHeight = scrollPosition.viewportDimension;
    final scrollOffset = scrollPosition.pixels;
    final maxScrollExtent = scrollPosition.maxScrollExtent;

    // Cargar capítulo anterior cuando estemos a la mitad del primer capítulo
    if (_hasMorePrevious && !_isLoadingPrevious && _chapters.isNotEmpty) {
      final firstChapterHeight = _chapterHeights[0] ?? viewportHeight;
      final middleOfFirstChapter = firstChapterHeight * 0.5;

      // Si el scroll está en la mitad del primer capítulo, cargar el anterior
      if (scrollOffset <= middleOfFirstChapter) {
        print('Loading previous chapter - at middle of first chapter');
        _loadPreviousChapter();
        return; // Evitar cargar ambos a la vez
      }
    }

    // Cargar capítulo siguiente cuando estemos a la mitad del último capítulo
    print('_hasMoreNext && !_isLoadingNext && _chapters.isNotEmpty');
    print(_hasMoreNext && !_isLoadingNext && _chapters.isNotEmpty);
    if (_hasMoreNext && !_isLoadingNext && _chapters.isNotEmpty) {
      //print('1-1');
      final lastChapterIndex = _chapters.length - 1;
      //print('1-2');
      final lastChapterStart = _getChapterStartPosition(lastChapterIndex);
      // print('1-3');
      final lastChapterHeight =
          _chapterHeights[lastChapterIndex] ?? viewportHeight;
      //print('1-4');

      final middleOfLastChapter = lastChapterStart + (lastChapterHeight * 0.5);
      //print('1-5');
      //print('scrollOffset:');
      //print(scrollOffset * 2);
      //print('middleOfLastChapter:');
      //print(middleOfLastChapter);
      //print('scrollOffset >= middleOfLastChapter');
      //print((scrollOffset * 2) >= middleOfLastChapter);
      if ((scrollOffset * 2) >= middleOfLastChapter) {
        print('Loading next chapter - at middle of last chapter');
        _loadNextChapter();
        return;
      }
    }
  }

  void _markChapterJustLoaded() {
    setState(() {
      _justLoadedChapter = true;
      _isUserScrolling = false;
    });

    _loadCooldownTimer?.cancel();
    _loadCooldownTimer = Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _justLoadedChapter = false;
        });
      }
    });
  }

  void _updateCurrentChapterAndProgress() {
    if (_chapters.isEmpty) return;

    final scrollPosition = _scrollController.position;
    final viewportHeight = scrollPosition.viewportDimension;
    final scrollOffset = _scrollController.offset;

    // Encontrar el capítulo que está en la parte superior del viewport
    int topChapterIndex = 0;
    double maxTopVisibility = 0.0;

    for (int i = 0; i < _chapters.length; i++) {
      final chapterHeight = _chapterHeights[i] ?? viewportHeight;
      final chapterStart = _getChapterStartPosition(i);

      // Verificar si este capítulo está visible en la parte superior del viewport
      if (scrollOffset >= chapterStart &&
          scrollOffset <= chapterStart + chapterHeight) {
        // Calcular qué tan cerca está del tope
        final topVisibility =
            1.0 - ((scrollOffset - chapterStart) / chapterHeight);
        if (topVisibility > maxTopVisibility) {
          maxTopVisibility = topVisibility;
          topChapterIndex = i;
        }
      }
    }

    final topChapter = _chapters[topChapterIndex];
    final newChapterName = topChapter['reference']?.toString() ?? '';

    if (newChapterName != _currentChapter) {
      setState(() {
        _currentChapter = newChapterName;
        _totalVerses = topChapter['verseCount'] ?? 1;
      });
    }

    _calculateChapterProgressFromTopVerse(
        topChapterIndex, scrollOffset, viewportHeight);
  }

  void _calculateChapterProgressFromTopVerse(
      int chapterIndex, double scrollOffset, double viewportHeight) {
    final chapter = _chapters[chapterIndex];
    final content = chapter['content']?.toString() ?? '';
    final chapterHeight = _chapterHeights[chapterIndex] ?? viewportHeight;
    final chapterStart = _getChapterStartPosition(chapterIndex);

    final verseRegex = RegExp(r'\[(\d+)\]');
    final verses = verseRegex.allMatches(content).toList();

    if (verses.isEmpty) return;

    // Calcular posición relativa dentro del capítulo
    final scrollInChapter =
        (scrollOffset - chapterStart).clamp(0.0, chapterHeight);

    // Encontrar el versículo que está más cerca del tope del viewport
    int topVerseIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < verses.length; i++) {
      // Estimar posición del versículo dentro del capítulo (asumiendo distribución uniforme)
      final versePosition = (i / verses.length) * chapterHeight;
      final distanceFromTop = (scrollInChapter - versePosition).abs();

      if (distanceFromTop < closestDistance) {
        closestDistance = distanceFromTop;
        topVerseIndex = i;
      }
    }

    // El versículo actual es el que está más arriba en el viewport
    final int topVerse = topVerseIndex + 1;
    final double progress = (topVerse / verses.length).clamp(0.0, 1.0);

    setState(() {
      _currentVerse = topVerse;
      _currentProgress = progress;
    });
  }

  void _calculateChapterProgress(
      int chapterIndex, double scrollOffset, double viewportHeight) {
    final chapter = _chapters[chapterIndex];
    final content = chapter['content']?.toString() ?? '';
    final chapterHeight = _chapterHeights[chapterIndex] ?? viewportHeight;
    final chapterStart = _getChapterStartPosition(chapterIndex);

    final verseRegex = RegExp(r'\[(\d+)\]');
    final verses = verseRegex.allMatches(content).toList();

    if (verses.isEmpty) return;

    // Calcular progreso dentro del capítulo
    final scrollInChapter =
        (scrollOffset - chapterStart).clamp(0.0, chapterHeight);
    final progressInChapter = scrollInChapter / chapterHeight;

    final int estimatedVerse =
        (progressInChapter * verses.length).ceil().clamp(1, verses.length);
    final double progress = (estimatedVerse / verses.length).clamp(0.0, 1.0);

    setState(() {
      _currentVerse = estimatedVerse;
      _currentProgress = progress;
    });
  }

  double _getChapterStartPosition(int chapterIndex) {
    double position = 0.0;
    for (int i = 0; i < chapterIndex; i++) {
      // Si no tenemos la altura medida, usar una estimación basada en el viewport
      double chapterHeight =
          _chapterHeights[i] ?? MediaQuery.of(context).size.height * 2;
      position += chapterHeight;
    }
    return position;
  }

  Future<void> _loadInitialChapter() async {
    if (widget.initialChapterCode.isEmpty) {
      // CORREGIDO: Si no hay chapter code, limpiar flags
      setState(() {
        _isInitialScroll = false;
        isResetingAndScrolling = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await action_blocks.getPassages(context,
          chapterCode: widget.initialChapterCode);

      final chapterData = response['data'];

      setState(() {
        _chapters.add(chapterData);
        _currentChapter = chapterData['reference']?.toString() ?? '';
        _totalVerses = chapterData['verseCount'] ?? 1;
        _currentProgress = 0.0;
        _currentVerse = 1;
        _hasMoreNext = chapterData['next'] != null;
        _hasMorePrevious = chapterData['previous'] != null;
        _initialLoadCompleted = true;
      });

      // Crear keys para los capítulos
      _chapterKeys[0] = GlobalKey();
      //   if (_hasMorePrevious) {
      await _loadPreviousChapter();
      //  }

      // if (_hasMoreNext) {
      await _loadNextChapter();
      // }

      // Esperar a que se construyan los widgets y luego hacer scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToInitialVerse();
      });
    } catch (e) {
      print('Error loading initial chapter: $e');
      if (mounted) {
        setState(() {
          isResetingAndScrolling = false;
          _isInitialScroll = false;
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToInitialVerse() {
    if (_highlightedVerse == null ||
        _highlightedVerse! <= 0 ||
        _chapters.isEmpty) {
      setState(() {
        isResetingAndScrolling = false;
        _isInitialScroll = false;
      });
      return;
    }

    final chapter = _chapters[
        1]; // Capítulo actual (índice 1 después de cargar anterior y siguiente)
    final totalVerses = chapter['verseCount'] ?? 1;

    // Calcular la posición dentro del capítulo
    double positionInChapter =
        _calcularPosVerse(_highlightedVerse!, totalVerses, marginVerses: 3);

    // Calcular la posición de inicio del capítulo 1
    double chapter1Start = _getChapterStartPosition(1);

    // Calcular la altura del capítulo 1 (estimada si no está medida)
    double chapter1Height =
        _chapterHeights[1] ?? MediaQuery.of(context).size.height * 3;

    // Posición objetivo: inicio del capítulo 1 + 75% de su altura oculta
    double targetPosition =
        chapter1Start + (positionInChapter * chapter1Height);
    //     (chapter1Height * 0.75);

    //print('Scrolling to position: $targetPosition');
    //  print('Chapter 1 start: $chapter1Start');
    //  print('Position in chapter: $positionInChapter');

    _scrollController
        .animateTo(
      targetPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOut,
    )
        .then((_) {
      if (mounted) {
        setState(() {
          isResetingAndScrolling = false;
          _isInitialScroll = false;
        });
      }
    });
  }

  double _calcularPosVerse(int highlightedVerse, int totalVerses,
      {int marginVerses = 2}) {
    if (highlightedVerse <= 0 || totalVerses <= 0) {
      return 0.0;
    }

    int verseIndex = highlightedVerse - 1;
    int totalVersesIndex = totalVerses - 1;

    int targetVerseIndex =
        (verseIndex - marginVerses).clamp(0, totalVersesIndex);
    double position = targetVerseIndex / totalVersesIndex;

    return position.clamp(0.0, 1.0);
  }

  Future<void> _loadNextChapter() async {
    if (_isLoadingNext || !_hasMoreNext) return;

    final currentLastChapter = _chapters.last;
    final nextChapterInfo = currentLastChapter['next'];

    if (nextChapterInfo == null) {
      setState(() {
        _hasMoreNext = false;
      });
      return;
    }

    setState(() {
      _isLoadingNext = true;
      _lastLoadTime = DateTime.now();
    });

    try {
      // Check if next chapter is from 1ES and replace with MAT.1
      final String chapterCodeToLoad;
      if (nextChapterInfo['bookId'] == '1ES') {
        chapterCodeToLoad = 'MAT.1';
        print('Replacing 1ES.intro with MAT.1');
      } else {
        chapterCodeToLoad = nextChapterInfo['id'];
      }

      final response = await action_blocks.getPassages(context,
          chapterCode: chapterCodeToLoad);
      final chapterData = response['data'];

      print('Loaded next chapter: ${chapterData['reference']}');

      setState(() {
        _chapters.add(chapterData);
        _chapterKeys[_chapters.length - 1] = GlobalKey();
        _hasMoreNext = chapterData['next'] != null;
      });

      _markChapterJustLoaded();
    } catch (e) {
      print('Error loading next chapter: $e');
    } finally {
      setState(() {
        _isLoadingNext = false;
      });
    }
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (_isInitialScroll) {
        setState(() {
          _isInitialScroll = false;
        });
      }
      setState(() {
        //_isUserScrolling = true;
        _justLoadedChapter = false;
      });
    } else if (notification is ScrollEndNotification) {
      _scrollEndTimer?.cancel();
      _scrollEndTimer = Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _isUserScrolling = false;
            print('termino de scrolear');
          });
        }
      });
    }
  }

  /*Future<void> _loadPreviousChapter() async {
    if (_isLoadingPrevious || !_hasMorePrevious) return;

    final currentFirstChapter = _chapters.first;
    final previousChapterInfo = currentFirstChapter['previous'];

    if (previousChapterInfo == null) {
      setState(() {
        _hasMorePrevious = false;
      });
      return;
    }

    setState(() {
      _isLoadingPrevious = true;
      _lastLoadTime = DateTime.now();
    });

    try {
      // 1. Guardar la posición actual de scroll Y el capítulo actualmente visible
      await Future.delayed(Duration(milliseconds: 200));
      final double currentScrollOffset = _scrollController.offset;
      final int currentFirstVisibleChapter = _findFirstVisibleChapterIndex();

      final response = await action_blocks.getPassages(context,
          chapterCode: previousChapterInfo['id']);
      final chapterData = response['data'];

      setState(() {
        _chapters.insert(0, chapterData);
        // Actualizar todas las keys
        _chapterKeys.clear();
        for (int i = 0; i < _chapters.length; i++) {
          _chapterKeys[i] = GlobalKey();
        }
        _hasMorePrevious = chapterData['previous'] != null;
      });

      // 2. Esperar a que se construya y mida el nuevo capítulo
      await Future.delayed(Duration(milliseconds: 200));

      // 3. Calcular el NUEVO offset basado en la altura del capítulo insertado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_chapterHeights.containsKey(0)) {
          double newChapterHeight = _chapterHeights[0]!;

          // El nuevo offset debe ser: altura del nuevo capítulo + offset anterior
          double newScrollOffset = currentScrollOffset + newChapterHeight;

          //print('Adjusting scroll: $currentScrollOffset -> $newScrollOffset');

          _scrollController.jumpTo(newScrollOffset);
        } else {
          // Fallback: usar estimación y luego ajustar finamente
          double estimatedHeight = MediaQuery.of(context).size.height * 2;
          double temporaryOffset = currentScrollOffset + estimatedHeight;

          _scrollController.jumpTo(temporaryOffset);

          // Ajuste fino después de que se mida la altura real
          Future.delayed(Duration(milliseconds: 100), () {
            if (_chapterHeights.containsKey(0)) {
              double actualHeight = _chapterHeights[0]!;
              double finalOffset = currentScrollOffset + actualHeight;
              if ((finalOffset - temporaryOffset).abs() > 10) {
                _scrollController.jumpTo(finalOffset);
              }
            }
          });
        }
      });

      _markChapterJustLoaded();
    } catch (e) {
      print('Error loading previous chapter: $e');
    } finally {
      setState(() {
        _isLoadingPrevious = false;
      });
    }
  }*/

  Future<void> _loadPreviousChapter() async {
    if (_isLoadingPrevious || !_hasMorePrevious) return;

    final currentFirstChapter = _chapters.first;
    final previousChapterInfo = currentFirstChapter['previous'];

    if (previousChapterInfo == null) {
      setState(() {
        _hasMorePrevious = false;
      });
      return;
    }

    setState(() {
      _isLoadingPrevious = true;
      _lastLoadTime = DateTime.now();
    });

    try {
      // Check if previous chapter is from 2MA and replace with MAL.4
      final String chapterCodeToLoad;
      if (previousChapterInfo['bookId'] == '2MA') {
        chapterCodeToLoad = 'MAL.4';
        print('Replacing 2MA.15 with MAL.4');
      } else {
        chapterCodeToLoad = previousChapterInfo['id'];
      }

      // 1. Guardar la posición actual de scroll Y el capítulo actualmente visible
      await Future.delayed(Duration(milliseconds: 200));
      final double currentScrollOffset = _scrollController.offset;
      final int currentFirstVisibleChapter = _findFirstVisibleChapterIndex();

      final response = await action_blocks.getPassages(context,
          chapterCode: chapterCodeToLoad);
      final chapterData = response['data'];

      print('Loaded previous chapter: ${chapterData['reference']}');

      setState(() {
        _chapters.insert(0, chapterData);
        // Actualizar todas las keys
        _chapterKeys.clear();
        for (int i = 0; i < _chapters.length; i++) {
          _chapterKeys[i] = GlobalKey();
        }
        _hasMorePrevious = chapterData['previous'] != null;
      });

      // 2. Esperar a que se construya y mida el nuevo capítulo
      await Future.delayed(Duration(milliseconds: 200));

      // 3. Calcular el NUEVO offset basado en la altura del capítulo insertado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_chapterHeights.containsKey(0)) {
          double newChapterHeight = _chapterHeights[0]!;

          // El nuevo offset debe ser: altura del nuevo capítulo + offset anterior
          double newScrollOffset = currentScrollOffset + newChapterHeight;

          _scrollController.jumpTo(newScrollOffset);
        } else {
          // Fallback: usar estimación y luego ajustar finamente
          double estimatedHeight = MediaQuery.of(context).size.height * 2;
          double temporaryOffset = currentScrollOffset + estimatedHeight;

          _scrollController.jumpTo(temporaryOffset);

          // Ajuste fino después de que se mida la altura real
          Future.delayed(Duration(milliseconds: 100), () {
            if (_chapterHeights.containsKey(0)) {
              double actualHeight = _chapterHeights[0]!;
              double finalOffset = currentScrollOffset + actualHeight;
              if ((finalOffset - temporaryOffset).abs() > 10) {
                _scrollController.jumpTo(finalOffset);
              }
            }
          });
        }
      });

      _markChapterJustLoaded();
    } catch (e) {
      print('Error loading previous chapter: $e');
    } finally {
      setState(() {
        _isLoadingPrevious = false;
      });
    }
  }

// Función para encontrar el índice del primer capítulo visible
  int _findFirstVisibleChapterIndex() {
    final scrollOffset = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;

    for (int i = 0; i < _chapters.length; i++) {
      final chapterStart = _getChapterStartPosition(i);
      final chapterHeight = _chapterHeights[i] ?? viewportHeight;
      final chapterEnd = chapterStart + chapterHeight;

      // Si cualquier parte del capítulo está visible
      if (scrollOffset < chapterEnd &&
          scrollOffset + viewportHeight > chapterStart) {
        return i;
      }
    }
    return 0;
  }

  // Widget para medir la altura de cada capítulo
// Widget para medir la altura de cada capítulo
  Widget _buildMeasuredChapterContent(int index, Map<String, dynamic> chapter) {
    return LayoutBuilder(
      key: _chapterKeys[index],
      builder: (context, constraints) {
        // Medir la altura después de que se construya
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = _chapterKeys[index]!.currentContext;
          if (context != null && context.mounted) {
            final RenderBox? renderBox =
                context.findRenderObject() as RenderBox?;
            if (renderBox != null && renderBox.hasSize) {
              final height = renderBox.size.height;
              if (_chapterHeights[index] != height) {
                setState(() {
                  _chapterHeights[index] = height;
                });
                // print('Chapter $index height: ${height.toStringAsFixed(1)}');
              }
            }
          }
        });

        return _buildChapterContent(chapter);
      },
    );
  }

  Widget _buildChapterContent(Map<String, dynamic> chapter) {
    final content = chapter['content']?.toString() ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildParagraphWithVerses(content, chapter),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  //////
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * progress,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 148, 92, 19),
                        Color.fromARGB(255, 190, 140, 70),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return widget.header(
      _currentChapter.isNotEmpty ? _currentChapter : 'Loading...',
    );
    /* return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        /*border: Border(
          bottom: BorderSide(
            color: FlutterFlowTheme.of(context).baseForeground,
            width: 2,
          ),
        ),*/
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _currentChapter.isNotEmpty ? _currentChapter : 'Loading...',
                  style: TextStyle(
                    fontSize: FlutterFlowTheme.of(context).bodySmall.fontSize,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.of(context).baseForeground,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_isLoadingPrevious || _isLoadingNext || _isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).baseForeground,
                    ),
                  ),
                ),
            ],
          ),
          //Progress Bar Don't Delete
          //const SizedBox(height: 8),
          //_buildProgressBar(_currentProgress),
          //const SizedBox(height: 4),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Verse $_currentVerse',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(_currentProgress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),*/
        ],
      ),
    );*/
  }

  Widget _buildParagraphWithVerses(
      String content, Map<String, dynamic> chapter) {
    final cleanedContent = _removeChapterNumber(content);
    final verses = cleanedContent.split(RegExp(r'(?=\[\d+\])'));

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          height: 1.6,
        ),
        children: _buildTextSpans(verses, chapter),
      ),
      textAlign: TextAlign.justify,
    );
  }

  // Función auxiliar para obtener color de texto según tema
  Color getTextColor(bool isVerseNumber) {
    if (widget.theme == 'light') {
      return isVerseNumber
          ? FlutterFlowTheme.of(context).primary
          : FlutterFlowTheme.of(context).bodyMedium?.color ?? Colors.black;
    } else if (widget.theme == 'sephia') {
      return isVerseNumber
          ? Color.fromARGB(255, 211, 165, 108) // Marrón para números en sépia
          : Color(0xFF5D4037); // Marrón oscuro para texto en sépia
    } else {
      // dark theme
      return isVerseNumber
          ? Color(0xFFD4B896) // Color sépia claro para números en dark
          : Colors.white; // Blanco para texto del versículo en dark
    }
  }

  String _removeChapterNumber(
    String content,
  ) {
    final chapterNumberRegex = RegExp(r'^\d+\s*\n\s*');
    return content.replaceFirst(chapterNumberRegex, '');
  }

  // NEW: Function to extract verse content
  String _extractVerseContent(String verseText) {
    // Remove verse number marker and any leading/trailing whitespace
    return verseText.replaceAll(RegExp(r'^\[\d+\]\s*'), '').trim();
  }

  void _handleVerseTap(
      String verseNumber, String verseContent, String chapter) {
    if (widget.tapVerse != null) {
      // Find the current chapter data to get the full content
      final currentChapter = _chapters.firstWhere(
        (chapterData) => chapterData['reference']?.toString() == chapter,
        orElse: () => _chapters.isNotEmpty ? _chapters[0] : {},
      );

      final fullChapterContent = currentChapter['content']?.toString() ?? '';

      widget.tapVerse!(verseNumber, verseContent, chapter, fullChapterContent);
    }
  }

  List<TextSpan> _buildTextSpans(
      List<String> verses, Map<String, dynamic> chapter) {
    final List<TextSpan> spans = [];
    final verseRegex = RegExp(r'\[(\d+)\]\s*');

    // Obtener el código/referencia del chapter actual
    final currentChapterRef = chapter['reference']?.toString() ?? '';
    final currentChapterCode = chapter['id']?.toString() ?? '';

    for (final verse in verses) {
      if (verse.isEmpty) continue;

      if (verseRegex.hasMatch(verse)) {
        final match = verseRegex.firstMatch(verse);
        final verseNumber = match?.group(1) ?? '';
        final verseText = verse.substring(match?.end ?? 0);
        final currentVerseNum = int.tryParse(verseNumber) ?? 0;

        // Extract the verse content without the number
        final verseContent = _extractVerseContent(verse);

        // Verificar si este es el verse que debe estar resaltado
        final bool isHighlighted = currentVerseNum == _highlightedVerse &&
            (widget.initialChapterCode == currentChapterCode ||
                widget.initialChapterCode == currentChapterRef);

        // Create verse number span with tap gesture
        spans.add(
          TextSpan(
            text: ' $verseNumber ',
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _handleVerseTap(verseNumber, verseContent, currentChapterRef);
              },
          ),
        );

        // Create verse content span with tap gesture
        spans.add(
          TextSpan(
            text: verseText.replaceAll('¶', ''),
            style: widget.font == 'tienne'
                ? GoogleFonts.tienne(
                    color: getTextColor(false),
                    fontSize: widget.fontSize,
                    height: 1.6,
                    backgroundColor: isHighlighted
                        ? Colors.yellow.withOpacity(0.3)
                        : Colors.transparent,
                    fontWeight:
                        isHighlighted ? FontWeight.bold : FontWeight.normal,
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _handleVerseTap(verseNumber, verseContent, currentChapterRef);
              },
          ),
        );
      } else {
        final cleanedText = verse.replaceAll('¶', '\n\n');
        spans.add(TextSpan(text: cleanedText));
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              color: widget.theme == 'light'
                  ? FlutterFlowTheme.of(context).secondaryBackground
                  : widget.theme == 'sephia'
                      ? Color(0xFFF4ECD8) // Color sépia
                      : Color.fromARGB(255, 0, 0, 0), // Dark
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  _handleScrollNotification(notification);
                  return false;
                },
                child: _isLoading && _chapters.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).baseForeground))
                    : Stack(
                        children: [
                          CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              // Capítulos
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return _buildMeasuredChapterContent(
                                        index, _chapters[index]);
                                  },
                                  childCount: _chapters.length,
                                ),
                              ),
                              // Loading indicators en la lista
                              if (_isLoadingNext)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .baseForeground),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          //Don't delete
                          // Indicador de carga anterior flotante
                          /*if (_isLoadingPrevious)
                            Positioned(
                              top: 10,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(255, 148, 92, 19),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Loading previous chapter...',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 148, 92, 19),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                          // Indicador de carga siguiente flotante
                          /*if (_isLoadingNext)
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(255, 148, 92, 19),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Loading next chapter...',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 148, 92, 19),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
