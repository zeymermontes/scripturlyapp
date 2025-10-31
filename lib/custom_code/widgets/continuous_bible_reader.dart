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

class BibleVerse {
  final int number;
  final String text;

  BibleVerse({required this.number, required this.text});
}

class BibleParagraph {
  final List<BibleVerse> verses;
  final bool isNewParagraph;

  BibleParagraph({required this.verses, this.isNewParagraph = false});

  static List<BibleParagraph> parseContent(String content) {
    final List<BibleParagraph> paragraphs = [];
    final List<BibleVerse> currentParagraph = [];

    // Separar por líneas y procesar
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
            verses: List.from(currentParagraph), isNewParagraph: true));
        currentParagraph.clear();
      }

      // Procesar versos en esta línea
      final verseMatches =
          RegExp(r'\[(\d+)\](.*?)(?=\[\d+\]|$)').allMatches(trimmedLine);

      for (final match in verseMatches) {
        if (match.groupCount >= 2) {
          final number = int.parse(match.group(1)!);
          String text = match.group(2)!.trim();

          // Limpiar el texto
          text = text.replaceAll('¶', '').trim();

          currentParagraph.add(BibleVerse(number: number, text: text));
        }
      }
    }

    // Agregar el último párrafo
    if (currentParagraph.isNotEmpty) {
      paragraphs.add(BibleParagraph(verses: currentParagraph));
    }

    return paragraphs;
  }
}

class ContinuousBibleReader extends StatefulWidget {
  const ContinuousBibleReader({
    super.key,
    this.width,
    this.height,
    required this.apiContent,
    this.highlightedVerse, // Nuevo parámetro para el verso a resaltar
  });

  final double? width;
  final double? height;
  final String apiContent;
  final int? highlightedVerse; // Puede ser null si no hay verso resaltado

  @override
  State<ContinuousBibleReader> createState() => _ContinuousBibleReaderState();
}

class _ContinuousBibleReaderState extends State<ContinuousBibleReader> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _verseKeys = {};
  List<BibleParagraph> _paragraphs = [];
  int? _currentHighlightedVerse;

  @override
  void initState() {
    super.initState();
    _currentHighlightedVerse = widget.highlightedVerse;
    _processContent();

    // Scroll automático al verso resaltado cuando se carga
    if (_currentHighlightedVerse != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToVerse(_currentHighlightedVerse!);
      });
    }
  }

  void _processContent() {
    try {
      _paragraphs = BibleParagraph.parseContent(widget.apiContent);

      // Crear keys para cada verso
      for (final paragraph in _paragraphs) {
        for (final verse in paragraph.verses) {
          _verseKeys[verse.number] = GlobalKey();
        }
      }
    } catch (e) {
      print('Error processing Bible content: $e');
      _paragraphs = [];
    }
  }

  void _scrollToVerse(int verseNumber) {
    final key = _verseKeys[verseNumber];
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

  void _highlightVerse(int verseNumber) {
    setState(() {
      _currentHighlightedVerse = verseNumber;
    });
    _scrollToVerse(verseNumber);
  }

  Widget _buildVerseNumber(int number) {
    final isHighlighted = number == _currentHighlightedVerse;

    return Container(
      key: _verseKeys[number],
      margin: const EdgeInsets.only(right: 4.0),
      child: Text(
        '[${number}]',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isHighlighted
              ? Colors.white
              : FlutterFlowTheme.of(context).primary,
          fontSize: 14,
          backgroundColor: isHighlighted
              ? FlutterFlowTheme.of(context).primary
              : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildVerseContainer(BibleVerse verse) {
    final isHighlighted = verse.number == _currentHighlightedVerse;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: isHighlighted
          ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
          : EdgeInsets.zero,
      decoration: isHighlighted
          ? BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.5,
              ),
            )
          : null,
      child: RichText(
        text: TextSpan(
          style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                fontSize: 16,
                height: 1.6,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
          children: [
            WidgetSpan(
              child: _buildVerseNumber(verse.number),
            ),
            TextSpan(
              text: verse.text,
              style: TextStyle(
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
                color: isHighlighted
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            const TextSpan(text: ' '), // Espacio entre versos
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _paragraphs.isEmpty
          ? Center(
              child: Text(
                'Loading Bible content...',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            )
          : Column(
              children: [
                // Selector de versos con highlight
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _paragraphs.expand((p) => p.verses).length,
                    itemBuilder: (context, index) {
                      final allVerses =
                          _paragraphs.expand((p) => p.verses).toList();
                      final verse = allVerses[index];
                      final isHighlighted =
                          verse.number == _currentHighlightedVerse;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: InkWell(
                          onTap: () => _highlightVerse(verse.number),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isHighlighted
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isHighlighted
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context).alternate,
                                width: isHighlighted ? 2.0 : 1.0,
                              ),
                            ),
                            child: Text(
                              '${verse.number}',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  ?.copyWith(
                                    color: isHighlighted
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context).primary,
                                    fontWeight: isHighlighted
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                // Contenido bíblico
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _paragraphs.map((paragraph) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: paragraph.isNewParagraph ? 20.0 : 12.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: paragraph.verses.map((verse) {
                              return _buildVerseContainer(verse);
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void didUpdateWidget(ContinuousBibleReader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.apiContent != widget.apiContent) {
      _processContent();
    }

    if (oldWidget.highlightedVerse != widget.highlightedVerse) {
      setState(() {
        _currentHighlightedVerse = widget.highlightedVerse;
      });

      // Scroll automático cuando cambia el verso resaltado
      if (widget.highlightedVerse != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToVerse(widget.highlightedVerse!);
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
