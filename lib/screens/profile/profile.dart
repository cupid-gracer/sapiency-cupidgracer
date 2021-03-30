import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/app_drawer.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigator(Routes.PROFILE_ROUTE),
      body: Center(child: Text("Profile of ${user.email}")),
    );
  }
}
