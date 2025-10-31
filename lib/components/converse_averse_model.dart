import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'converse_averse_widget.dart' show ConverseAverseWidget;
import 'package:flutter/material.dart';

class ConverseAverseModel extends FlutterFlowModel<ConverseAverseWidget> {
  ///  Local state fields for this component.

  List<ChatStruct> chat = [];
  void addToChat(ChatStruct item) => chat.add(item);
  void removeFromChat(ChatStruct item) => chat.remove(item);
  void removeAtIndexFromChat(int index) => chat.removeAt(index);
  void insertAtIndexInChat(int index, ChatStruct item) =>
      chat.insert(index, item);
  void updateChatAtIndex(int index, Function(ChatStruct) updateFn) =>
      chat[index] = updateFn(chat[index]);

  List<FinalOutputStruct> formatedChat = [];
  void addToFormatedChat(FinalOutputStruct item) => formatedChat.add(item);
  void removeFromFormatedChat(FinalOutputStruct item) =>
      formatedChat.remove(item);
  void removeAtIndexFromFormatedChat(int index) => formatedChat.removeAt(index);
  void insertAtIndexInFormatedChat(int index, FinalOutputStruct item) =>
      formatedChat.insert(index, item);
  void updateFormatedChatAtIndex(
          int index, Function(FinalOutputStruct) updateFn) =>
      formatedChat[index] = updateFn(formatedChat[index]);

  bool generatings = true;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (converseAVerse)] action in converseAverse widget.
  ApiCallResponse? initialConverse;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (converseAVerse)] action in IconButton widget.
  ApiCallResponse? chatConversationSend;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
