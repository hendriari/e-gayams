import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

class ResponseDialog {
  static Future<Object?> customResponseDialog({
    required BuildContext context,
    required String description,
    required String image,
    double? width,
    double? height,
  }) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    return showGeneralDialog(
        context: context,
        barrierLabel: "Response Dialog",
        barrierColor: Colors.black.withOpacity(.5),
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) {
          return Center(
            child: Container(
              height: height,
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(AdaptSize.pixel14),
              decoration: BoxDecoration(
                color: MyColor.neutral800,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.neutral500,
                    offset: const Offset(2, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/image/$image.png',
                    height: AdaptSize.screenWidth / 1000 * 290,
                    width: AdaptSize.screenWidth / 1000 * 290,
                  ),
                  SizedBox(
                    height: AdaptSize.pixel10,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: AdaptSize.pixel16,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }

  /// response info dialog
  static Future responseInfoDialog({
    required BuildContext context,
    required String image,
    required String description,
  }) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    return showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Center(
            child: Container(
              height: AdaptSize.screenWidth / 1000 * 500,
              width: AdaptSize.screenWidth / 1000 * 500,
              padding: EdgeInsets.all(AdaptSize.pixel10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: MyColor.neutral900,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 3),
                    color: MyColor.neutral700,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/image/$image',
                    height: AdaptSize.screenWidth / 1000 * 350,
                    width: AdaptSize.screenWidth / 1000 * 350,
                  ),
                  SizedBox(
                    height: AdaptSize.pixel10,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AdaptSize.pixel14,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }
}
