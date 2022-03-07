import 'package:flutter/material.dart';
import 'package:laundry_lady/utils/theme.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    Key? key,
    required this.function,
    required this.text,
    this.color = Themes.mainColor,
  }) : super(key: key);
  final VoidCallback function;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
        height: 60,
        child: OutlinedButton(
          onPressed: function,
          child: Text(
            text,
            style: Themes.bodyText.copyWith(color: color),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
              side: MaterialStateProperty.all(
                  BorderSide(width: 2, color: color))),
        ));
    // child: Material(
    //   color: Colors.transparent,
    //   elevation: 0,
    //   borderRadius: BorderRadius.circular(15),
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(15),
    //     onTap: function,
    //     child: CustomPaint(
    //       painter: _Painter(
    //           const LinearGradient(
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               colors: [Color(0XFF81FBB8), Color(0XFF28C76F)]),
    //           const Radius.circular(15),
    //           2,
    //           const Corners(
    //               bottomLeft: Radius.circular(15),
    //               bottomRight: Radius.circular(15),
    //               topLeft: Radius.circular(15),
    //               topRight: Radius.circular(15))),
    //       child: Center(
    //           child: Text(
    //         text,
    //         style: Themes.bodytext.copyWith(color: Themes.mainColor),
    //       )),
    //     ),
    //   ),
    // ));r
  }
  // (
  //   onPressed: function,
  //   child: Text(
  //     text,
  //     style: Themes.bodytext.copyWith(color: Themes.mainColor),
  //   ),
  //   style: ButtonStyle(
  //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       )),
  //       side: MaterialStateProperty.all(
  //           const BorderSide(width: 1.5, color: Themes.mainColor))),
  // ));

}

// class _Painter extends CustomPainter {
//   final Gradient gradient;
//   final Radius? radius;
//   final double strokeWidth;
//   final Corners? corners;

//   _Painter(this.gradient, this.radius, this.strokeWidth, this.corners);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Rect rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2,
//         size.width - strokeWidth, size.height - strokeWidth);
//     final RRect rRect = corners != null
//         ? RRect.fromRectAndCorners(
//             rect,
//             topLeft: corners!.topLeft,
//             topRight: corners!.topRight,
//             bottomLeft: corners!.bottomLeft,
//             bottomRight: corners!.bottomRight,
//           )
//         : RRect.fromRectAndRadius(rect, radius ?? Radius.zero);
//     final Paint _paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..shader = gradient.createShader(rect);
//     canvas.drawRRect(rRect, _paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
// }

// class Corners {
//   final Radius topLeft;
//   final Radius topRight;
//   final Radius bottomLeft;
//   final Radius bottomRight;

//   const Corners({
//     this.topLeft = Radius.zero,
//     this.topRight = Radius.zero,
//     this.bottomLeft = Radius.zero,
//     this.bottomRight = Radius.zero,
//   });
// }
