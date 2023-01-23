import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';

class CustomDialogs {
  /// button logout
  Future customDialog({
    required BuildContext context,
    required String image,
    required String title,
    required String textButton1,
    required String textButton2,
    Color? bgButton1,
    Color? bgButton2,
    Function()? onPress1,
    Function()? onPress2,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: AdaptSize.screenWidth / 1000 * 650,
              width: AdaptSize.screenWidth / 1000 * 650,
              padding: EdgeInsets.only(
                left: AdaptSize.pixel8,
                right: AdaptSize.pixel8,
                top: AdaptSize.pixel14,
                bottom: AdaptSize.pixel16,
              ),
              decoration: BoxDecoration(
                color: MyColor.neutral900,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 3),
                    color: MyColor.neutral500.withOpacity(.7),
                    blurRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/$image.png',
                    height: AdaptSize.screenWidth / 1000 * 330,
                    width: AdaptSize.screenWidth / 1000 * 330,
                  ),

                  SizedBox(
                    height: AdaptSize.pixel10,
                  ),

                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: AdaptSize.pixel16,
                        ),
                  ),

                  const Spacer(),

                  /// button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// cancel button
                      buttonWidget(
                        margin: EdgeInsets.only(right: AdaptSize.pixel4),
                        sizeHeight: AdaptSize.screenWidth / 1000 * 100,
                        backgroundColor: bgButton1,
                        foregroundColor: MyColor.neutral900,
                        onPressed: onPress1,
                        child: Text(
                          textButton1,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: AdaptSize.pixel14,
                                color: MyColor.neutral900,
                              ),
                        ),
                      ),

                      /// logout button
                      buttonWidget(
                        margin: EdgeInsets.only(left: AdaptSize.pixel4),
                        sizeHeight: AdaptSize.screenWidth / 1000 * 100,
                        backgroundColor: bgButton2,
                        foregroundColor: MyColor.warning600,
                        onPressed: onPress2,
                        child: Text(
                          textButton2,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: AdaptSize.pixel14,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
