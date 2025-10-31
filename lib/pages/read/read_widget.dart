import '/components/header_widget.dart';
import '/components/reader_header_widget.dart';
import '/components/side_bar_v2_widget.dart';
import '/components/tap_a_verse_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'read_model.dart';
export 'read_model.dart';

class ReadWidget extends StatefulWidget {
  const ReadWidget({super.key});

  static String routeName = 'Read';
  static String routePath = '/homePage';

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  late ReadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReadModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await action_blocks.checkUser(context);
      await action_blocks.checkEdgeToEdge(context);
      safeSetState(() {});
      if (FFAppState().books.data.length > 0) {
      } else {
        await action_blocks.setBooks(context);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: Container(
            width: 300.0,
            child: Drawer(
              elevation: 16.0,
              child: wrapWithModel(
                model: _model.sideBarV2Model,
                updateCallback: () => safeSetState(() {}),
                child: SideBarV2Widget(),
              ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: HeaderWidget(
                    leftAction: () async {
                      scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height -
                      50 -
                      (FFAppState().isEdgeToEdge ? 80.0 : 0.0) -
                      0.0,
                  child: custom_widgets.BibleInfiniteScroll(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height -
                        50 -
                        (FFAppState().isEdgeToEdge ? 80.0 : 0.0) -
                        0.0,
                    initialChapterCode: valueOrDefault<String>(
                      FFAppState().selectedChapterCode,
                      'GEN.1',
                    ),
                    initialVerse: FFAppState().selectedVerse,
                    fontSize: valueOrDefault<double>(
                      FFAppState().readersettings.size,
                      12.0,
                    ),
                    font: valueOrDefault<String>(
                      FFAppState().readersettings.font,
                      'inter',
                    ),
                    theme: valueOrDefault<String>(
                      FFAppState().readersettings.theme,
                      'light',
                    ),
                    tapVerse: (verseNumber, verseContent, chapter,
                        chapterContent) async {
                      await actions.debug(
                        '${chapter}, verse ${verseNumber}:       ${verseContent}',
                      );
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: TapAVerseWidget(
                                verse: verseNumber,
                                verseContent: functions
                                    .removeParragraphSymbol(verseContent)!,
                                chapter: chapter,
                                chapterContent: chapterContent,
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    header: (String chapter) => ReaderHeaderWidget(
                      chapter: chapter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
