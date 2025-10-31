import '/flutter_flow/flutter_flow_util.dart';
import 'verses_pop_up_widget.dart' show VersesPopUpWidget;
import 'package:flutter/material.dart';

class VersesPopUpModel extends FlutterFlowModel<VersesPopUpWidget> {
  ///  Local state fields for this component.

  double? width = 252.0;

  List<int> versesState = [];
  void addToVersesState(int item) => versesState.add(item);
  void removeFromVersesState(int item) => versesState.remove(item);
  void removeAtIndexFromVersesState(int index) => versesState.removeAt(index);
  void insertAtIndexInVersesState(int index, int item) =>
      versesState.insert(index, item);
  void updateVersesStateAtIndex(int index, Function(int) updateFn) =>
      versesState[index] = updateFn(versesState[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
