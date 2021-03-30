import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sapiency/mixins/input_decoration.dart';
import 'package:sapiency/configs/validators.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';

class ConfirmFormField extends StatelessWidget with SapiencyInputDecoration {
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

  String s1 = "", s2 = "", s3 = "", s4 = "";
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;


  ConfirmFormField(
      {this.name = '',
      this.label = '',
      this.placeholder = '',
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
      this.inputAction = TextInputAction.next});

  factory ConfirmFormField.formField(ConfirmFormField previous,
          {String name,
          String value,
          Map<String, String> saveTo,
          TextInputAction inputAction,
          FocusNode focusNode,
          Function focusNext}) =>
      ConfirmFormField(
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
            PinCodeTextField(
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: _saveData,
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )
            // TextFormField(
            //   initialValue: value,
            //   decoration: standardInputDecoration(placeholder: placeholder),
            //   validator: (value) =>
            //       Validator.ifRequired(required, value, validator),
            //   minLines: lines,
            //   maxLines: lines,
            //   textInputAction: inputAction,
            //   keyboardType: keyboardType,
            //   onSaved: __saveData4,
            //   focusNode: focusNode,
            //   onFieldSubmitted: (_) {
            //     focusNext();
            //   },
            // ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  // void __saveData1(value) => (){
  //   s1 = value;
  //   _saveData();
  // };

  // void __saveData2(value) => (){
  //   s2 = value;
  //   _saveData();
  // };

  // void __saveData3(value) => (){
  //   s3 = value;
  //   _saveData();
  // };

  // void __saveData4(value) => (){
  //   s4 = value;
  //   _saveData();
  // };

  void _saveData(value) => onSaved != null
      ? onSaved(value)
      : (saveTo != null ? saveTo[name] = value : null);
}
