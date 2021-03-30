import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapiency/configs/routes.dart';
import 'package:sapiency/models/user.dart';
import 'package:sapiency/providers/auth.dart';
import 'package:sapiency/screens/influencer/become_influencer.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthProvider>(context, listen: false).user;

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Profile of ${user.nickname}'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.not_started_rounded),
            title: const Text('Become an influencer'),
            onTap: () {
              Navigator.pushNamed(
                  context,
                  Routes.BECOME_INFLUENCER,
                  arguments: BecomeInfluencerScreen.introductionStep
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }

}
