import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_borad_path_b_widget.dart' show OnBoradPathBWidget;
import 'package:flutter/material.dart';

class OnBoradPathBModel extends FlutterFlowModel<OnBoradPathBWidget> {
  ///  Local state fields for this page.

  BiblesStruct? selectedOption;
  void updateSelectedOptionStruct(Function(BiblesStruct) updateFn) {
    updateFn(selectedOption ??= BiblesStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for onboardingHeader component.
  late OnboardingHeaderModel onboardingHeaderModel;

  @override
  void initState(BuildContext context) {
    onboardingHeaderModel = createModel(context, () => OnboardingHeaderModel());
  }

  @override
  void dispose() {
    onboardingHeaderModel.dispose();
  }
}
