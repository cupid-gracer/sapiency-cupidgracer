import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/widgets/app_drawer.dart';
import 'package:sapiency/widgets/bottom_navigator.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Center(
      child: Text("SearchScreen")
    );
  }
}
