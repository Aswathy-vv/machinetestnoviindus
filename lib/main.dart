import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/apiservice/sharedpreferencehelper.dart';
import 'package:machinetestnoviindus/constants/Approutes.dart';
import 'package:machinetestnoviindus/provider/addfeedprovider.dart';
import 'package:machinetestnoviindus/provider/homeprovider.dart';
import 'package:machinetestnoviindus/provider/loginprovider.dart';
import 'package:machinetestnoviindus/screens/homescreen.dart';
import 'package:machinetestnoviindus/screens/loginscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => Addfeedprovider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? firstLaunch;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    bool launched = await SharedPreferencesHelper.isFirstLaunch();
    setState(() {
      firstLaunch = launched;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a temporary loading screen while we check first launch
    if (firstLaunch == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.home: (_) => const Homescreen(),
        AppRoutes.login: (_) => const Loginscreen(),
      },
      home: firstLaunch! ? const Loginscreen() : const Homescreen(),
    );
  }
}
