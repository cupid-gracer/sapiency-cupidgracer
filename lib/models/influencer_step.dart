import 'package:flutter/material.dart';

class InfluencerStep {
  final int stepNo;
  final String stepTitle;
  final String title;
  final String subtitle;
  final Function(BuildContext) screen;
  final Function(BuildContext) form;

  InfluencerStep({
    this.stepNo = 0,
    this.stepTitle,
    this.title,
    this.subtitle,
    this.screen,
    this.form
  });
}