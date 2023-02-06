import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/dummy/onboarding_model.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/onboarding_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/onboarding_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: AdaptSize.pixel8,
          right: AdaptSize.pixel8,
          top: AdaptSize.paddingTop + AdaptSize.pixel75 * 1.5,
        ),
        child: Stack(
          children: [
            /// page
            Consumer<OnBoardingViewModel>(builder: (context, value, child) {
              return PageView.builder(
                  controller: _pageController,
                  itemCount: value.onboarding.length,
                  onPageChanged: (index) {
                    value.getStarted(index == 2);
                  },
                  itemBuilder: (context, index) {
                    final OnBoardingModel onboardingContent =
                        value.onboarding[index];
                    return onboardingWidget(
                      context: context,
                      image: onboardingContent.image,
                      title: onboardingContent.title,
                      description: onboardingContent.subtitle,
                      indicator: SmoothPageIndicator(
                        controller: _pageController,
                        count: value.onboarding.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: MyColor.warning600,
                          dotColor: MyColor.neutral700,
                          dotHeight: AdaptSize.pixel8,
                          dotWidth: AdaptSize.pixel8,
                        ),
                      ),
                    );
                  });
            }),

            /// button skip
            Positioned(
              left: AdaptSize.pixel10,
              bottom: AdaptSize.pixel20,
              child: buttonWidget(
                sizeHeight: AdaptSize.pixel36,
                sizeWidth: AdaptSize.pixel75,
                backgroundColor: MyColor.neutral900,
                foregroundColor: MyColor.neutral900,
                side: BorderSide(color: MyColor.warning600),
                onPressed: () {
                  NavigasiViewModel().navigateToRegister(context);
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: AdaptSize.pixel16,
                        color: MyColor.warning600,
                      ),
                ),
              ),
            ),

            /// button next & get started
            Consumer<OnBoardingViewModel>(
              builder: (context, value, child) => value.lastpage
                  ? Positioned(
                      right: AdaptSize.pixel10,
                      bottom: AdaptSize.pixel20,
                      child: buttonWidget(
                        sizeHeight: AdaptSize.pixel36,
                        sizeWidth: AdaptSize.pixel75 +
                            AdaptSize.pixel40 +
                            AdaptSize.pixel24,
                        backgroundColor: MyColor.warning600,
                        foregroundColor: MyColor.neutral900,
                        onPressed: () {
                          NavigasiViewModel().navigateToRegister(context);
                        },
                        child: Text(
                          'Get Started',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: AdaptSize.pixel16,
                                    color: MyColor.neutral900,
                                  ),
                        ),
                      ),
                    )
                  : Positioned(
                      right: AdaptSize.pixel10,
                      bottom: AdaptSize.pixel20,
                      child: buttonWidget(
                        sizeHeight: AdaptSize.pixel36,
                        sizeWidth: AdaptSize.pixel75,
                        backgroundColor: MyColor.warning600,
                        foregroundColor: MyColor.neutral900,
                        onPressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Text(
                          'Next',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: AdaptSize.pixel16,
                                    color: MyColor.neutral900,
                                  ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
