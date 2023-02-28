import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String titleAppbar;

  const ChangePasswordScreen({
    Key? key,
    this.titleAppbar = 'Change Password',
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.titleAppbar;
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: widget.titleAppbar,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: AdaptSize.pixel20,
            color: Colors.black,
          ),
        ),
      ),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: Padding(
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            top: AdaptSize.pixel16,
            bottom: AdaptSize.pixel16,
          ),
          child: Form(
            key: _key,
            child: Column(
              children: [
                /// email field
                formFieldWidget(
                  context: context,
                  hint: 'example@gmail.com',
                  label: 'Email',
                  textEditingController: _email,
                  textInputType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      value == null || !EmailValidator.validate(value)
                          ? 'Masukkan email yang valid'
                          : null,
                ),

                const Spacer(),

                /// button save
                Consumer<AccountViewModel>(builder: (context, value, child) {
                  return buttonWidget(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        value.changePassword(
                            context: context, email: _email.text);
                      }
                    },
                    sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                    sizeWidth: double.infinity,
                    backgroundColor: MyColor.warning600,
                    foregroundColor: MyColor.neutral900,
                    child: value.saveLoading
                        ? CircularProgressIndicator(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            'Selanjutnya',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontSize: AdaptSize.pixel16),
                          ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
