import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kkn_siwalan/firebase_options.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/landing/splashscreen1.dart';
import 'package:kkn_siwalan/src/services/http_overrides.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';
import 'package:kkn_siwalan/src/utils/text_theme.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/menu_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/network_status.dart';
import 'package:kkn_siwalan/src/viewmodel/notif_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/onboarding_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/order_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  NotificationViewModel().getFCMtokens();
  NotificationViewModel().requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
        ChangeNotifierProvider(create: (_) => LoginRegisterViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => ProductDummyData()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => ProductParsers()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        StreamProvider<NetworkStatus>(
          create: (_) => NetworkStatusServices().networkStatusController.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MyColor.neutral900,
          textTheme: myTextTheme,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: MyColor.neutral900)
              .copyWith(background: MyColor.neutral900),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
