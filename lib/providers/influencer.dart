import 'package:flutter/material.dart';

class InfluencerProvider with ChangeNotifier {
  Map<String, String> _data = {};

  get data => _data;

  void save(Map<String, String> data) {
    data.updateAll((key, value) => _data[key] = value);
  }

}