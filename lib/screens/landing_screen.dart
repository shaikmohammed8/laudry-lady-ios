import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/paints/curvedpath.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:laundry_lady/widgets/border_button.dart';
import 'package:laundry_lady/widgets/default_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: MediaQuery.of(context).size.width > 600
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: FlutterLogo(
                    size: 70,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: Themes.headline,
                    children: [
                      const TextSpan(text: 'Hello! Do you need a'),
                      TextSpan(
                        text: ' Laundry',
                        style:
                            Themes.headline.copyWith(color: Themes.mainColor),
                      ),
                      const TextSpan(text: ' Tonight?'),
                    ],
                  ),
                ),
                Text(
                    "Dry cleaning & laundry service - You order > We collect > We clean > We deliver",
                    style: Themes.overlayText),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: ClipPath(
                    clipper: CustomPain(),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width > 600
                          ? 500
                          : double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Themes.secondaryColor.withOpacity(0.8),
                              Colors.blue.shade800
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Get \$20",
                                      style: Themes.headline
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Welcome credit\n for new customers",
                                    textAlign: TextAlign.center,
                                    style: Themes.bodyText
                                        .copyWith(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/images/wallet.svg',
                              height: 80.0,
                              width: 80.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultButton(
                        text: "Sign up for a FREE account",
                        function: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BorderButton(
                          function: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          text: "Log in into your account"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
