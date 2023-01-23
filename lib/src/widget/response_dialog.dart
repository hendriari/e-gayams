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
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: AdaptSize.pixel16,
                        ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
