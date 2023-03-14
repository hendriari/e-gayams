import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/form_validators.dart';
import 'package:kkn_siwalan/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/line_dash_widget.dart';
import 'package:kkn_siwalan/src/widget/loading_widget.dart';
import 'package:kkn_siwalan/src/widget/rich_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loadingOverlayWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: AdaptSize.paddingTop + AdaptSize.pixel24,
            right: AdaptSize.pixel8,
            left: AdaptSize.pixel8,
            bottom: AdaptSize.screenWidth / 1000 * 100,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.login ?? 'Login',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: AdaptSize.pixel24,
                        color: MyColor.neutral500,
                      ),
                ),
                Text(
                  AppLocalizations.of(context)?.loginDesc ??
                      'Login untuk memulai aplikasi',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AdaptSize.pixel12,
                        color: MyColor.neutral500,
                      ),
                ),
                SizedBox(
                  height: AdaptSize.pixel24,
                ),

                /// email
                formFieldWidget(
                    context: context,
                    textEditingController: _email,
                    hint: 'example@gmail.com',
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        value == null || !EmailValidator.validate(value)
                            ? 'Masukan email yang valid'
                            : null),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// password
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return formFieldWidget(
                    context: context,
                    textEditingController: _password,
                    hint: AppLocalizations.of(context)?.password ?? 'Password',
                    label: AppLocalizations.of(context)?.password ?? 'Password',
                    obscureText: value.visiblePasswordLogin,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.passwordValidate(
                            password: _password.text,
                            confirmPassword: _password.text,
                            value: 'Password'),
                    suffix: IconButton(
                      onPressed: () {
                        value.visibleLogin();
                      },
                      splashRadius: .1,
                      icon: value.visiblePasswordLogin
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                      padding: EdgeInsets.zero,
                      color: MyColor.warning600,
                    ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),

                /// reset password
                Align(
                  alignment: Alignment.centerRight,
                  child: richTextWidget(
                      text1:
                          '${AppLocalizations.of(context)?.forgotPassword}? ',
                      text2: 'Reset Passwords',
                      textStyle1: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                              fontSize: AdaptSize.pixel10,
                              color: MyColor.neutral600),
                      textStyle2: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                              fontSize: AdaptSize.pixel10,
                              color: MyColor.warning600),
                      recognizer2: TapGestureRecognizer()
                        ..onTap = () async {
                          NavigasiViewModel().forgotPassword(context);
                        }),
                ),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),

                /// button login
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return buttonWidget(
                    sizeWidth: double.infinity,
                    sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                    backgroundColor: MyColor.warning600,
                    foregroundColor: MyColor.neutral900,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint(_email.text);
                        value.userLogin(
                          context: context,
                          email: _email.text,
                          password: _password.text,
                        );
                      }
                    },
                    child: value.loginLoading
                        ? spinKitLoading(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            AppLocalizations.of(context)?.login ?? 'Login',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: AdaptSize.pixel16,
                                ),
                          ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel40,
                ),

                /// text or / atau
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    lineDash(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AdaptSize.pixel10, right: AdaptSize.pixel10),
                      child: Text(
                        'Atau',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: AdaptSize.pixel12,
                              color: MyColor.neutral600,
                            ),
                      ),
                    ),
                    lineDash(),
                  ],
                ),

                SizedBox(
                  height: AdaptSize.pixel26,
                ),

                /// login as guest & login with google
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// login as guest
                    anotherLogin(
                        context: context,
                        image: 'assets/icon3d/guest.png',
                        textDesc: 'Login as Guest',
                        onTap: () {
                          context
                              .read<LoginRegisterViewModel>()
                              .guestSignIn(context: context);
                        }),

                    /// login with google
                    anotherLogin(
                      context: context,
                      image: 'assets/icon3d/google.png',
                      textDesc: 'Login with Google',
                    ),
                  ],
                ),

                const Spacer(),

                /// button to register
                Center(
                  child: richTextWidget(
                      text1:
                          '${AppLocalizations.of(context)?.dontHaveAccount}? ',
                      text2: AppLocalizations.of(context)?.register ?? 'Daftar',
                      textStyle1:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: AdaptSize.pixel12,
                                color: MyColor.neutral600,
                              ),
                      textStyle2:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: AdaptSize.pixel12,
                                color: MyColor.warning600,
                              ),
                      recognizer2: TapGestureRecognizer()
                        ..onTap = () async {
                          NavigasiViewModel().navigateToRegister(context);
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget anotherLogin({
  required BuildContext context,
  required String image,
  required String textDesc,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: AdaptSize.screenWidth / 2.5,
          margin: EdgeInsets.only(
            bottom: AdaptSize.pixel6,
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
          ),
          padding: EdgeInsets.fromLTRB(
            AdaptSize.pixel6,
            AdaptSize.pixel4,
            AdaptSize.pixel6,
            AdaptSize.pixel4,
          ),
          decoration: BoxDecoration(
              color: MyColor.neutral900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: MyColor.neutral600,
              ),
              boxShadow: [
                BoxShadow(
                  color: MyColor.neutral700,
                  blurStyle: BlurStyle.solid,
                  blurRadius: 3,
                )
              ]),
          child: Image.asset(
            image,
            height: AdaptSize.pixel40 + AdaptSize.pixel6,
            width: AdaptSize.pixel40 + AdaptSize.pixel6,
          ),
        ),
        Text(
          textDesc,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: AdaptSize.pixel10),
        )
      ],
    ),
  );
}

Widget lineDash() {
  return SizedBox(
    width: AdaptSize.screenWidth / 2.6,
    child: LineDashWidget(
      color: MyColor.neutral600,
    ),
  );
}
