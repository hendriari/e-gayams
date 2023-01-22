import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget stringRadioButton({
  required BuildContext context,
  required ValueNotifier<String> customRadioController,
  required String controlledIdValue,
  double? outerCircleDiameter,
  double? innerCircleDiameter,
  double? circleBodyBorder,
}) {
  AdaptSize.size(context: context);

  return ValueListenableBuilder<String>(
    valueListenable: customRadioController,
    builder: ((context, value, child) {
      return InkWell(
        onTap: (() {
          customRadioController.value = controlledIdValue;
        }),
        child: SizedBox(
          height: outerCircleDiameter ?? AdaptSize.pixel40,
          width: outerCircleDiameter ?? AdaptSize.pixel40,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: outerCircleDiameter ?? AdaptSize.pixel40,
                  height: outerCircleDiameter ?? AdaptSize.pixel40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: customRadioController.value == controlledIdValue
                          ? MyColor.warning900
                          : MyColor.neutral900),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: outerCircleDiameter ?? AdaptSize.pixel20,
                  height: outerCircleDiameter ?? AdaptSize.pixel20,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                          customRadioController.value == controlledIdValue
                              ? MyColor.warning600
                              : MyColor.primary700,
                          width: 2),
                      shape: BoxShape.circle,
                      color: customRadioController.value == controlledIdValue
                          ? MyColor.warning900
                          : MyColor.neutral900),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: outerCircleDiameter ?? AdaptSize.pixel12,
                  height: outerCircleDiameter ?? AdaptSize.pixel12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: customRadioController.value == controlledIdValue
                          ? MyColor.warning600
                          : MyColor.neutral900),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}
