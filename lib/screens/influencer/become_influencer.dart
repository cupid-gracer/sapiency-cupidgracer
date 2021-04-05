import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/forms/base_form.dart';
import 'package:sapiency/forms/influencer_forms.dart';
import 'package:sapiency/models/influencer_step.dart';
import 'package:sapiency/providers/influencer.dart';
import 'package:sapiency/widgets/points_list.dart';
import 'package:sapiency/widgets/summary_fields.dart';

class BecomeInfluencerScreen extends StatelessWidget {

  static final InfluencerStep introductionStep = InfluencerStep(
    screen: (ctx) => _introductionScreen(ctx),
    form: (ctx) => InfluencerForms.getIntroduction(ctx),
  );

  static final InfluencerStep doneStep = InfluencerStep(
    screen: (ctx) => _doneScreen(ctx),
    form: (ctx) => InfluencerForms.getDone(ctx),
  );

  static final List<InfluencerStep> steps = [
    InfluencerStep(
      stepNo: 1,
      stepTitle: 'Personal info',
      title: 'Verify your personal information',
      subtitle: 'Please provide your basic data. They need to match the data from the official documents',
      form: (ctx) => InfluencerForms.getPersonalInfo(ctx)
    ),
    InfluencerStep(
      stepNo: 2,
      stepTitle: 'Social media',
      title: 'Social media',
      subtitle: 'Please provide the links and names to your social media pages.',
      form: (ctx) => InfluencerForms.getSocialMedia(ctx)
    ),
    InfluencerStep(
      stepNo: 3,
      stepTitle: 'Metatags',
      title: 'Metatags',
      subtitle: 'Please describe yourself using three tags',
      form: (ctx) => InfluencerForms.getMetaTags(ctx)
    ),
    InfluencerStep(
      stepNo: 4,
      stepTitle: 'Token info',
      title: 'Token info',
      subtitle: 'Give a name and a symbol to your token.\nSymbol is a ticker that will be visible on the exchange.\n\nRemember:\nIt\'s impossible to change is in the future, because it will be written on the Blockchain.',
      form: (ctx) => InfluencerForms.getTokenInfo(ctx)
    ),
    InfluencerStep(
      stepNo: 5,
      stepTitle: 'Crowdsale',
      title: 'Crowdsale',
      subtitle: 'Would you like to make a fund raising for you goal?',
      form: (ctx) => InfluencerForms.getCrowdSale(ctx)
    ),
    InfluencerStep(
      stepNo: 6,
      stepTitle: 'Description',
      title: 'Crowdsale description',
      subtitle: 'Please tell people what are you fundraising goals, and what are you planning to do with the funds. It\'s also good to let them know if there is something they will get extra if they support you.',
      form: (ctx) => InfluencerForms.getDescription(ctx)
    ),
    InfluencerStep(
      stepNo: 7,
      stepTitle: 'Summary',
      title: 'Summary',
      subtitle: 'Please verify the data you have provided and provide required consents',
      screen: (ctx) => _summaryScreen(ctx),
      form: (ctx) => InfluencerForms.getSummary(ctx)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final __deviceSize = MediaQuery.of(context).size;
    final __theme = Theme.of(context);
    final __step = ModalRoute.of(context).settings.arguments as InfluencerStep;

    return Scaffold(
        backgroundColor: __theme.backgroundColor,
        appBar: AppBar(
          title: Text('Become an influencer', style: __theme.textTheme.caption,),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: __deviceSize.width - 60,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: __step.stepNo == 0 || __step.stepNo == 7
                ? [
                  const SizedBox(
                    height: 50,
                  ),
                  __step.screen(context),
                  __step.form(context) as BaseForm
                ]
                : [
                  _stepsWidget(__step.stepTitle, __step.stepNo),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    __step.title ?? '',
                    style: __theme.textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    __step.subtitle ?? '',
                    style: __theme.textTheme.subtitle1,
                  ),
                  __step.screen != null ? __step.screen(context) : Container(),
                  Consumer<InfluencerProvider>(
                    builder: (ctx, _, __) => __step.form(ctx)
                  )
                ],
              )
          ),
        )
      );
  }

  Widget _stepsWidget(String title, int currentStepNo) {
    final __numberFormat = NumberFormat('#00', 'en_GB');

    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
          children: Iterable<int>.generate(steps.length).map((idx) => steps[idx]).map((step) {
            final __style = step.stepNo <= currentStepNo
                ? TextStyle(color: SapiencyTheme.primaryColor)
                : TextStyle(color: SapiencyTheme.fontColor);

            if (step.stepNo == currentStepNo) {
              return Row(
                  children: [
                    Text("${__numberFormat.format(step.stepNo)}  ", style: TextStyle(color: SapiencyTheme.secondaryColor),),
                    Text("${step.stepTitle}   ")
                  ]
              );
            } else {
              return Text("${__numberFormat.format(step.stepNo)}${step.stepNo == steps.length ? '': ' -'} ", style: __style);
            }
          }).toList()
      ),
    );
  }

  static Widget _introductionScreen(BuildContext ctx) {
    final __theme = Theme.of(ctx);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.become_influencer,
          width: 85,
          height: 85,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Become a Sapiency influencer',
          style: __theme.textTheme.headline1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'In order to issue a token we need to know more about you',
          style: __theme.textTheme.subtitle1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'If  you are eligible for tokenization we will inform you in the email',
          style: __theme.textTheme.subtitle1,
        ),
        PointsList(
          title: 'Why Sapiency is right for you?',
          items: [
            'You are an influencer with a community',
            'You can provide a value for your tokens',
            'Your community wants to know you better',
            'You have a goal that you want to fund'
          ],
        )
      ]
    );
  }

  static Widget _doneScreen(BuildContext ctx) {
    final __theme = Theme.of(ctx);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.archive_doc_check,
          width: 85,
          height: 85,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Congrats!',
          style: __theme.textTheme.headline1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Thank you for you request.\nWe will inform you with an email when you applicatioin is accepted.',
          style: __theme.textTheme.subtitle1,
        ),
        const SizedBox(
          height: 10,
        ),
      ]
    );
  }

  static Widget _summaryScreen(BuildContext ctx) {
    final __data = Provider.of<InfluencerProvider>(ctx, listen: false).data;

    return Column(
      children: [
        SummaryFields({
          'Token name': __data['tokenName'],
          'Symbol': __data['tokenSymbol'],
          'Crowdsale': __data['crowdSaleEnabled'] == "true" ? "Active" : "Not active",
          'Hard cap': __data['toRaise'],
          'Tokens for sale': __data['toSale'],
          'Start date': __data['saleStart'],
          'Tags': __data['tags']
        }),
        SummaryFields({
          'Title of the crowdsale': __data['title'],
          'Description': __data['description']
        })
      ],
    );
  }

}