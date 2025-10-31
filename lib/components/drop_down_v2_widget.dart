import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drop_down_v2_model.dart';
export 'drop_down_v2_model.dart';

class DropDownV2Widget extends StatefulWidget {
  const DropDownV2Widget({
    super.key,
    bool? oldTestament,
    required this.onSelection,
  }) : this.oldTestament = oldTestament ?? true;

  final bool oldTestament;
  final Future Function(String bookName, String bookId, List<String> chapters)?
      onSelection;

  @override
  State<DropDownV2Widget> createState() => _DropDownV2WidgetState();
}

class _DropDownV2WidgetState extends State<DropDownV2Widget> {
  late DropDownV2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownV2Model());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!FFAppState().keepExpandedState) {
        _model.expanded = false;
        _model.selectedBook = null;
        safeSetState(() {});
      }
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

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
      width: double.infinity,
      height: valueOrDefault<double>(
        _model.expanded
            ? valueOrDefault<double>(
                (32.0 *
                        valueOrDefault<int>(
                          functions
                              .returnBooksOfTestament(
                                  FFAppState().books.data.toList(),
                                  widget.oldTestament)
                              ?.length,
                          0,
                        )) +
                    40,
                40.0,
              )
            : 40.0,
        40.0,
      ),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    () {
                      if (FFAppState().selectedlanguage == Languages.eng) {
                        return (widget.oldTestament
                            ? 'Old Testament'
                            : 'New Testament');
                      } else if (FFAppState().selectedlanguage ==
                          Languages.spa) {
                        return (widget.oldTestament
                            ? 'Antiguo Testamento'
                            : 'Nuevo Testamento');
                      } else {
                        return '-';
                      }
                    }(),
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.publicSans(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
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
              if (_model.expanded) {
                return Builder(
                  builder: (context) {
                    final books = functions
                            .returnBooksOfTestament(
                                FFAppState().books.data.toList(),
                                widget.oldTestament)
                            ?.map((e) => e)
                            .toList()
                            .toList() ??
                        [];

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(books.length, (booksIndex) {
                        final booksItem = books[booksIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedBook = booksItem.id;
                                  safeSetState(() {});
                                  FFAppState().keepExpandedState = true;
                                  safeSetState(() {});
                                  await widget.onSelection?.call(
                                    booksItem.name,
                                    booksItem.id,
                                    booksItem.chapters
                                        .where((e) => e.number != 'intro')
                                        .toList()
                                        .map((e) => e.number)
                                        .toList(),
                                  );
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    color: _model.selectedBook == booksItem.id
                                        ? Color(0xFFF5F5F5)
                                        : FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          functions.translateBookName(
                                              booksItem.name, () {
                                            if (FFAppState().selectedlanguage ==
                                                Languages.spa) {
                                              return true;
                                            } else if (FFAppState()
                                                    .selectedlanguage ==
                                                Languages.eng) {
                                              return false;
                                            } else {
                                              return false;
                                            }
                                          }()),
                                          '-',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
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
                            ),
                          ],
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
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
