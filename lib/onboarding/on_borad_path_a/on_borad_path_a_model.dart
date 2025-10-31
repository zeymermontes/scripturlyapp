import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_borad_path_a_widget.dart' show OnBoradPathAWidget;
import 'package:flutter/material.dart';

class OnBoradPathAModel extends FlutterFlowModel<OnBoradPathAWidget> {
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
    'Finding Purpose',
    'Dealing with Anxiety',
    'Building Stronger Faith',
    'Understanding Relationships',
    'Leadership & Wisdom'
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
