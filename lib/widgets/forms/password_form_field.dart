import 'package:flutter/material.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/validators.dart';

class PasswordFormField extends StatefulWidget {
  final String name;
  final String labelText;
  final String placeholder;
  final FormFieldSetter<String> onSaved;
  final bool showForgotPassword;
  final Map<String, String> saveTo;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final Function focusNext;

  PasswordFormField({
    this.name,
    this.labelText,
    this.placeholder,
    this.onSaved,
    this.saveTo,
    this.focusNode,
    this.focusNext,
    this.showForgotPassword = false,
    this.inputAction = TextInputAction.next
  });

  factory PasswordFormField.formField(
      PasswordFormField prev, {
        String name,
        Map<String, String> saveTo,
        TextInputAction inputAction,
        FocusNode focusNode,
        Function focusNext,
        bool showForgotPassword
      }) =>
      PasswordFormField(
        name: name,
        labelText: prev.labelText,
        placeholder: prev.placeholder,
        saveTo: saveTo,
        focusNode: focusNode,
        showForgotPassword: prev.showForgotPassword,
        focusNext: focusNext,
        inputAction: inputAction
      );

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> with SapiencyInputDecoration {
  bool _isHidden = true;

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
              widget.labelText,
              style: __theme.textTheme.caption,
            ),
            SizedBox(
              height: widget.showForgotPassword ? 20 : 0,
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.RESET_PASSWORD_ROUTE);
                },
                child: Text(
                  'Forgot password?'
                )
              )
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: standardInputDecoration(suffix: InkWell(
              onTap: _togglePasswordShow,
              child: Icon(
                _isHidden ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                color: SapiencyTheme.hintColor,
              )
            )
          ),
          focusNode: widget.focusNode,
          obscureText: _isHidden,
          validator:  Validator.password,
          onSaved: _saveData,
          textInputAction: widget.inputAction,
          onFieldSubmitted: (_) => widget.focusNext(),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void _togglePasswordShow() =>
    setState(() {
      _isHidden = !_isHidden;
    });

  void _saveData(value) =>
      widget.onSaved != null ? widget.onSaved(value) : (widget.saveTo != null ? widget.saveTo[widget.name] = value : null);

}
