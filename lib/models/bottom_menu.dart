import 'package:flutter/material.dart';
import 'package:sapiency/configs/routes.dart';

class BottomMenu {
  static List<BottomMenuItem> get items => [
    BottomMenuItem(label: 'Home', icon: Icons.home_rounded, route: Routes.HOME_ROUTE),
    BottomMenuItem(label: 'Search', icon: Icons.search_rounded, route: Routes.HOME_ROUTE),
    BottomMenuItem(label: 'Wallet', icon: Icons.account_balance_wallet_rounded, route: Routes.WALLET_ROUTE),
    BottomMenuItem(label: 'Profile', icon: Icons.person_rounded, route: Routes.PROFILE_ROUTE)
  ];

  static int getIdxByRoute(String currentRoute) =>
      items.indexWhere((it) => it.route == currentRoute);

}

class BottomMenuItem {
  final String label;
  final IconData icon;
  final String route;

  BottomMenuItem({this.label, this.icon, this.route});
}