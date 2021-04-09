import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/configs/images.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/screens/home/home.dart';
import 'package:sapiency/screens/home/search.dart';
import 'package:sapiency/screens/home/wallet/wallet.dart';
import 'package:sapiency/screens/home/profile/profile.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with WidgetsBindingObserver  {
  int selectedIndex = 0;
  List<Widget> listScreens = [
    HomeScreen(),
    SearchScreen(),
    WalletScreen(),
    ProfileScreen()
  ];
  bool isFirstRender = true;
  @override
  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
   @override
  didChangeDependencies(){}

  @override
  didUpdateWidget(MainScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if(state == AppLifecycleState.resumed){
      Provider.of<AuthProvider>(context,listen: false).changeResume();
      // Navigator.of(context).pushNamed(Routes.PIN_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;
    // if(isFirstRender){

    // Map<String, int> map = ModalRoute.of(context).settings.arguments;
    // print("map['selectedIndex']:  ${map['selectedIndex']}");
    // selectedIndex = map['selectedIndex']??0; 
    // }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: listScreens[selectedIndex],
      bottomNavigationBar: convexBottomBar(),
    );
  }

  Widget convexBottomBar() {
    return StyleProvider(
        style: Style(),
        child: ConvexAppBar(
          height: 90,
          color: Colors.grey,
          curveSize: 100,
          style: TabStyle.fixedCircle,
          backgroundColor: Colors.white,
          activeColor: Colors.red,
          items: [
            TabItem(icon: Icons.home_rounded, title: "Home"),
            TabItem(icon: Icons.search_rounded, title: "Search"),
            TabItem(
              icon: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(AppImages.circle_home)),
            ),
            TabItem(
                title: "Wallet", icon: Icons.account_balance_wallet_rounded),
            TabItem(title: "Profile", icon: Icons.person_rounded),
          ],
          initialActiveIndex: 0,
          onTap: _selectItem,
        ));
  }

  void _selectItem(int index) {
    if(index == 2) return;
    if(index > 2) --index;
     setState(() {
      selectedIndex = index;
    });
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
