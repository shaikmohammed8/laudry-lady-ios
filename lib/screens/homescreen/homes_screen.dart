import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:laundry_lady/screens/createorderscreen/create_order.dart';
import 'package:laundry_lady/utils/app_icons_icons.dart';
import 'package:laundry_lady/screens/accountscreen/account_screen.dart';
import 'package:laundry_lady/screens/helpscreen/help_screen.dart';
import 'package:laundry_lady/screens/orderscreen/order_screen.dart';
import 'package:laundry_lady/screens/pricingscreen/prcing_screen.dart';
import 'package:laundry_lady/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screens = [
    const AccountScreen(),
    const OrderScreen(),
    const CreateOrderScreen(),
    const PricingScreen(),
    const HelpScreen()
  ];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 5,
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedIconTheme: const IconThemeData(size: 28),
        selectedItemColor: Themes.mainColor,
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        unselectedItemColor: Themes.lightColor,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(FluentSystemIcons.ic_fluent_person_regular),
              label: circle()),
          BottomNavigationBarItem(
              icon: Transform.scale(
                  scale: 1.2, child: const Icon(AppIcons.image)),
              label: circle()),
          BottomNavigationBarItem(
              icon: const Icon(FluentSystemIcons.ic_fluent_apps_add_in_regular),
              label: circle()),
          BottomNavigationBarItem(
              icon: Transform.scale(
                  scale: 1.2, child: const Icon(AppIcons.money)),
              label: circle()),
          BottomNavigationBarItem(
              icon: const Icon(FluentSystemIcons.ic_fluent_chat_help_regular),
              label: circle()),
        ],
      ),
    );
  }

  String circle() {
    return '●';
  }
}
