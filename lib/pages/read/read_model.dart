import '/components/header_widget.dart';
import '/components/side_bar_v2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'read_widget.dart' show ReadWidget;
import 'package:flutter/material.dart';

class ReadModel extends FlutterFlowModel<ReadWidget> {
  ///  Local state fields for this page.

  String? text;

  bool listVersion = true;

  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // Model for sideBarV2 component.
  late SideBarV2Model sideBarV2Model;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    sideBarV2Model = createModel(context, () => SideBarV2Model());
  }

  @override
  void dispose() {
    headerModel.dispose();
    sideBarV2Model.dispose();
  }
}
