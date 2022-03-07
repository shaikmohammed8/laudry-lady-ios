import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry_lady/providers/preference.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../utils/theme.dart';

class CleaningPreferences extends StatelessWidget {
  const CleaningPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PreferenceProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cleaning preferences", style: Themes.blueText),
              ...radioCard(
                  svgPath: "assets/images/detergent.svg",
                  heading: "Detergent",
                  firstChoice: hypoallergenic,
                  value: value.detergent,
                  secondChoice: regular,
                  sFun: (_) => value.changeDetergentVal(regular),
                  fun: (_) => value.changeDetergentVal(hypoallergenic)),
              const SizedBox(height: 8),
              ...radioCard(
                  svgPath: "assets/images/fabric.svg",
                  heading: "Fabric softener",
                  firstChoice: hypoallergenic,
                  value: value.fabric,
                  secondChoice: regular,
                  sFun: (_) => value.changeFabricVal(regular),
                  fun: (_) => value.changeFabricVal(hypoallergenic)),
              const SizedBox(height: 8),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/images/shirt.svg",
                      height: 30, color: Colors.black),
                ),
                Text.rich(TextSpan(
                    style: Themes.bodyText.copyWith(fontSize: 16),
                    children: [
                      const TextSpan(text: "Starch "),
                      TextSpan(
                        text: "(Press only)",
                        style: Themes.blueText.copyWith(fontSize: 14),
                      )
                    ])),
                MediaQuery.of(context).size.width > 800
                    ? const SizedBox(
                        width: 50,
                      )
                    : const Spacer(),
                DropdownButton<String>(
                  value: value.starch,
                  items: <String>['None', 'Light', 'Medium', 'Heavy']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    value.changeStarchVal(val);
                  },
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> radioCard(
      {required String svgPath,
      required String heading,
      required String firstChoice,
      required String value,
      required sFun,
      required fun,
      required secondChoice}) {
    return [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              svgPath,
              height: 30,
              color: Colors.black,
            ),
          ),
          Text(
            heading,
            style: Themes.bodyText.copyWith(fontSize: 16),
          ),
        ],
      ),
      Row(children: [
        Checkbox(
          shape: const CircleBorder(),
          value: value == firstChoice,
          onChanged: fun,
        ),
        InkWell(
          onTap: () => fun(true),
          child: Text(
            firstChoice,
            style: Themes.overlayText.copyWith(
                color: firstChoice == value ? Colors.black : Themes.lightColor),
          ),
        ),
        const SizedBox(width: 8),
        Checkbox(
          shape: const CircleBorder(),
          value: value == secondChoice,
          onChanged: sFun,
        ),
        InkWell(
          onTap: () => sFun(true),
          child: Text(
            secondChoice,
            style: Themes.overlayText.copyWith(
                color:
                    secondChoice == value ? Colors.black : Themes.lightColor),
          ),
        ),
      ]),
    ];
  }
}
