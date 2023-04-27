import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:translatebebasan/translatebebasan.dart';

import 'lang/language_service.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalesBasan().addGlosarium(LanguageService());
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final route = RouterApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      routerConfig: route.router,
      // routerDelegate: _route.router.routerDelegate,
      // routeInformationParser: _route.router.routeInformationParser,
      // builder: ,
      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (context) => SplashProvider(),
      //       builder: (context, child) => const SplashPage(),
      //     ),
      //   ],
      // ),
    );
  }
}
