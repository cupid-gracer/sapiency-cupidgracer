import 'package:flutter/material.dart';
import 'package:sapiency/models/bottom_menu.dart';

class BottomNavigator extends StatelessWidget {
  final String currentRoute;

  BottomNavigator(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (idx) => _selectItem(idx, context),
      elevation: 10,
      currentIndex: BottomMenu.getIdxByRoute(currentRoute),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).primaryColor,
      items: BottomMenu.items.map((it) =>
          BottomNavigationBarItem(
              label: it.label,
              icon: Icon(it.icon)
          )
      ).toList(),
    );
  }

  void _selectItem(int idx, BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(BottomMenu.items[idx].route);
  }

}
