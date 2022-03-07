import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/providers/preference.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:laundry_lady/widgets/text_field_borderless.dart';
import 'package:provider/provider.dart';

class DeliveryPreferences extends StatelessWidget {
  const DeliveryPreferences(
      {Key? key, required this.data, required this.provider})
      : super(key: key);
  final UserModel data;
  final PreferenceProvider provider;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Preferences",
                  style: Themes.blueText,
                ),
                const SizedBox(height: 8),
                TextFieldBorderless(
                    text: "name",
                    validator: (String? s) =>
                        !RegExp(RegexPattern.username).hasMatch(s.toString())
                            ? 'Enter a valid First Name'
                            : null,
                    icon: FluentSystemIcons.ic_fluent_person_regular,
                    controller: provider.nameController,
                    onChange: (s) {}),
                TextFieldBorderless(
                    validator: (String? s) =>
                        s!.length < 10 ? 'Enter a valid address' : null,
                    text: "address",
                    icon: FluentSystemIcons.ic_fluent_building_regular,
                    controller: provider.addressController,
                    onChange: (s) {}),
                TextFieldBorderless(
                    text: "apartment # (optional)",
                    icon: FluentSystemIcons.ic_fluent_home_regular,
                    controller: provider.apartmentController,
                    onChange: (s) {}),
                TextFieldBorderless(
                    text: "city",
                    icon: FluentSystemIcons.ic_fluent_city_regular,
                    controller: provider.cityController,
                    validator: (String? s) =>
                        s!.length < 3 ? 'Enter a valid city name' : null,
                    onChange: (s) {}),
                TextFieldBorderless(
                    text: "postal code",
                    validator: (String? s) =>
                        !RegExp(RegexPattern.postalCode).hasMatch(s.toString())
                            ? 'Enter a valid zip code'
                            : null,
                    icon: FluentSystemIcons.ic_fluent_location_regular,
                    controller: provider.postalCodeController,
                    onChange: (s) {}),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Consumer<PreferenceProvider>(
                        builder: (context, value, child) => Checkbox(
                            value: value.isExpress,
                            onChanged: (value) {
                              provider.express(value!);
                            })),
                    const SizedBox(width: 8),
                    Text("Next day Delivery ", style: Themes.bodyText),
                    Flexible(
                      child: FittedBox(
                        child: Text('(5\$)',
                            style: Themes.bodyText
                                .copyWith(color: Themes.lightColor)),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
