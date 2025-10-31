import '/backend/schema/structs/index.dart';
import '/components/verses_pop_up_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chapter_drop_down_model.dart';
export 'chapter_drop_down_model.dart';

class ChapterDropDownWidget extends StatefulWidget {
  const ChapterDropDownWidget({
    super.key,
    required this.book,
    int? segments,
    required this.chapters,
  }) : this.segments = segments ?? 5;

  final String? book;
  final int segments;
  final List<ChaptersStruct>? chapters;

  @override
  State<ChapterDropDownWidget> createState() => _ChapterDropDownWidgetState();
}

class _ChapterDropDownWidgetState extends State<ChapterDropDownWidget> {
  late ChapterDropDownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChapterDropDownModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.expanded = false;
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
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.expanded = !_model.expanded;
                safeSetState(() {});
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.book!,
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.publicSans(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                  ),
                  Builder(
                    builder: (context) {
                      if (_model.expanded) {
                        return FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            _model.expanded = !_model.expanded;
                            safeSetState(() {});
                          },
                        );
                      } else {
                        return FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.keyboard_arrow_up_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            _model.expanded = !_model.expanded;
                            safeSetState(() {});
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                if (_model.expanded) {
                  return Builder(
                    builder: (context) {
                      final chapters = widget.chapters!
                          .where((e) => e.number != 'intro')
                          .toList();

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.segments,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: chapters.length,
                        itemBuilder: (context, chaptersIndex) {
                          final chaptersItem = chapters[chaptersIndex];
                          return Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Builder(
                              builder: (context) => InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showAlignedDialog(
                                    context: context,
                                    isGlobal: false,
                                    avoidOverflow: true,
                                    targetAnchor: AlignmentDirectional(
                                            0.0, -1.0)
                                        .resolve(Directionality.of(context)),
                                    followerAnchor: AlignmentDirectional(
                                            valueOrDefault<double>(
                                              functions.normalicePositionCenter(
                                                  functions.returnPosition(
                                                      widget.segments,
                                                      chaptersIndex + 1)!,
                                                  widget.segments),
                                              0.0,
                                            ),
                                            -1.0)
                                        .resolve(Directionality.of(context)),
                                    builder: (dialogContext) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: VersesPopUpWidget(
                                          selectedChapter: chaptersIndex + 1,
                                          selectedBook: widget.book!,
                                          segments: widget.segments,
                                          aligment:
                                              functions.normalicePositionSide(
                                                  functions.returnPosition(
                                                      widget.segments,
                                                      chaptersIndex + 1)!,
                                                  widget.segments),
                                          chapterCode: chaptersItem.id,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: valueOrDefault<double>(
                                    252.0 / widget.segments,
                                    50.0,
                                  ),
                                  height: valueOrDefault<double>(
                                    252.0 / widget.segments,
                                    50.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      chaptersItem.number,
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
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Container(
                    width: 0.0,
                    height: 0.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
