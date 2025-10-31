// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:device_info_plus/device_info_plus.dart';

Future<bool> isEdgeToEdge(BuildContext context) async {
  // Add your function code here!
  final platform = Theme.of(context).platform;

  if (platform != TargetPlatform.android) {
    return false;
  }
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Android version: ${androidInfo.version.release}'); // e.g., "9"
  print('SDK version: ${androidInfo.version.sdkInt}'); // e.g., 28
  return androidInfo.version.sdkInt >= 35 &&
      int.parse(androidInfo.version.release) >= 15;
}
