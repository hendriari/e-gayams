import 'package:flutter/cupertino.dart';
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
    return showCupertinoModalPopup(
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
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

  /// dialog remove whitlist item
  static Widget dialogRemoveWhislist({
    context,
    Function()? onPressed1,
    Function()? onPressed2,
  }) {
    return Center(
      child: Container(
        height: 120,
        width: double.infinity,
        margin: EdgeInsets.all(AdaptSize.pixel10),
        decoration: BoxDecoration(
          color: MyColor.neutral900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: AdaptSize.pixel6,
                  top: AdaptSize.pixel6,
                  left: AdaptSize.pixel8),
              child: SizedBox(
                width: AdaptSize.screenWidth / 1.15384615385,
                child: Text(
                  "Apa Anda yakin akan menghapus item dari Wishlist ?",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: AdaptSize.pixel14),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: AdaptSize.pixel6, right: AdaptSize.pixel8),
              child: SizedBox(
                width: AdaptSize.screenWidth / 1.15385,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buttonWidget(
                      onPressed: onPressed1,
                      sizeHeight: AdaptSize.screenWidth / 9,
                      backgroundColor: MyColor.danger400,
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: AdaptSize.pixel12,
                              color: MyColor.neutral900,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: AdaptSize.pixel8,
                    ),
                    buttonWidget(
                      onPressed: onPressed2,
                      sizeHeight: AdaptSize.screenWidth / 9,
                      backgroundColor: MyColor.neutral900,
                      side: BorderSide(
                        color: MyColor.neutral400,
                        width: 1,
                      ),
                      child: Text(
                        'Delete',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: AdaptSize.pixel12,
                              color: MyColor.neutral400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// button logout
  Future singleButtonDialog({
    required BuildContext context,
    required String image,
    required String title,
    required String textButton1,
    required String textButton2,
    Color? bgButton1,
    Color? bgButton2,
    Color? bgSingleButton,
    Function()? onPress1,
    Function()? onPress2,
    Function()? singleOnpressed,
    bool? singleButton,
  }) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: AdaptSize.screenWidth / 1000 * 720,
              width: AdaptSize.screenWidth / 1000 * 720,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AdaptSize.pixel16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  singleButton == true
                      ? buttonWidget(
                    margin: EdgeInsets.only(right: AdaptSize.pixel4),
                    sizeHeight: AdaptSize.screenWidth / 1000 * 100,
                    backgroundColor: bgSingleButton,
                    foregroundColor: MyColor.neutral900,
                    onPressed: singleOnpressed,
                    child: Text(
                      textButton1,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: AdaptSize.pixel14,
                        color: MyColor.neutral900,
                      ),
                    ),
                  )
                      :

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
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
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
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
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
