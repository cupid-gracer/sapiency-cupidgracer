import 'package:flutter/material.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:sapiency/configs/images.dart';

class InputFormField extends StatelessWidget with SapiencyInputDecoration {
  final String name;
  final String label;
  final String placeholder;
  final String comment;
  final String value;
  final Widget suffix;
  final bool required;
  final int lines;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Map<String, String> saveTo;
  final FocusNode focusNode;
  final Function focusNext;
  final Function onPressedSuffix;

  InputFormField({
    this.name,
    this.label,
    this.placeholder,
    this.comment = '',
    this.value = '',
    this.suffix,
    this.required = true,
    this.lines = 1,
    this.validator = Validator.empty,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onPressedSuffix 
  });

  factory InputFormField.formField(
      InputFormField previous, {
        String name,
        String value,
        Widget suffix,
        Map<String, String> saveTo,
        TextInputAction inputAction,
        FocusNode focusNode,
        Function focusNext,
        Function onPressedSuffix
      }) =>
    InputFormField(
      name: name,
      value: value,
      suffix: previous.suffix,
      label: previous.label,
      comment: previous.comment,
      placeholder: previous.placeholder,
      required: previous.required,
      validator: previous.validator,
      lines: previous.lines,
      keyboardType: previous.keyboardType,
      saveTo: saveTo,
      inputAction: inputAction,
      focusNode: focusNode,
      focusNext: focusNext,
      onPressedSuffix: previous.onPressedSuffix,
    );


  @override
  Widget build(BuildContext context) {
    final __theme = Theme.of(context);
    print("onPressedSuffix:  $onPressedSuffix");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: __theme.textTheme.caption,
            ),
            comment != null && comment.isNotEmpty
            ? Text(
                comment,
                style: __theme.textTheme.headline4
              )
            : Spacer()
          ],
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          initialValue: value,
          decoration: standardInputDecoration(placeholder: placeholder, suffix: suffix, onPressedSuffix: onPressedSuffix),
          validator: (value) => Validator.ifRequired(required, value, validator),
          minLines: lines,
          maxLines: lines,
          textInputAction: inputAction,
          keyboardType: keyboardType,
          onSaved: _saveData,
          focusNode: focusNode,
          onFieldSubmitted: (_) { focusNext(); },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void _saveData(value) =>
    onSaved != null ? onSaved(value) : (saveTo != null ? saveTo[name] = value : null);

}
