import '/components/books_index_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'side_bar_widget.dart' show SideBarWidget;
import 'package:flutter/material.dart';

class SideBarModel extends FlutterFlowModel<SideBarWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for BooksIndex component.
  late BooksIndexModel booksIndexModel;

  @override
  void initState(BuildContext context) {
    booksIndexModel = createModel(context, () => BooksIndexModel());
  }

  @override
  void dispose() {
    booksIndexModel.dispose();
  }
}
