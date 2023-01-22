import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget formFieldWidget({
  required BuildContext context,
  required TextEditingController textEditingController,
  bool? obscureText,
  Widget? suffix,
  required String hint,
  required String label,
  TextInputType? textInputType,
  FormFieldValidator<String>? formFieldValidator,
  double? height,
  double? width,
  int? maxLines,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          offset: const Offset(2, 3),
          color: MyColor.primary900,
          blurRadius: 3,
        )
      ],
    ),
    child: TextFormField(
      controller: textEditingController,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      cursorColor: MyColor.neutral600,
      maxLines: maxLines ?? 1,
      validator: formFieldValidator,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.neutral900,
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: MyColor.neutral600, fontSize: AdaptSize.pixel14),
        label: Text(label),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: MyColor.neutral600, fontSize: AdaptSize.pixel14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral700.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral700.withOpacity(.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.danger400,
          ),
        ),
      ),
    ),
  );
}
