import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget readOnlyForm({
  required BuildContext context,
  required String hint,
  Function()? onTap,
  bool? readOnly,
  Widget? suffix,
  Widget? prefixIcon,
  double? height,
  double? width,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      cursorColor: MyColor.neutral600,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.neutral800,
        suffixIcon: suffix,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
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
