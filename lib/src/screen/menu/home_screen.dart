import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/model/user_model.dart';
import 'package:kkn_siwalan/src/services/firebase_auth.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginRegisterViewModel>(context, listen: false);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('halo'),
          Text(''),
          ElevatedButton(
              onPressed: () {
                // FirebaseAuthServices().logOut();
                // CustomDialogs().logoutDialog(context);
                CustomDialogs().customDialog(
                    context: context,
                    image: 'logout',
                    title: 'Yakin mau keluar?',
                    textButton1: 'Batal',
                    textButton2: 'Keluar',
                    bgButton1: MyColor.danger400,
                    bgButton2: MyColor.neutral900,
                    onPress1: () {
                      Navigator.pop(context);
                    },
                    onPress2: () {
                      userProvider.signout(context);
                    });
              },
              child: Text('logout'))
        ],
      ),
    ));
  }
}
