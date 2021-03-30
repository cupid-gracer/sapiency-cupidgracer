import 'package:flutter/material.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';

class SwitchFormField extends StatefulWidget {
  final String name;
  final String label;
  final bool value;
  final bool required;
  final FormFieldSetter<String> onSaved;
  final Map<String, String> saveTo;
  final FocusNode focusNode;
  final Function focusNext;

  SwitchFormField({
    this.name,
    this.label,
    this.value = false,
    this.required = true,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
  });

  factory SwitchFormField.formField(
      SwitchFormField previous, {
        String name,
        bool value,
        Map<String, String> saveTo,
        FocusNode focusNode,
        Function focusNext
      }) =>
      SwitchFormField(
        name: name,
        value: value,
        label: previous.label,
        required: previous.required,
        saveTo: saveTo,
        focusNode: focusNode,
        focusNext: focusNext,
      );

  @override
  _SwitchFormFieldState createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends State<SwitchFormField> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          activeColor: SapiencyTheme.primaryColor,
          activeTrackColor: SapiencyTheme.secondaryColor,
          value: _isSwitched,
          onChanged: (currentValue) {
            setState(() {
              _isSwitched = currentValue;
              _saveData(_isSwitched.toString());
            });
          }
        ),
        Text(widget.label)
      ],
    );
  }

  void _saveData(value) =>
    widget.onSaved != null
        ? widget.onSaved(value)
        : (widget.saveTo != null ? widget.saveTo[widget.name] = value : null);

}
