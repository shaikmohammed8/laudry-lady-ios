import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/models/item_model.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/repositories/laundry_firestore.dart';
import 'package:laundry_lady/screens/createorderscreen/views/item_card.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:provider/provider.dart';

class DryClean extends StatelessWidget {
  const DryClean({Key? key, required this.provider}) : super(key: key);
  final LaundryProvider provider;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ItemModel>>(
        future: LaundryFirestore().getItems(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Flexible(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Dry Clean",
                                    style: Themes.blueText,
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () => provider.closeAll(),
                                      child: const Text("close all"))
                                ],
                              ),
                            ),
                            Consumer<LaundryProvider>(
                              builder: (context, value, child) =>
                                  ExpansionPanelList(
                                expandedHeaderPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                elevation: 0,
                                expansionCallback: (panelIndex, isExpanded) =>
                                    provider.changePanel(panelIndex),
                                children: [
                                  ExpansionPanel(
                                      isExpanded: value.opened[0],
                                      canTapOnHeader: true,
                                      headerBuilder: (context, isExpanded) =>
                                          headerText("Tops"),
                                      body: getListView(snapshot.data!, 'top')),
                                  ExpansionPanel(
                                      canTapOnHeader: true,
                                      isExpanded: value.opened[1],
                                      headerBuilder: (context, isExpanded) =>
                                          headerText("Bottom"),
                                      body: getListView(
                                          snapshot.data!, 'bottom')),
                                  ExpansionPanel(
                                      isExpanded: value.opened[2],
                                      canTapOnHeader: true,
                                      headerBuilder: (context, isExpanded) =>
                                          headerText("Full Body"),
                                      body: getListView(
                                          snapshot.data!, 'full body')),
                                  ExpansionPanel(
                                      isExpanded: value.opened[3],
                                      canTapOnHeader: true,
                                      headerBuilder: (context, isExpanded) =>
                                          headerText("Accessories"),
                                      body: getListView(
                                          snapshot.data!, 'Accessories')),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      bottomListWidget(provider, context)
                    ],
                  )),
                )
              : Center(
                  child: loading,
                );
        });
  }

  ListView getListView(List<ItemModel> items, String category) {
    List<ItemModel> newItems =
        items.where((element) => element.category == category).toList();

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: newItems.length,
        itemBuilder: (context, index) => newItems[index].category == category
            ? ItemCard(
                svg: newItems[index].imagePath,
                title: newItems[index].title,
                price: newItems[index].price)
            : const SizedBox());
  }

  Padding headerText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Themes.bodyText,
      ),
    );
  }

  Widget bottomListWidget(LaundryProvider provider, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
              function: () async {
                if (provider.totalPrice >= 30) {
                  Navigator.pushNamed(context, '/detail');
                } else {
                  showModal(
                    context: context,
                    configuration: dialogConfig,
                    builder: (context) => const CustomDialog(
                        text: "The total price should be more than 30\$"),
                  );
                }
              },
              text: 'Next'),
        ),
        Wrap(
          children: [
            Text("Total price ", style: Themes.blueText),
            Consumer<LaundryProvider>(
                builder: (context, value, child) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Text(
                      value.totalPrice.toString(),
                      key: Key(value.totalPrice.toString()),
                      style: Themes.blueText,
                    ))),
            Text(" \$", style: Themes.blueText),
          ],
        )
      ],
    );
  }
}
