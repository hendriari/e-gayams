import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Profile'
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
