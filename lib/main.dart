import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/utils/router.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'providers/laundry_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCgzinyzzn6YQv89tWWnL5HqwZj4fYWhpU",
            authDomain: "laundry-lady.firebaseapp.com",
            projectId: "laundry-lady",
            storageBucket: "laundry-lady.appspot.com",
            messagingSenderId: "568550453977",
            appId: "1:568550453977:web:db47d927c98dbb3e3c04c8",
            measurementId: "G-JJJW4LP3XJ"));
  }
  // Stripe.publishableKey =
  //     'pk_test_51KVu9JGE0857zLDI262d51bGyuN2dO6JA4S6PkzPzsSVtd57oVZcDij0psE7MeHs2l84fBr4lTne6RTBEIzEyKL400LvZ7722W';

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LaundryProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var laundryProvider = Provider.of<LaundryProvider>(context);
    return WillPopScope(
      onWillPop: () {
        // authProvider.loadingValue(false);
        // laundryProvider.loadingValue(false);
        return Future.value(true);
      },
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(child,
            minWidth: 350,
            defaultScale: true,
            defaultScaleFactor: 1,
            breakpoints: const [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.autoScale(600, name: TABLET, scaleFactor: 1),
              ResponsiveBreakpoint.resize(650, name: TABLET, scaleFactor: 1.1),
              ResponsiveBreakpoint.resize(800, name: DESKTOP, scaleFactor: 1.1),
              ResponsiveBreakpoint.resize(1700, name: 'XL', scaleFactor: 1.2),
            ],
            background: Container(color: Colors.black26)),
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Laundry lady',
        theme: Themes.theme,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
