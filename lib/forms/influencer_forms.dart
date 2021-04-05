import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/providers/influencer.dart';
import 'package:sapiency/screens/influencer/become_influencer.dart';
import 'package:sapiency/widgets/forms/chips_form_field.dart';
import 'package:sapiency/widgets/forms/datetime_form_field.dart';
import 'package:sapiency/widgets/forms/input_form_field.dart';
import 'package:sapiency/widgets/forms/switch_form_field.dart';

class InfluencerForms {
  static BaseForm getIntroduction(BuildContext ctx) => BaseForm(
      submitText: 'Continue',
      fields: {},
      onSubmit: (data, ctx) {
        gotoNext(data, ctx, 0);
      },
      onSubmitError: (error) {
        print(error);
      });

  static BaseForm getPersonalInfo(BuildContext ctx) => BaseForm(
        values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Continue',
        fields: {
          'name': InputFormField(
              label: 'First name',
              placeholder: 'John',
              keyboardType: TextInputType.text),
          'surname': InputFormField(
              label: 'Last name',
              placeholder: 'Doe',
              keyboardType: TextInputType.text),
          'birthday': DateTimeFormField(
              label: 'Day of birth',
              placeholder: 'DD / MM / YY',
              keyboardType: TextInputType.datetime,
              type: DateTimeFieldType.date),
        },
        onSubmit: (data, ctx) {
          gotoNext(data, ctx, 1);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  static BaseForm getSocialMedia(BuildContext ctx) => BaseForm(
        values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Continue',
        fields: {
          'facebook': InputFormField(
              label: 'Facebook',
              placeholder: 'https://fb.com/johndoe',
              keyboardType: TextInputType.url),
          'twitter': InputFormField(
              label: 'Twitter',
              placeholder: '@johndoe',
              keyboardType: TextInputType.text),
          'instagram': InputFormField(
              label: 'Instagram',
              placeholder: '@johndoe',
              keyboardType: TextInputType.text),
          'youtube': InputFormField(
              label: 'Youtube channel',
              placeholder: 'https://youtube.com/channel/johndoe',
              keyboardType: TextInputType.url),
        },
        onSubmit: (data, ctx) {
          gotoNext(data, ctx, 2);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  static BaseForm getMetaTags(BuildContext ctx) => BaseForm(
        values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Continue',
        fields: {
          'tags': ChipsFormField(
            label: 'Add at least 3 tags',
          ),
        },
        onSubmit: (data, ctx) {
          gotoNext(data, ctx, 3);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  static BaseForm getTokenInfo(BuildContext ctx) => BaseForm(
        values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Continue',
        fields: {
          'tokenName': InputFormField(
              label: 'Token name',
              placeholder: 'John Doe Token',
              keyboardType: TextInputType.text),
          'tokenSymbol': InputFormField(
              label: 'Token symbol',
              placeholder: 'JDOE',
              comment: '8 characters max',
              keyboardType: TextInputType.text),
        },
        onSubmit: (data, ctx) {
          gotoNext(data, ctx, 4);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  static BaseForm getCrowdSale(BuildContext ctx) => BaseForm(
      values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
      submitText: 'Continue',
      fields: {
        'crowdSaleEnabled':
            SwitchFormField(label: 'Click here to active your crowdsale'),
        'toRaise': InputFormField(
          label: 'How much would you like to raise?',
          placeholder: '\$100,000 USD',
          comment: 'Max \$100K',
          keyboardType: TextInputType.number,
        ),
        'toSale': InputFormField(
          label: 'Tokens to sale',
          placeholder: '1.000.000 TOKN',
          keyboardType: TextInputType.number,
        ),
        'saleStart': DateTimeFormField(
            label: 'Planned sale start',
            placeholder: 'DD / MM / YY',
            comment: 'Min 14 days from now',
            keyboardType: TextInputType.datetime,
            type: DateTimeFieldType.date),
      },
      onSubmit: (data, ctx) {
        gotoNext(data, ctx, 5);
      },
      onSubmitError: (error) {
        print(error);
      });

  static BaseForm getDescription(BuildContext ctx) => BaseForm(
        values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
        submitText: 'Continue',
        fields: {
          'title': InputFormField(
              label: 'Title of crowdsale',
              placeholder: 'Type a clear title here',
              keyboardType: TextInputType.text),
          'description': InputFormField(
            label: 'Description',
            placeholder: 'What are planning to do?',
            keyboardType: TextInputType.text,
            lines: 5,
          ),
        },
        onSubmit: (data, ctx) {
          gotoNext(data, ctx, 6);
        },
        onSubmitError: (error) {
          print(error);
        },
      );

  static BaseForm getSummary(BuildContext ctx) => BaseForm(
      values: Provider.of<InfluencerProvider>(ctx, listen: false).data,
      submitText: 'Send',
      fields: {
        'crowdSaleEnabled':
            SwitchFormField(label: 'I confirm that I provide a valid data'),
      },
      onSubmit: (data, ctx) {
        gotoNext(data, ctx, 7);
      },
      onSubmitError: (error) {
        print(error);
      });

  static BaseForm getDone(BuildContext ctx) => BaseForm(
      submitText: 'Back to home page',
      fields: {},
      onSubmit: (data, ctx) {
        Navigator.of(ctx)
            .pushNamedAndRemoveUntil(Routes.MAIN_HOME_ROUTE, (route) => false);
      },
      onSubmitError: (error) {
        print(error);
      });

  static void gotoNext(
      Map<String, String> data, BuildContext ctx, int nextStep) {
    if (nextStep != 7) {
      Provider.of<InfluencerProvider>(ctx, listen: false).save(data);

      Navigator.pushNamed(ctx, Routes.BECOME_INFLUENCER,
          arguments: BecomeInfluencerScreen.steps[nextStep]);
    } else {
      Navigator.pushNamed(ctx, Routes.BECOME_INFLUENCER,
          arguments: BecomeInfluencerScreen.doneStep);
    }
  }
}
