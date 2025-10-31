import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/BibleBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verses_pop_up_model.dart';
export 'verses_pop_up_model.dart';

class VersesPopUpWidget extends StatefulWidget {
  const VersesPopUpWidget({
    super.key,
    required this.selectedChapter,
    required this.selectedBook,
    required this.segments,
    required this.aligment,
    required this.chapterCode,
  });

  final int? selectedChapter;
  final String? selectedBook;
  final int? segments;
  final double? aligment;
  final String? chapterCode;

  @override
  State<VersesPopUpWidget> createState() => _VersesPopUpWidgetState();
}

class _VersesPopUpWidgetState extends State<VersesPopUpWidget> {
  late VersesPopUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VersesPopUpModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.versesState = BibleService.getVersesForChapter(
        widget.selectedBook!,
        widget.selectedChapter!,
      ).toList().cast<int>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        Navigator.pop(context);
      },
      child: Container(
        width: _model.width,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(
                  valueOrDefault<double>(
                    widget.aligment,
                    0.0,
                  ),
                  -1.0),
              child: Container(
                width: valueOrDefault<double>(
                  (_model.width!) /
                      valueOrDefault<int>(
                        widget.segments,
                        5,
                      ),
                  50.0,
                ),
                height: valueOrDefault<double>(
                  (_model.width!) /
                      valueOrDefault<int>(
                        widget.segments,
                        5,
                      ),
                  50.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.selectedChapter?.toString(),
                      '-',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
            ),
            Container(
              width: () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return MediaQuery.sizeOf(context).width;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return MediaQuery.sizeOf(context).width;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return _model.width;
                } else {
                  return _model.width;
                }
              }(),
              height:
                  ((_model.versesState.length / (widget.segments!)).ceil() *
                          ((_model.width!) / (widget.segments!))) +
                      20,
              constraints: BoxConstraints(
                maxHeight: 1000.0,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(0.0),
              ),
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'rqjgc0sp' /* Select a verse: */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final verses = _model.versesState.toList();

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: valueOrDefault<int>(
                                widget.segments,
                                5,
                              ),
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            itemCount: verses.length,
                            itemBuilder: (context, versesIndex) {
                              final versesItem = verses[versesIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await action_blocks.getPassages(
                                    context,
                                    chapterCode: widget.chapterCode,
                                    verse: versesItem,
                                  );
                                  FFAppState().selectedChapterCode =
                                      widget.chapterCode!;
                                  FFAppState().selectedVerse = versesItem;
                                  FFAppState().update(() {});
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  versesItem.toString(),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
