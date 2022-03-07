import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/custom_textfield.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:provider/provider.dart';

class PickSchedule extends StatelessWidget {
  const PickSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AuthProvider>(context, listen: false);
    var laundryProvider = Provider.of<LaundryProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            style: Themes.headline,
            children: [
              const TextSpan(text: 'Schedule a '),
              TextSpan(
                text: 'pickup',
                style: Themes.headline.copyWith(color: Themes.mainColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Select a date for your pickup",
          style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
        ),
        DatePicker(
          DateTime.now(),
          height: 88,
          width: 60,
          dateTextStyle: const TextStyle(fontSize: 22),
          daysCount: 100,
          selectionColor: Colors.blue,
          initialSelectedDate: laundryProvider.date,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            laundryProvider.date = date;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Which Laundry Lady services are you planning to use?",
          style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Consumer<LaundryProvider>(
            builder: (context, value, child) => ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  serviceCard(
                      'assets/images/dryclean.svg',
                      'Dry\nClean',
                      1,
                      value,
                      value.dryClean ? Themes.mainColor : Themes.lightColor,
                      context,
                      width),
                  serviceCard(
                      'assets/images/fold.svg',
                      "Wash &\nFold",
                      2,
                      value,
                      value.washAndFold ? Themes.mainColor : Themes.lightColor,
                      context,
                      width),
                  serviceCard(
                      'assets/images/hanger.svg',
                      " Hang \nDry",
                      3,
                      value,
                      value.hangDry ? Themes.mainColor : Themes.lightColor,
                      context,
                      width)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Delivery Instructions",
          style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
        ),
        CustomTextField(
          text: "Delivery instructions (optional) ",
          icon: FluentSystemIcons.ic_fluent_clipboard_letter_regular,
          controller: laundryProvider.instructionController,
          maxLines: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "We pick up and deliver 7 days a week, between 7am and 10pm",
            style: Themes.overlayText,
          ),
        ),
        DefaultButton(
            function: () {
              if (!laundryProvider.dryClean &&
                      !laundryProvider.hangDry &&
                      !laundryProvider.washAndFold ||
                  laundryProvider.date == null) {
                showDialog(
                    context: context,
                    builder: (c) => const CustomDialog(
                          text: 'Please Select date and service to continue',
                        ));
              } else {
                laundryProvider.pickedASchedule = true;
                provider.onScreenChange(provider.stepperScreenIndex + 1);
              }
            },
            text: "Continue"),
        const SizedBox(height: 8),
        Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  provider.onScreenChange(provider.stepperScreenIndex + 1);
                },
                child: const Text("Skip for now"))),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget serviceCard(String svgPath, String name, int at,
      LaundryProvider provider, Color color, context, width) {
    var size = MediaQuery.of(context).size.width - 32;
    return GestureDetector(
      onTap: () {
        provider.selectSevices(at);
      },
      child: Container(
        height: width > 450 && width < 550
            ? 110
            : width > 500
                ? 150
                : size * 0.35,
        width: width > 450 && width < 550
            ? 120
            : width > 500
                ? 150
                : size * 0.3,
        margin: at == 2
            ? EdgeInsets.symmetric(horizontal: size * 0.05)
            : const EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.fromLTRB(size * 0.04, size * 0.04, size * 0.04, 0),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: color),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              svgPath,
              height: width > 450 && width < 550
                  ? 40
                  : width > 500
                      ? 50
                      : size * 0.14,
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style:
                      Themes.overlayText.copyWith(fontSize: 16, color: color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
