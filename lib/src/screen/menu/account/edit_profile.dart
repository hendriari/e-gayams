import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/form_validators.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/string_radio_button.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final ValueNotifier<String> _gender = ValueNotifier<String>('female');
  final GlobalKey<FormState> _formKey = GlobalKey();


  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _alamatController.dispose();
    _rwController.dispose();
    _rwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: 'Edit Profile',
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
      body: Padding(
        padding: EdgeInsets.only(
          left: AdaptSize.pixel8,
          right: AdaptSize.pixel8,
          top: AdaptSize.pixel16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// username
              formFieldWidget(
                context: context,
                textEditingController: _usernameController,
                label: 'Username',
                hint: 'Jhon Doe',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) =>
                    FormValidators.usernameValidate(
                        value: _usernameController.text),
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
                textEditingController: _alamatController,
                textInputType: TextInputType.streetAddress,
                label: 'Alamat',
                hint: 'Jl. Jalan',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                formFieldValidator: (value) =>
                    FormValidators.commonValidate(
                        value: _alamatController.text, values: 'Alamat'),
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
                    textEditingController: _rtController,
                    textInputType: TextInputType.number,
                    label: 'RT',
                    hint: 'rt 01',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.rtrwValidate(
                            rukun: _rtController.text,
                            value: 'RT',
                            values: 'RT'),
                  ),
                  formFieldWidget(
                    width: AdaptSize.screenWidth / 2.15,
                    context: context,
                    textEditingController: _rwController,
                    textInputType: TextInputType.number,
                    label: 'RW',
                    hint: 'rw 01',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.rtrwValidate(
                            rukun: _rwController.text,
                            value: 'RW',
                            values: 'RW'),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel28,
              ),

              const Spacer(),

              /// button daftar
              Consumer<AccountViewModel>(builder: (context, value, child) {
                return buttonWidget(
                  sizeWidth: double.infinity,
                  sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                  backgroundColor: MyColor.warning600,
                  foregroundColor: MyColor.neutral900,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      value.updateUserData(
                        context: context,
                        username: _usernameController.text,
                        gender: _gender.value,
                        alamat: _alamatController.text,
                        rt: _rtController.text,
                        rw: _rwController.text,
                      );
                      // value.createUsers(
                      //   context: context,
                      //   email: _email.text,
                      //   password: _password.text,
                      //   username: _username.text,
                      //   jenisKelamin: _gender.value,
                      //   alamat: _alamat.text,
                      //   rt: _rt.text,
                      //   rw: _rw.text,
                      // );
                    }
                  },
                  child: value.saveLoading
                      ? CircularProgressIndicator(
                    color: MyColor.neutral900,
                  )
                      : Text(
                    'Simpan',
                    style:
                    Theme.of(context).textTheme.button!.copyWith(
                      color: MyColor.neutral900,
                      fontSize: AdaptSize.pixel16,
                    ),
                  ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
