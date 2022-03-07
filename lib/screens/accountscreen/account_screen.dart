import 'package:animations/animations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/repositories/auth_repositories.dart';
import 'package:laundry_lady/screens/orderscreen/order_screen.dart';
import 'package:laundry_lady/screens/accountscreen/providers/profileprovider.dart';
import 'package:laundry_lady/screens/accountscreen/views/listtile_custom.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:provider/provider.dart';

import 'screens/profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listData.length + 1,
                itemBuilder: (context, index) => index == listData.length
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultButton(
                            function: () async {
                              await AuthRepository().signOut();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            },
                            text: 'Logout'),
                      )
                    : OpenContainer(
                        closedColor: Colors.grey.shade200,
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionType: ContainerTransitionType.fadeThrough,
                        openElevation: 0,
                        closedElevation: 0,
                        openBuilder: (BuildContext context,
                            void Function({Object? returnValue}) action) {
                          return listData[index]['widget'];
                        },
                        closedBuilder: (context, action) => ListTileCustom(
                            icon: listData[index]['icon'],
                            title: listData[index]['title'],
                            subtitle: listData[index]['subtitle']),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> listData = [
  {
    'icon': FluentSystemIcons.ic_fluent_person_regular,
    'title': 'Profile',
    'subtitle': 'your personal information',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: const ProfileScreen()),
  },
  {
    'icon': FluentSystemIcons.ic_fluent_history_regular,
    'title': 'Orders history',
    'subtitle': 'view your previous orders',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: const OrderScreen()),
  },
  {
    'icon': FluentSystemIcons.ic_fluent_settings_regular,
    'title': 'Preferences',
    'subtitle': 'view your preferences',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: Container()),
  },
  {
    'icon': FluentSystemIcons.ic_fluent_payment_regular,
    'title': 'Payment',
    'subtitle': 'update your payment',
  },
  {
    'icon': Icons.delivery_dining_outlined,
    'title': 'Laundry go',
    'subtitle': 'access to laundry Go services',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: Container()),
  },
  {
    'icon': FluentSystemIcons.ic_fluent_arrow_repeat_all_regular,
    'title': 'Repeat',
    'subtitle': 'access to repeat services',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: Container()),
  },
  {
    'icon': FluentSystemIcons.ic_fluent_thumb_like_regular,
    'title': 'Rate us',
    'subtitle': 'rate us on the app store',
    'widget': ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: Container()),
  }
];
