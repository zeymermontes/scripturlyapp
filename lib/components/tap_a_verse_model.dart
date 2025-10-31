import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/cross_references_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tap_a_verse_widget.dart' show TapAVerseWidget;
import 'package:flutter/material.dart';

class TapAVerseModel extends FlutterFlowModel<TapAVerseWidget> {
  ///  Local state fields for this component.

  FinalOutputStruct? verseResponse;
  void updateVerseResponseStruct(Function(FinalOutputStruct) updateFn) {
    updateFn(verseResponse ??= FinalOutputStruct());
  }

  int? selectedReference;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (tapAVerse)] action in tapAVerse widget.
  ApiCallResponse? tapAverseResult;
  // Model for crossReferences component.
  late CrossReferencesModel crossReferencesModel;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  ChatsRecord? createdChatFirebase;

  @override
  void initState(BuildContext context) {
    crossReferencesModel = createModel(context, () => CrossReferencesModel());
  }

  @override
  void dispose() {
    crossReferencesModel.dispose();
  }
}
