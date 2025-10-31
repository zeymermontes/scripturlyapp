import '/components/chapter_drop_down_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drop_down_model.dart';
export 'drop_down_model.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    int? segments,
    bool? oldTestament,
  })  : this.segments = segments ?? 5,
        this.oldTestament = oldTestament ?? true;

  final int segments;
  final bool oldTestament;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late DropDownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownModel());

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
    context.watch<FFAppState>();

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
                    widget.oldTestament ? 'Old Testament' : 'New Testament',
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
                            _model.expanded = false;
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
                            _model.expanded = true;
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
                if (widget.oldTestament) {
                  return Builder(
                    builder: (context) {
                      if (_model.expanded) {
                        return Builder(
                          builder: (context) {
                            final oldTestamentBooks = functions
                                    .returnBooksOfTestament(
                                        FFAppState().books.data.toList(), true)
                                    ?.map((e) => e)
                                    .toList()
                                    .toList() ??
                                [];

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(oldTestamentBooks.length,
                                  (oldTestamentBooksIndex) {
                                final oldTestamentBooksItem =
                                    oldTestamentBooks[oldTestamentBooksIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!(FFAppState().books != null)) {
                                      await action_blocks.setBooks(context);
                                    }
                                  },
                                  child: ChapterDropDownWidget(
                                    key: Key(
                                        'Keyg8u_${oldTestamentBooksIndex}_of_${oldTestamentBooks.length}'),
                                    book: oldTestamentBooksItem.name,
                                    segments: valueOrDefault<int>(
                                      widget.segments,
                                      5,
                                    ),
                                    chapters: oldTestamentBooksItem.chapters,
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      } else {
                        return Container(
                          width: 0.0,
                          height: 0.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Builder(
                    builder: (context) {
                      if (_model.expanded) {
                        return Builder(
                          builder: (context) {
                            final newTestamentBooks = functions
                                    .returnBooksOfTestament(
                                        FFAppState().books.data.toList(), false)
                                    ?.map((e) => e)
                                    .toList()
                                    .toList() ??
                                [];

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(newTestamentBooks.length,
                                  (newTestamentBooksIndex) {
                                final newTestamentBooksItem =
                                    newTestamentBooks[newTestamentBooksIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!(FFAppState().books != null)) {
                                      await action_blocks.setBooks(context);
                                    }
                                  },
                                  child: ChapterDropDownWidget(
                                    key: Key(
                                        'Keyd64_${newTestamentBooksIndex}_of_${newTestamentBooks.length}'),
                                    book: newTestamentBooksItem.name,
                                    segments: valueOrDefault<int>(
                                      widget.segments,
                                      5,
                                    ),
                                    chapters: newTestamentBooksItem.chapters,
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      } else {
                        return Container(
                          width: 0.0,
                          height: 0.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        );
                      }
                    },
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
