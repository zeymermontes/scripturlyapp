import '/components/drop_down_v2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'side_bar_v2_widget.dart' show SideBarV2Widget;
import 'package:flutter/material.dart';

class SideBarV2Model extends FlutterFlowModel<SideBarV2Widget> {
  ///  Local state fields for this component.

  String? selectedBookName;

  String? selectedBookID;

  String? selectedChapter;

  String? selectedVerse;

  List<String> selectedChapters = [];
  void addToSelectedChapters(String item) => selectedChapters.add(item);
  void removeFromSelectedChapters(String item) => selectedChapters.remove(item);
  void removeAtIndexFromSelectedChapters(int index) =>
      selectedChapters.removeAt(index);
  void insertAtIndexInSelectedChapters(int index, String item) =>
      selectedChapters.insert(index, item);
  void updateSelectedChaptersAtIndex(int index, Function(String) updateFn) =>
      selectedChapters[index] = updateFn(selectedChapters[index]);

  int segments = 5;

  List<int> availableVerses = [];
  void addToAvailableVerses(int item) => availableVerses.add(item);
  void removeFromAvailableVerses(int item) => availableVerses.remove(item);
  void removeAtIndexFromAvailableVerses(int index) =>
      availableVerses.removeAt(index);
  void insertAtIndexInAvailableVerses(int index, int item) =>
      availableVerses.insert(index, item);
  void updateAvailableVersesAtIndex(int index, Function(int) updateFn) =>
      availableVerses[index] = updateFn(availableVerses[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for dropDownV2 component.
  late DropDownV2Model dropDownV2Model1;
  // Model for dropDownV2 component.
  late DropDownV2Model dropDownV2Model2;

  @override
  void initState(BuildContext context) {
    dropDownV2Model1 = createModel(context, () => DropDownV2Model());
    dropDownV2Model2 = createModel(context, () => DropDownV2Model());
  }

  @override
  void dispose() {
    dropDownV2Model1.dispose();
    dropDownV2Model2.dispose();
  }
}
