import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget formFieldWidget({
  required BuildContext context,
  required TextEditingController textEditingController,
  required String hint,
  required String label,
  bool? obscureText,
  Widget? suffix,
  AutovalidateMode? autovalidateMode,
  TextInputType? textInputType,
  FormFieldValidator<String>? formFieldValidator,
  double? height,
  double? width,
  int? maxLines,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      controller: textEditingController,
      autovalidateMode: autovalidateMode,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      cursorColor: MyColor.neutral600,
      maxLines: maxLines ?? 1,
      validator: formFieldValidator,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.neutral800,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral700.withOpacity(.6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral700.withOpacity(.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral700.withOpacity(.6),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.danger400,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.danger400,
          ),
        ),
      ),
    ),
  );
}
