import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'policy_widget.dart' show PolicyWidget;
import 'package:flutter/material.dart';

class PolicyModel extends FlutterFlowModel<PolicyWidget> {
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
