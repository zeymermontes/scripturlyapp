import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'on_borad2_model.dart';
export 'on_borad2_model.dart';

class OnBorad2Widget extends StatefulWidget {
  const OnBorad2Widget({super.key});

  static String routeName = 'onBorad2';
  static String routePath = '/onBorad2';

  @override
  State<OnBorad2Widget> createState() => _OnBorad2WidgetState();
}

class _OnBorad2WidgetState extends State<OnBorad2Widget> {
  late OnBorad2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBorad2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.onboardingHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: OnboardingHeaderWidget(
                  isSignUp: true,
                  showText: false,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '8658sdt2' /* What brings you to Scripturly? */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .baseForeground,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 40.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '35jtpw53' /* Select up to 2 options. */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .baseForeground,
                                    fontSize: 16.0,
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
                          Builder(
                            builder: (context) {
                              final onBoard1Options = _model.options.toList();

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(onBoard1Options.length,
                                    (onBoard1OptionsIndex) {
                                  final onBoard1OptionsItem =
                                      onBoard1Options[onBoard1OptionsIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (_model.selectedOptions
                                          .contains(onBoard1OptionsItem)) {
                                        _model.removeFromSelectedOptions(
                                            onBoard1OptionsItem);
                                        safeSetState(() {});
                                      } else {
                                        if (_model.selectedOptions.length < 2) {
                                          _model.addToSelectedOptions(
                                              onBoard1OptionsItem);
                                          safeSetState(() {});
                                        }
                                      }

                                      FFAppState().updateUserProfileStruct(
                                        (e) => e
                                          ..goals =
                                              _model.selectedOptions.toList(),
                                      );
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: valueOrDefault<Color>(
                                          _model.selectedOptions
                                                  .contains(onBoard1OptionsItem)
                                              ? Color(0xFFE5E5E5)
                                              : Color(0xFFF5F5F5),
                                          Color(0xFFF5F5F5),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: valueOrDefault<Color>(
                                            _model.selectedOptions.contains(
                                                    onBoard1OptionsItem)
                                                ? FlutterFlowTheme.of(context)
                                                    .baseForeground
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            Color(0xFFF5F5F5),
                                          ),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 4.0, 0.0),
                                                child: Text(
                                                  onBoard1OptionsItem,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                if (_model.selectedOptions
                                                    .contains(
                                                        onBoard1OptionsItem)) {
                                                  return Icon(
                                                    Icons.check_box_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .baseForeground,
                                                    size: 24.0,
                                                  );
                                                } else {
                                                  return Icon(
                                                    Icons
                                                        .check_box_outline_blank_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .baseInput,
                                                    size: 24.0,
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(height: 8.0)),
                              );
                            },
                          ),
                        ],
                      ),
                      FFButtonWidget(
                        onPressed: (_model.selectedOptions.length <= 0)
                            ? null
                            : () async {
                                context.pushNamed(OnBorad3Widget.routeName);
                              },
                        text: FFLocalizations.of(context).getText(
                          '46bng7uv' /* Continue */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).basePrimary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.publicSans(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .basePrimaryForeground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(99999.0),
                          disabledColor:
                              FlutterFlowTheme.of(context).baseMutedForeground,
                          disabledTextColor:
                              FlutterFlowTheme.of(context).baseSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
