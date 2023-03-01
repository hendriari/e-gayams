import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/account/about_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/account/change_password_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/account/edit_profile.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccountViewModel>().refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider =
        Provider.of<AccountViewModel>(context, listen: false);
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'Profile'),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            top: AdaptSize.pixel16,
            bottom: AdaptSize.pixel75 * 2,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// ingpo profile
              Container(
                height: AdaptSize.screenWidth / 1000 * 300,
                width: double.infinity,
                padding: EdgeInsets.all(AdaptSize.pixel8),
                decoration: BoxDecoration(
                  color: MyColor.warning500,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: MyColor.neutral600,
                      blurRadius: 5,
                      blurStyle: BlurStyle.solid,
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 3,
                    colorFilter:
                        ColorFilter.mode(MyColor.warning600, BlendMode.lighten),
                    image: const AssetImage('assets/image/bgprofile.png'),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: AdaptSize.screenWidth / 1000 * 250,
                      width: AdaptSize.screenWidth / 1000 * 250,
                      margin: EdgeInsets.only(right: AdaptSize.pixel8),
                      decoration: BoxDecoration(
                        color: MyColor.neutral700,
                        border: Border.all(
                          color: MyColor.neutral900,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/image/profiles.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<AccountViewModel>(
                              builder: (context, value, child) {
                            return Text(
                              value.usermodel?.username ?? 'Loading..',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: AdaptSize.pixel20,
                                  ),
                            );
                          }),
                          Consumer<AccountViewModel>(
                              builder: (context, value, child) {
                            return Text(
                              value.usermodel?.email ?? 'Loading..',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: AdaptSize.pixel16,
                                  ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              /// menu
              Container(
                height: AdaptSize.screenWidth / 1000 * 410,
                width: double.infinity,
                padding: EdgeInsets.all(AdaptSize.pixel8),
                decoration: BoxDecoration(
                  color: MyColor.neutral900,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4,
                      blurStyle: BlurStyle.solid,
                    ),
                  ],
                ),
                child: ListView.builder(
                    itemCount: accountProvider.profileMenu.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (index <= 2) {
                                debugPrint(accountProvider.profileMenu[index]);
                                if (index == 0) {
                                  NavigasiViewModel().navigasiAccountMenu(
                                      context: context,
                                      route: const EditProfileScreen());
                                }
                                if (index == 1) {
                                  NavigasiViewModel().navigasiAccountMenu(
                                      context: context,
                                      route: const AboutScreen());
                                }
                                if (index == 2) {
                                  NavigasiViewModel().navigasiAccountMenu(
                                      context: context,
                                      route: const ChangePasswordScreen());
                                }
                              } else if (index == 3) {
                                CustomDialogs().customDialog(
                                    context: context,
                                    image: 'quit',
                                    title: 'Yakin mau keluar ?',
                                    textButton1: 'Batal',
                                    textButton2: 'Keluar',
                                    bgButton1: MyColor.danger400,
                                    bgButton2: MyColor.neutral900,
                                    onPress1: () {
                                      Navigator.pop(context);
                                    },
                                    onPress2: () {
                                      LoginRegisterViewModel().signout(context);
                                    });
                              }
                            },
                            splashColor: MyColor.danger400,
                            child: Row(
                              children: [
                                accountProvider.iconsMenu[index],
                                SizedBox(
                                  width: AdaptSize.pixel12,
                                ),
                                Text(
                                  accountProvider.profileMenu[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: AdaptSize.pixel14,
                                      ),
                                ),
                                const Spacer(),
                                index == 3
                                    ? const SizedBox()
                                    : Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: AdaptSize.pixel18,
                                      )
                              ],
                            ),
                          ),
                          index == 3
                              ? const SizedBox()
                              : Divider(
                                  color: MyColor.neutral700,
                                  thickness: 1,
                                ),
                        ],
                      );
                    }),
              ),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              /// signature
              Image.asset(
                'assets/image/logo_user.png',
                height: AdaptSize.screenWidth / 1000 * 450,
                width: AdaptSize.screenWidth / 1000 * 450,
                color: Colors.white.withOpacity(.2),
                colorBlendMode: BlendMode.modulate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
