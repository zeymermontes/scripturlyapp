import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_password_copy_widget.dart' show ResetPasswordCopyWidget;
import 'package:flutter/material.dart';

class ResetPasswordCopyModel extends FlutterFlowModel<ResetPasswordCopyWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for onboardingHeader component.
  late OnboardingHeaderModel onboardingHeaderModel;
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'tfiagcc7' /* Email address is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? formValidation;

  @override
  void initState(BuildContext context) {
    onboardingHeaderModel = createModel(context, () => OnboardingHeaderModel());
    emailTextControllerValidator = _emailTextControllerValidator;
  }

  @override
  void dispose() {
    onboardingHeaderModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
