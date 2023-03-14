import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';

class ResponseDialog {
  /// generally used to display the response
  static Future<Object?> customResponseDialog({
    required BuildContext context,
    required String description,
    required String image,
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
          return WillPopScope(
              child: Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/$image.png',
                          height: AdaptSize.screenWidth / 1000 * 400,
                          width: AdaptSize.screenWidth / 1000 * 400,
                        ),
                        SizedBox(
                          height: AdaptSize.pixel10,
                        ),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: AdaptSize.pixel16,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: () async => false);
        });
  }

  /// response info dialog
  static Future responseInfoDialog({
    required BuildContext context,
    required String image,
    required String description,
  }) async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    return showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return WillPopScope(
              child: Dialog(
                backgroundColor: MyColor.neutral900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/$image',
                          height: AdaptSize.screenWidth / 1000 * 400,
                          width: AdaptSize.screenWidth / 1000 * 400,
                        ),
                        SizedBox(
                          height: AdaptSize.pixel10,
                        ),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: AdaptSize.pixel14,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: () async => false);
        });
  }

  /// RESTRICTED feature mode guest
  static Future witoutLoginDialog({
    required BuildContext context,
    Function()? onTapViewOnly,
  }) {
    return showGeneralDialog(
      barrierLabel: "login as guest",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return WillPopScope(
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RESTRICTED FEATURES",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: AdaptSize.pixel22,
                                fontWeight: FontWeight.w600,
                              ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: AdaptSize.pixel16,
                    ),
                    Image.asset(
                      'assets/image/without_login.png',
                      height: AdaptSize.screenWidth / 1000 * 800,
                    ),
                    SizedBox(
                      height: AdaptSize.pixel16,
                    ),
                    Text(
                      "Login or Register to access this feature",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AdaptSize.pixel12,
                          color: MyColor.neutral500),
                    ),
                    buttonWidget(
                      onPressed: () {
                        NavigasiViewModel().navigateGuestLogout(context);
                      },
                      backgroundColor: Colors.black,
                      foregroundColor: MyColor.neutral900,
                      sizeHeight: AdaptSize.screenWidth / 1000 * 120,
                      sizeWidth: double.infinity,
                      margin: EdgeInsets.only(top: AdaptSize.pixel16),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: AdaptSize.pixel16,
                              color: MyColor.neutral900,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: AdaptSize.pixel12,
                    ),
                    GestureDetector(
                      onTap: onTapViewOnly,
                      child: Text(
                        'i just want to see',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onWillPop: () async => false,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: child,
        );
      },
    );
  }
}
