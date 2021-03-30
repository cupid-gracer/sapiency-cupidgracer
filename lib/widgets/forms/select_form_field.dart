import 'package:flutter/material.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';

class SelectFormField extends StatelessWidget with SapiencyInputDecoration {
  final String name;
  final String label;
  final String placeholder;
  final String comment;
  final String value;
  final bool required;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Map<String, String> saveTo;
  final FocusNode focusNode;
  final Function focusNext;

  SelectFormField({
    this.name,
    this.label,
    this.placeholder,
    this.comment = '',
    this.value = '',
    this.required = true,
    this.validator = Validator.empty,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
  });

  factory SelectFormField.formField(
      SelectFormField previous, {
        String name,
        String value,
        Map<String, String> saveTo,
        TextInputAction inputAction,
        FocusNode focusNode,
        Function focusNext
      }) =>
    SelectFormField(
      name: name,
      value: value,
      label: previous.label,
      comment: previous.comment,
      placeholder: previous.placeholder,
      required: previous.required,
      validator: previous.validator,
      saveTo: saveTo,
      focusNode: focusNode,
      focusNext: focusNext,
    );


  @override
  Widget build(BuildContext context) {
    final __theme = Theme.of(context);

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
        DropdownButton(
          value: value,
          hint: Text(placeholder),
//          decoration: standardInputDecoration(placeholder: placeholder),
//          validator: (value) => Validator.ifRequired(required, value, validator),
          items: ['A', 'B', 'C'].map((it) =>
            DropdownMenuItem(
              child: Text(it),
              value: it,
            )
          ).toList(),
          onChanged: _saveData,
          focusNode: focusNode,
          //onFieldSubmitted: (_) { focusNext(); },
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
