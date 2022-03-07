import 'package:flutter/material.dart';
import 'package:laundry_lady/utils/theme.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.function,
      required this.text,
      this.color = Themes.mainColor})
      : super(key: key);
  final VoidCallback? function;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
        child: ElevatedButton(
            onPressed: function,
            child: Text(
              text,
              style: Themes.bodyText.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            )),
      ),
    );
    // return Container(
    //   width: double.infinity,
    //   height: 60,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15),
    //       color: Color(0XFF01c162),
    //       boxShadow: [
    //         BoxShadow(
    //           color: const Color(0XFF81FBB8).withOpacity(0.5),
    //           offset: const Offset(0.0, 2),
    //           blurRadius: 2,
    //         ),
    //       ]),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(15),
    //     child: Material(
    //       color: Colors.transparent,
    //       child: InkWell(
    //           onTap: function,
    //           child: Center(
    //             child: Text(
    //               text,
    //               style: Themes.bodytext.copyWith(color: Colors.white),
    //             ),
    //           )),
    //     ),
    //   ),
    // );
  }
}
