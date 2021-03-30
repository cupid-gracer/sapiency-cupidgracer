import 'package:flutter/material.dart';

class OAuthServices {
  static List<OAuthServiceItem> get services => [
    OAuthServiceItem(name: "Facebook", icon: "assets/images/oauth/facebook.png"),
    OAuthServiceItem(name: "Twitter", icon: "assets/images/oauth/twitter.png"),
    OAuthServiceItem(name: "Apple", icon: "assets/images/oauth/apple.png"),
    OAuthServiceItem(name: "Kanga Exchange", icon: "assets/images/oauth/kanga.png"),
  ];
}

class OAuthServiceItem {
  final String name;
  final String icon;

  OAuthServiceItem({this.name, this.icon});
}