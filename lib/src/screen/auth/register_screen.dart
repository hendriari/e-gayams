import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
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
              height: AdaptSize.pixel24,
            ),

            /// confrim password
            formFieldWidget(
              context: context,
              textEditingController: _username,
              label: 'Username',
              hint: 'Jhon Doe',
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// email
            formFieldWidget(
              context: context,
              textEditingController: _email,
              textInputType: TextInputType.emailAddress,
              label: 'Email',
              hint: 'example@gmail.com',
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// alamat
            formFieldWidget(
              context: context,
              obscureText: false,
              textEditingController: _alamat,
              textInputType: TextInputType.streetAddress,
              label: 'Alamat',
              hint: 'Jl. Jalan',
            ),

            SizedBox(
              height: AdaptSize.pixel16,
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
              height: AdaptSize.pixel16,
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
                ),
                formFieldWidget(
                  width: AdaptSize.screenWidth / 2.15,
                  context: context,
                  textEditingController: _rw,
                  textInputType: TextInputType.number,
                  label: 'Rw',
                  hint: 'RW 01',
                ),
              ],
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// password
            formFieldWidget(
              context: context,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              textEditingController: _password,
              label: 'Password',
              hint: '*********',
              suffix: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                splashRadius: .1,
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: MyColor.neutral700,
                ),
              ),
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// confrim password
            formFieldWidget(
              context: context,
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              textEditingController: _confirmPassword,
              label: 'Confirm Password',
              hint: '********',
              suffix: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                splashRadius: .1,
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: MyColor.neutral700,
                ),
              ),
            ),

            SizedBox(
              height: AdaptSize.pixel28,
            ),

            buttonWidget(
              sizeWidth: double.infinity,
              sizeHeight: AdaptSize.screenWidth / 1000 * 150,
              backgroundColor: MyColor.warning600,
              foregroundColor: MyColor.neutral900,
              onPressed: () {},
              child: Text(
                'Daftar',
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: MyColor.neutral900,
                      fontSize: AdaptSize.pixel16,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
