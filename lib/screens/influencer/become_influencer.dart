import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sapiency/configs/theme.dart';
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

  static final List<InfluencerStep> steps = [
    InfluencerStep(
      stepNo: 1,
      stepTitle: 'Personal info',
      title: 'Verify your personal information',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getPersonalInfo(ctx)
    ),
    InfluencerStep(
      stepNo: 2,
      stepTitle: 'Social media',
      title: 'Social media',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getSocialMedia(ctx)
    ),
    InfluencerStep(
      stepNo: 3,
      stepTitle: 'Metatags',
      title: 'Metatags',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getMetaTags(ctx)
    ),
    InfluencerStep(
      stepNo: 4,
      stepTitle: 'Token info',
      title: 'Token info',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getTokenInfo(ctx)
    ),
    InfluencerStep(
      stepNo: 5,
      stepTitle: 'Crowdsale',
      title: 'Crowdsale',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getCrowdSale(ctx)
    ),
    InfluencerStep(
      stepNo: 6,
      stepTitle: 'Description',
      title: 'Description',
      subtitle: 'Lorem ipsum',
      form: (ctx) => InfluencerForms.getDescription(ctx)
    ),
    InfluencerStep(
      stepNo: 7,
      stepTitle: 'Summary',
      title: 'Summary',
      subtitle: 'Lorem ipsum',
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
                children: __step.stepNo == 0
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
          "assets/images/become_influencer.png",
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
          'Please provide us with more informations about yourself',
          style: __theme.textTheme.subtitle1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'We will inform you about the next steps',
          style: __theme.textTheme.subtitle1,
        ),
        PointsList(
          title: 'Why Sapiency is right for you?',
          items: [
            'Lorem ipsum',
            'Second lorem ipsum',
            'Third lorem ipsum',
            'Fourth lorem ipsum'
          ],
        )
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