import 'package:flutter/material.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneFormField extends StatelessWidget with SapiencyInputDecoration {
  final String name;
  final String label;
  final String placeholder;
  final String comment;
  final String value;
  final bool required;
  final int lines;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Map<String, String> saveTo;
  final FocusNode focusNode;
  final Function focusNext;

final TextEditingController controller = TextEditingController();
  String initialCountry = 'PL';
  PhoneNumber number = PhoneNumber(isoCode: 'PL');

  PhoneFormField({
    this.name,
    this.label,
    this.placeholder,
    this.comment = '',
    this.value = '',
    this.required = true,
    this.lines = 1,
    this.validator = Validator.empty,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next
  });

  factory PhoneFormField.formField(
      PhoneFormField previous, {
        String name,
        String value,
        Map<String, String> saveTo,
        TextInputAction inputAction,
        FocusNode focusNode,
        Function focusNext
      }) =>
    PhoneFormField(
      name: name,
      value: value,
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
        InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                _saveData(number.phoneNumber);
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.always,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved:(PhoneNumber number) {
                _saveData(number.phoneNumber);
                print('On Saved: $number');
              },
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
