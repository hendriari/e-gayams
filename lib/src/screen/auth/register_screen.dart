import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/form_validators.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/rich_text_widget.dart';
import 'package:kkn_siwalan/src/widget/string_radio_button.dart';

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
                'Register',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: AdaptSize.pixel24,
                      color: MyColor.neutral500,
                    ),
              ),

              Text(
                'Daftar untuk menggunakan aplikasi',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                'Jenis Kelamin',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
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
                    'Perempuan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
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
                    'Laki - Laki',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
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
                label: 'Alamat',
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
                    label: 'RT',
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
                    label: 'RW',
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
              formFieldWidget(
                context: context,
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                textEditingController: _password,
                label: 'Password',
                hint: '*********',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) => FormValidators.passwordValidate(
                  password: _password.text,
                  confirmPassword: _password.text,
                  value: "Password",
                ),
                suffix: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  splashRadius: .1,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyColor.warning600,
                  ),
                ),
              ),

              SizedBox(
                height: AdaptSize.pixel14,
              ),

              /// confrim password
              formFieldWidget(
                context: context,
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                textEditingController: _confirmPassword,
                label: 'Confirm Password',
                hint: '********',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) => FormValidators.passwordValidate(
                  confirmPassword: _confirmPassword.text,
                  password: _password.text,
                  value: "Confirm Password",
                ),
                suffix: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  splashRadius: .1,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyColor.warning600,
                  ),
                ),
              ),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              /// button daftar
              buttonWidget(
                sizeWidth: double.infinity,
                sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                backgroundColor: MyColor.warning600,
                foregroundColor: MyColor.neutral900,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint(_username.text);
                  }
                },
                child: Text(
                  'Daftar',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: MyColor.neutral900,
                        fontSize: AdaptSize.pixel16,
                      ),
                ),
              ),

              SizedBox(
                height: AdaptSize.pixel75,
              ),

              /// login button
              Center(
                child: richTextWidget(
                    text1: 'Sudah Punya Akun?',
                    textStyle1: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: AdaptSize.pixel12, color: MyColor.neutral600),
                    text2: ' Login',
                    textStyle2: Theme.of(context).textTheme.bodyText1!.copyWith(
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
