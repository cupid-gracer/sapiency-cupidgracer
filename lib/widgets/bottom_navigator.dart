import 'package:flutter/material.dart';
import 'package:sapiency/models/bottom_menu.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sapiency/configs/images.dart';

class BottomNavigator extends StatelessWidget {
  final String currentRoute;
  final int pageIndex;
  BottomNavigator(this.currentRoute, this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
  style: Style(),
  child:ConvexAppBar(
      height: 90,
      color: Colors.grey,
      curveSize: 100,
      style: TabStyle.fixedCircle,
      backgroundColor: Colors.white,
      activeColor: Colors.red,
      items: [
        TabItem(
            icon:Icons.home_rounded,
            title: "Home"),
        TabItem(icon: Icons.search_rounded, title: "Search"),
        TabItem(
          icon: Image(
              fit: BoxFit.contain, image: AssetImage(AppImages.circle_home)),
        ),
        TabItem(title: "Wallet", icon: Icons.account_balance_wallet_rounded),
        TabItem(title: "Profile", icon: Icons.person_rounded),
      ],
      initialActiveIndex: pageIndex,
      onTap: (int i) {
        if(i == 2) return;
        Navigator.of(context).pushReplacementNamed(BottomMenu.items[i].route);
      },
    ));
    // return BottomNavigationBar(
    //   iconSize: 30,
    //   onTap: (idx) => _selectItem(idx, context),
    //   elevation: 10,
    //   currentIndex: BottomMenu.getIdxByRoute(currentRoute),
    //   type: BottomNavigationBarType.fixed,
    //   unselectedItemColor: Colors.grey,
    //   selectedItemColor: Theme.of(context).primaryColor,
    //   items: BottomMenu.items
    //       .map((it) =>
    //           BottomNavigationBarItem(label: it.label, icon: Icon(it.icon)))
    //       .toList(),
    // );
  }

  void _selectItem(int idx, BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(BottomMenu.items[idx].route);
  }
}


class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 15, color: color);
  }
}