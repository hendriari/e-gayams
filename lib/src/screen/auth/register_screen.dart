import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/form_validators.dart';
import 'package:kkn_siwalan/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/rich_text_widget.dart';
import 'package:kkn_siwalan/src/widget/string_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _rt = TextEditingController();
  final TextEditingController _rw = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final ValueNotifier<String> _gender = ValueNotifier<String>('female');
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _rt.dispose();
    _rw.dispose();
    _alamat.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: AdaptSize.paddingTop + AdaptSize.pixel24,
          right: AdaptSize.pixel8,
          left: AdaptSize.pixel8,
          bottom: AdaptSize.screenWidth / 1000 * 100,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.register ?? 'Register',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: AdaptSize.pixel24,
                      color: MyColor.neutral500,
                    ),
              ),

              Text(
                AppLocalizations.of(context)?.registerDesc ??
                    'Daftar untuk menggunakan aplikasi',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AdaptSize.pixel12,
                      color: MyColor.neutral500,
                    ),
              ),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              /// username
              formFieldWidget(
                context: context,
                textEditingController: _username,
                label: 'Username',
                hint: 'Jhon Doe',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) =>
                    FormValidators.usernameValidate(value: _username.text),
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// email
              formFieldWidget(
                context: context,
                textEditingController: _email,
                textInputType: TextInputType.emailAddress,
                label: 'Email',
                hint: 'example@gmail.com',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) => FormValidators.commonValidate(
                    value: _email.text, values: 'Email'),
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              Text(
                AppLocalizations.of(context)?.gender ?? 'Jenis Kelamin',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: AdaptSize.pixel14),
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// gender
              Row(
                children: [
                  /// perempuan
                  stringRadioButton(
                    context: context,
                    customRadioController: _gender,
                    controlledIdValue: 'female',
                  ),
                  SizedBox(
                    width: AdaptSize.pixel8,
                  ),
                  Text(
                    AppLocalizations.of(context)?.female ?? 'Perempuan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: AdaptSize.pixel14),
                  ),
                  SizedBox(
                    width: AdaptSize.pixel12,
                  ),

                  /// laki laki
                  stringRadioButton(
                    context: context,
                    customRadioController: _gender,
                    controlledIdValue: 'male',
                  ),
                  SizedBox(
                    width: AdaptSize.pixel8,
                  ),
                  Text(
                    AppLocalizations.of(context)?.male ?? 'Laki - Laki',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: AdaptSize.pixel14),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// alamat
              formFieldWidget(
                context: context,
                obscureText: false,
                textEditingController: _alamat,
                textInputType: TextInputType.streetAddress,
                label: AppLocalizations.of(context)?.address ?? 'Alamat',
                hint: 'Jl. Jalan',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) => FormValidators.commonValidate(
                    value: _alamat.text, values: 'Alamat'),
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// rt rw
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formFieldWidget(
                    width: AdaptSize.screenWidth / 2.15,
                    context: context,
                    textEditingController: _rt,
                    textInputType: TextInputType.number,
                    label: AppLocalizations.of(context)?.rt ?? 'RT',
                    hint: 'RT 01',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) => FormValidators.rtrwValidate(
                        rukun: _rt.text, value: 'RT', values: 'RT'),
                  ),
                  formFieldWidget(
                    width: AdaptSize.screenWidth / 2.15,
                    context: context,
                    textEditingController: _rw,
                    textInputType: TextInputType.number,
                    label: AppLocalizations.of(context)?.rw ?? 'RW',
                    hint: 'RW 01',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) => FormValidators.rtrwValidate(
                        rukun: _rw.text, value: 'RW', values: 'RW'),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// password
              Consumer<LoginRegisterViewModel>(
                  builder: (context, value, child) {
                return formFieldWidget(
                  context: context,
                  obscureText: value.visiblePasswordRegister,
                  textInputType: TextInputType.visiblePassword,
                  textEditingController: _password,
                  label: AppLocalizations.of(context)?.password ?? 'Password',
                  hint: '*********',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.passwordValidate(
                    password: _password.text,
                    confirmPassword: _password.text,
                    value: "Password",
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      value.visibleRegister();
                    },
                    padding: EdgeInsets.zero,
                    splashRadius: .1,
                    icon: Icon(
                      value.visiblePasswordRegister
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                      color: MyColor.warning600,
                    ),
                  ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// confrim password
              Consumer<LoginRegisterViewModel>(
                  builder: (context, value, child) {
                return formFieldWidget(
                  context: context,
                  obscureText: value.visibleConfirmPassword,
                  textInputType: TextInputType.visiblePassword,
                  textEditingController: _confirmPassword,
                  label: AppLocalizations.of(context)?.confirmPassword ??
                      'Confirm Password',
                  hint: '********',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.passwordValidate(
                    confirmPassword: _confirmPassword.text,
                    password: _password.text,
                    value: "Confirm Password",
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      value.visibleConfrimRegister();
                    },
                    padding: EdgeInsets.zero,
                    splashRadius: .1,
                    icon: Icon(
                      value.visibleConfirmPassword
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                      color: MyColor.warning600,
                    ),
                  ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              /// button daftar
              Consumer<LoginRegisterViewModel>(
                  builder: (context, value, child) {
                return buttonWidget(
                  sizeWidth: double.infinity,
                  sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                  backgroundColor: MyColor.warning600,
                  foregroundColor: MyColor.neutral900,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      value.createUsers(
                        context: context,
                        email: _email.text,
                        password: _password.text,
                        username: _username.text,
                        jenisKelamin: _gender.value,
                        alamat: _alamat.text,
                        rt: _rt.text,
                        rw: _rw.text,
                      );
                    }
                  },
                  child: value.buttonRegisterLoading
                      ? CircularProgressIndicator(
                          color: MyColor.neutral900,
                        )
                      : Text(
                          'Daftar',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: AdaptSize.pixel16,
                                  ),
                        ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel75,
              ),

              /// login button
              Center(
                child: richTextWidget(
                    text1:
                        '${AppLocalizations.of(context)?.allReadyHaveAccount}?',
                    textStyle1: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AdaptSize.pixel12, color: MyColor.neutral600),
                    text2: ' ${AppLocalizations.of(context)?.login}',
                    textStyle2: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AdaptSize.pixel12,
                          color: MyColor.warning600,
                        ),
                    recognizer2: TapGestureRecognizer()
                      ..onTap = () async {
                        NavigasiViewModel().navigateToLogin(context);
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
