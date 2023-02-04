import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget formFieldWidget({
  required BuildContext context,
  required String hint,
  required String label,
  Function()? onTap,
  TextEditingController? textEditingController,
  bool? obscureText,
  bool? readOnly,
  Widget? suffix,
  Widget? prefixIcon,
  AutovalidateMode? autovalidateMode,
  TextInputType? textInputType,
  FormFieldValidator<String>? formFieldValidator,
  double? height,
  double? width,
  int? maxLines,
  Function(String)? onChanged,
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
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      validator: formFieldValidator,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.neutral700.withOpacity(.3),
        suffixIcon: suffix,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: MyColor.neutral500, fontSize: AdaptSize.pixel14),
        label: Text(label),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: MyColor.neutral500, fontSize: AdaptSize.pixel14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral500.withOpacity(.6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral500.withOpacity(.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: MyColor.neutral500.withOpacity(.6),
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
