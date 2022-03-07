import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/screens/createorderscreen/views/dry_clean.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:provider/provider.dart';

import 'views/hang_dry.dart';
import 'views/wash_and_fold.dart';

class SelectItemsScreen extends StatelessWidget {
  const SelectItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LaundryProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Select items'),
          actions: [
            TextButton(
                onPressed: () {
                  provider.clearAll();
                },
                child: const Text('Clear'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<LaundryProvider>(
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: 60,
                  child: CupertinoSlidingSegmentedControl(
                    children: {
                      0: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Dry Clean',
                            style: TextStyle(
                                color: value.tabIndex == 0
                                    ? Colors.white
                                    : Colors.black),
                          )),
                      1: Text(
                        'hang Dry',
                        style: TextStyle(
                            color: value.tabIndex == 1
                                ? Colors.white
                                : Colors.black),
                      ),
                      2: Text(
                        'Wash And Fold',
                        style: TextStyle(
                            color: value.tabIndex == 2
                                ? Colors.white
                                : Colors.black),
                      ),
                    },
                    groupValue: value.tabIndex,
                    thumbColor: Themes.mainColor.withOpacity(0.7),
                    backgroundColor: Themes.mainColor.withOpacity(0.1),
                    onValueChanged: (value) {
                      provider.changeTab(value as int);
                    },
                  ),
                ),
                value.tabIndex == 0
                    ? DryClean(provider: provider)
                    : value.tabIndex == 1
                        ? HangDry(provider: provider)
                        : WashAndFold(provider: provider),
              ],
            ),
          ),
        ));
  }
}
