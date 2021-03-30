import 'package:flutter/material.dart';
import 'package:sapiency/widgets/buttons/submit.dart';
import 'package:sapiency/widgets/forms/chips_form_field.dart';
import 'package:sapiency/widgets/forms/datetime_form_field.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/widgets/forms/password_form_field.dart';
import 'package:sapiency/widgets/forms/password_confirm_form_field.dart';
import 'package:sapiency/widgets/forms/select_form_field.dart';
import 'package:sapiency/widgets/forms/switch_form_field.dart';
import 'package:sapiency/widgets/forms/confirm_form_field.dart';
import 'package:sapiency/widgets/forms/phone_form_field.dart';

class BaseForm extends StatefulWidget {
  final Map<String, Widget> fields;
  final Map<String, String> values;
  final Widget submit;
  final String submitText;
  final Function(Map<String, String>, BuildContext) onSubmit;
  final Function(Exception error) onSubmitError;

  BaseForm({
    this.fields,
    this.values,
    this.submit,
    this.submitText,
    this.onSubmit,
    this.onSubmitError
  });

  @override
  _BaseFormState createState() => _BaseFormState();

}

class _BaseFormState extends State<BaseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _data = {};
  final Map<String, FocusNode> _focusNodes = {};
  final Map<String, Widget> _fields = {};
  final List<String> _orders = [];

  @override
  void initState() {
    super.initState();

    widget.fields.forEach((key, value) =>
        _focusNodes.putIfAbsent(key, () => FocusNode())
    );

    _orders.addAll(widget.fields.keys);

    widget.fields.forEach((key, value) {
      switch (value.runtimeType.toString()) {
        case "InputFormField":
          _fields[key] = InputFormField.formField(
            value,
            name: key,
            saveTo: _data,
            value: widget.values != null ? widget.values[key] : "",
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "PasswordFormField":
          _fields[key] = PasswordFormField.formField(
            value,
            name: key,
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "PasswordConfirmFormField":
          _fields[key] = PasswordConfirmFormField.formField(
            value,
            name: key,
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "DateTimeFormField":
          _fields[key] = DateTimeFormField.formField(
            value,
            name: key,
            value: widget.values != null ? widget.values[key] : "",
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "SwitchFormField":
          _fields[key] = SwitchFormField.formField(
            value,
            name: key,
            value: widget.values != null ? (widget.values[key] == "true" ? true : false) : false,
            saveTo: _data,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "SelectFormField":
          _fields[key] = SelectFormField.formField(
            value,
            name: key,
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "ChipsFormField":
          _fields[key] = ChipsFormField.formField(
            value,
            name: key,
            value: widget.values != null ? widget.values[key] : "",
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "ConfirmFormField":
          _fields[key] = ConfirmFormField.formField(
            value,
            name: key,
            value: widget.values != null ? widget.values[key] : "",
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
        case "PhoneFormField":
          _fields[key] = PhoneFormField.formField(
            value,
            name: key,
            value: widget.values != null ? widget.values[key] : "",
            saveTo: _data,
            inputAction: _isLastField(key) ? TextInputAction.done : TextInputAction.next,
            focusNode: _focusNodes[key],
            focusNext: () => _requestNextFocusNode(key),
          );
          break;
      }
    });

  }

  @override
  void dispose() {
    _focusNodes.forEach((key, value) =>
      value.dispose()
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _fields.entries.map((e) => e.value).toList()
              ..add(SizedBox(height: 20))
              ..add(widget.submit ?? SubmitButton(
                label: widget.submitText,
                onPressed: () => _submit(),
                padding: EdgeInsets.only(bottom: 20),
              ))
          )
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate())
      return;

    _formKey.currentState.save();

    try {
      if (widget.onSubmit != null)
        widget.onSubmit(_data, context);
    } catch (error) {
      if (widget.onSubmitError != null)
        widget.onSubmitError(error);
      else
        throw error;
    }
  }

  bool _isLastField(String key) =>
      _orders.indexOf(key) == _orders.length - 1;

  void _requestNextFocusNode(String key) =>
    _isLastField(key)
      ? _submit()
      : _focusNodes[_orders[_orders.indexOf(key) + 1]].requestFocus();

}
