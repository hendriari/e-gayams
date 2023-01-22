import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kkn_siwalan/firebase_options.dart';
import 'package:kkn_siwalan/src/screen/splashscreen1.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/text_theme.dart';
import 'package:kkn_siwalan/src/viewmodel/onboarding_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: MyColor.neutral900,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: MyColor.neutral900),
          textTheme: myTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
