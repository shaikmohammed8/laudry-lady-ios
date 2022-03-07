import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/widgets/custom_textfield.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LaundryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: Themes.headline,
                  children: [
                    const TextSpan(text: 'Select '),
                    TextSpan(
                      text: ' Payment',
                      style: Themes.headline.copyWith(color: Themes.mainColor),
                    ),
                  ],
                ),
              ),
              Text(
                "your data and transaction information are secured by Stripe payment gateway ",
                style: Themes.overlayText,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Insert you card details",
                style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                  validator: (String? s) =>
                      s!.length < 10 ? 'Enter a valid card number' : null,
                  text: "Card number",
                  icon: FluentSystemIcons.ic_fluent_payment_regular,
                  textType: TextInputType.number,
                  controller: provider.cardNumberController),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: CupertinoDatePicker(
                                          minimumDate: DateTime.now(),
                                          minuteInterval: 1,
                                          dateOrder: DatePickerDateOrder.ydm,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged:
                                              (DateTime dateTime) {
                                            provider.cardDateController.text =
                                                DateFormat('MM/yy')
                                                    .format(dateTime);
                                          },
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Done"))
                                    ],
                                  ),
                                ));
                      },
                      child: IgnorePointer(
                        child: CustomTextField(
                            validator: (String? s) =>
                                s!.isEmpty ? 'Date is required' : null,
                            text: "mm/yy",
                            textType: TextInputType.datetime,
                            readOnly: true,
                            icon: FluentSystemIcons
                                .ic_fluent_calendar_date_regular,
                            controller: provider.cardDateController),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CustomTextField(
                        validator: (String? s) =>
                            s!.length != 3 ? 'Enter a valid Cvv' : null,
                        text: "CVV",
                        icon: FluentSystemIcons.ic_fluent_lock_shield_regular,
                        textType: TextInputType.number,
                        controller: provider.cardCvvController),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  validator: (String? s) =>
                      s!.length < 3 ? 'Enter a valid name' : null,
                  text: "Card Holder",
                  icon: FluentSystemIcons.ic_fluent_person_accounts_regular,
                  controller: provider.cardHolderController),
              const SizedBox(
                height: 22,
              ),
              DefaultButton(
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      authProvider.loadingValue(true);
                      await provider.addCard();
                      authProvider.loadingValue(false);
                      provider.pickedASchedule
                          ? Navigator.of(context).pushNamedAndRemoveUntil(
                              '/clothe', (Route<dynamic> route) => false)
                          : Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                    }
                  },
                  text: "Continue"),
              const SizedBox(
                height: 8,
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        provider.pickedASchedule
                            ? Navigator.of(context).pushNamedAndRemoveUntil(
                                '/clothe', (Route<dynamic> route) => false)
                            : Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                      },
                      child: const Text("not now")))
            ],
          ),
        ),
      ],
    );
  }
}
