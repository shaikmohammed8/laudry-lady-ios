import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key, required this.svg, required this.title, required this.price})
      : super(key: key);
  final String svg;
  final String title;
  final int price;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LaundryProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        leading: SvgPicture.network(svg,
            height: 50,
            placeholderBuilder: (context) => const CircleAvatar(
                  backgroundColor: Themes.lightColor,
                  radius: 25,
                )),
        title: Text(title),
        subtitle: Text(
          '\$' + price.toString(),
          style:
              Themes.blueText.copyWith(fontSize: 15, color: Themes.mainColor),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: () => provider.removeFromList(title, price),
              child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(
                    CupertinoIcons.minus,
                    size: 15,
                    color: Colors.black,
                  )),
            ),
            SizedBox(
              width: 25,
              child: Consumer<LaundryProvider>(
                  builder: (context, value, child) => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Text(
                            value.getItemCountFromList(title).toString(),
                            key: Key(
                                value.getItemCountFromList(title).toString())),
                      )),
            ),
            GestureDetector(
              onTap: () {
                provider.addToList(title, price);
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(
                  CupertinoIcons.add,
                  size: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
