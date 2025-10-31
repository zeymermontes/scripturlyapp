import '/components/drop_down_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'books_index_widget.dart' show BooksIndexWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BooksIndexModel extends FlutterFlowModel<BooksIndexWidget> {
  ///  Local state fields for this component.

  bool horizontal = true;

  int? gridColumns = 5;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // Model for dropDown component.
  late DropDownModel dropDownModel1;
  // Model for dropDown component.
  late DropDownModel dropDownModel2;

  @override
  void initState(BuildContext context) {
    dropDownModel1 = createModel(context, () => DropDownModel());
    dropDownModel2 = createModel(context, () => DropDownModel());
  }

  @override
  void dispose() {
    expandableExpandableController1.dispose();
    expandableExpandableController3.dispose();
    dropDownModel1.dispose();
    dropDownModel2.dispose();
  }
}
