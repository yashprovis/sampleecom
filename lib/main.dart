import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'package:sampleecom/helpers/routes.dart';
import 'package:sampleecom/provider/order_provider.dart';
import 'package:sampleecom/provider/tabs_provider.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const int blackPrimaryValue = 0xFF000000;
  static const MaterialColor primaryBlack = MaterialColor(
    blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => TabsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: primaryBlack,
          ),
          home: const SplashScreen(),
          onGenerateRoute: RouteGenerator.onGenerateRoute,
        ));
  }
}
