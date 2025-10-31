import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_borad1_widget.dart' show OnBorad1Widget;
import 'package:flutter/material.dart';

class OnBorad1Model extends FlutterFlowModel<OnBorad1Widget> {
  ///  Local state fields for this page.

  String? selectedOption;

  List<String> options = [
    'I\'m just starting out and curious to learn.',
    'I\'ve read some before, but want to be more consistent.',
    'I read it regularly and want to go deeper.'
  ];
  void addToOptions(String item) => options.add(item);
  void removeFromOptions(String item) => options.remove(item);
  void removeAtIndexFromOptions(int index) => options.removeAt(index);
  void insertAtIndexInOptions(int index, String item) =>
      options.insert(index, item);
  void updateOptionsAtIndex(int index, Function(String) updateFn) =>
      options[index] = updateFn(options[index]);

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
