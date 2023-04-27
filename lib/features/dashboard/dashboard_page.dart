import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/resources.dart';
import '../../widget/widget.dart';
import 'dashboard_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).onInit(
        context,
        tag: runtimeType.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DashboardProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              AppBarCustom(
                title: "Dashboard",
                colorBackground: MyColors.colorPrimary,
                colorText: Colors.white,
              ),
              contentPage(context, prov),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => prov.goToPlanner(),
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Widget contentPage(BuildContext context, DashboardProvider prov) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [],
      ),
    );
  }
}
