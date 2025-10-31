import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_borad2_widget.dart' show OnBorad2Widget;
import 'package:flutter/material.dart';

class OnBorad2Model extends FlutterFlowModel<OnBorad2Widget> {
  ///  Local state fields for this page.

  List<String> selectedOptions = [];
  void addToSelectedOptions(String item) => selectedOptions.add(item);
  void removeFromSelectedOptions(String item) => selectedOptions.remove(item);
  void removeAtIndexFromSelectedOptions(int index) =>
      selectedOptions.removeAt(index);
  void insertAtIndexInSelectedOptions(int index, String item) =>
      selectedOptions.insert(index, item);
  void updateSelectedOptionsAtIndex(int index, Function(String) updateFn) =>
      selectedOptions[index] = updateFn(selectedOptions[index]);

  List<String> options = [
    'To understand the Bible better',
    'To build a consistent daily habit',
    'To find comfort and guidance',
    'To learn the foundations of Christianity'
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
