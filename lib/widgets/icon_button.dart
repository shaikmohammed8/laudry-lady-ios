import 'package:flutter/material.dart';

import '../utils/theme.dart';

class IButton extends StatelessWidget {
  const IButton(
      {Key? key,
      required this.function,
      required this.text,
      required this.icon,
      this.color = Themes.mainColor})
      : super(key: key);
  final VoidCallback function;
  final String text;
  final Color color;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
      child: ElevatedButton(
          onPressed: function,
          child: Wrap(
            children: [
              Text(
                text,
                style: Themes.bodyText.copyWith(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              icon,
            ],
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          )),
    );
  }
}
