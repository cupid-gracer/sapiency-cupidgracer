import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';

enum DateTimeFieldType {
  date,
  time,
  datetime
}

class DateTimeFormField extends StatelessWidget with SapiencyInputDecoration {
  static const FORMATS = {
    DateTimeFieldType.date: "dd / MM / yyyy",
    DateTimeFieldType.time: "HH:mm",
    DateTimeFieldType.datetime: "dd / MM / yyyy HH:mm"
  };

  final String name;
  final String label;
  final String placeholder;
  final String comment;
  final String value;
  final bool required;
  final DateTimeFieldType type;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Map<String, String> saveTo;
  final FocusNode focusNode;
  final Function focusNext;

  DateTimeFormField({
    this.name,
    this.label,
    this.placeholder,
    this.comment = '',
    this.value = '',
    this.required = true,
    this.validator = Validator.empty,
    this.type = DateTimeFieldType.datetime,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next
  });

  factory DateTimeFormField.formField(
      DateTimeFormField previous, {
        String name,
        String value,
        Map<String, String> saveTo,
        TextInputAction inputAction,
        FocusNode focusNode,
        Function focusNext
      }) =>
    DateTimeFormField(
      name: name,
      value: value,
      label: previous.label,
      comment: previous.comment,
      placeholder: previous.placeholder,
      required: previous.required,
      validator: previous.validator,
      type: previous.type,
      saveTo: saveTo,
      inputAction: inputAction,
      focusNode: focusNode,
      focusNext: focusNext,
    );


  @override
  Widget build(BuildContext context) {
    final __theme = Theme.of(context);
    final __format = DateFormat(FORMATS[type]);

    print(value);

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
        DateTimeField(
          format: __format,
          initialValue: value == null ? null : __format.parse(value),
          decoration: standardInputDecoration(placeholder: placeholder),
          validator: (value) => Validator.ifRequired(required, __format.format(value), validator),
          textInputAction: inputAction,
          keyboardType: keyboardType,
          onSaved: _saveData,
          focusNode: focusNode,
          onFieldSubmitted: (_) { focusNext(); },
          onShowPicker: (ctx, currentValue) async {
            if (type == DateTimeFieldType.date) {
              return _showDatePicker(ctx, currentValue);
            } else if (type == DateTimeFieldType.time) {
              final __time = await _showTimePicker(ctx, currentValue);
              return DateTimeField.convert(__time);
            } else {
              return _showBothPickers(ctx, currentValue);
            }
          }
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void _saveData(value) {
    final __format = DateFormat(FORMATS[type]);

    return onSaved != null
        ? onSaved(__format.format(value))
        : (saveTo != null ? saveTo[name] = __format.format(value) : null);
  }

  Future<DateTime> _showDatePicker(BuildContext ctx, DateTime currentValue) async =>
    showDatePicker(
      context: ctx,
      firstDate: DateTime(1900),
      initialDate: currentValue ?? DateTime.now(),
      lastDate: DateTime(2100),
      builder: (ctx, chd) {
        return Theme(
          data: SapiencyTheme.getTheme(ctx),
          child: chd,
        );
      }
    );

  Future<TimeOfDay> _showTimePicker(BuildContext ctx, DateTime currentValue) async =>
      showTimePicker(
          context: ctx,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          builder: (ctx, chd) {
            return Theme(
              data: SapiencyTheme.getTheme(ctx),
              child: chd,
            );
          }
      );

  Future<DateTime> _showBothPickers(BuildContext ctx, DateTime currentValue) async {
    final __date = await _showDatePicker(ctx, currentValue);

    if (__date != null) {
      final __time = await _showTimePicker(ctx, currentValue);
      return DateTimeField.combine(__date, __time);
    } else {
      return currentValue;
    }

  }

}
