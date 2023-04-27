import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).onInit(
        context,
        tag: runtimeType.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SplashProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: prov.isLoading ? Container() : contentPage(prov),
      ),
    );
  }

  Widget contentPage(SplashProvider prov) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "assets/icons/splash_econo.png",
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(prov.textVersion),
        ],
      ),
    );
  }
}
