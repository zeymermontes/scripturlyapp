// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class FontSizeSlider extends StatefulWidget {
  const FontSizeSlider({
    super.key,
    this.width,
    this.height,
    required this.sliderValue,
    this.onChanged,
  });

  final double? width;
  final double? height;
  final double sliderValue;
  final Future Function(double size)? onChanged;

  @override
  State<FontSizeSlider> createState() => _FontSizeSliderState();
}

class _FontSizeSliderState extends State<FontSizeSlider> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.sliderValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              Text('A', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor:
                        FlutterFlowTheme.of(context).baseForeground,
                    inactiveTrackColor: Colors.grey[300],
                    trackHeight: 6.0,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 12.0,
                    ),
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 20.0,
                    ),
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 12.0,
                    max: 30.0,
                    divisions: 4,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                      // Llamar al callback si existe
                      widget.onChanged?.call(value);
                    },
                  ),
                ),
              ),
              Text('A', style: TextStyle(fontSize: 24, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
