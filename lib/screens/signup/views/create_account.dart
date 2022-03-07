import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/custom_textfield.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    var provider = Provider.of<AuthProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text.rich(
            TextSpan(
              style: Themes.headline,
              children: [
                const TextSpan(text: 'Create your'),
                TextSpan(
                  text: ' Account',
                  style: Themes.headline.copyWith(color: Themes.mainColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Account Information",
            style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
          ),
          CustomTextField(
              text: "First Name",
              icon: FluentSystemIcons.ic_fluent_person_regular,
              validator: (String? s) =>
                  !RegExp(RegexPattern.username).hasMatch(s.toString())
                      ? 'Enter a valid First Name'
                      : null,
              controller: provider.firstNameController,
              textType: TextInputType.name),
          const SizedBox(height: 8),
          CustomTextField(
              text: "Last Name",
              validator: (String? s) =>
                  !RegExp(RegexPattern.username).hasMatch(s.toString())
                      ? 'Enter a valid last Name'
                      : null,
              icon: FluentSystemIcons.ic_fluent_person_regular,
              textType: TextInputType.name,
              controller: provider.lastNameController),
          const SizedBox(height: 8),
          CustomTextField(
              text: "Email",
              readOnly: provider.authType != AuthType.EMAIL ? true : false,
              icon: FluentSystemIcons.ic_fluent_mail_regular,
              textType: TextInputType.emailAddress,
              validator: (String? s) =>
                  !RegExp(RegexPattern.email).hasMatch(s.toString())
                      ? 'Please enter a valid Email'
                      : null,
              controller: provider.emailController),
          const SizedBox(height: 8),
          provider.authType == AuthType.EMAIL
              ? CustomTextField(
                  text: "Password",
                  icon: FluentSystemIcons.ic_fluent_lock_regular,
                  textType: TextInputType.visiblePassword,
                  validator: (String? s) => !RegExp(RegexPattern.password)
                          .hasMatch(s.toString())
                      ? 'password should be 8 characters long and contain at least one uppercase and one special character'
                      : null,
                  controller: provider.passwordController)
              : const SizedBox(),
          const SizedBox(height: 8),
          CustomTextField(
              text: "Mobile Number",
              icon: FluentSystemIcons.ic_fluent_phone_regular,
              textType: TextInputType.number,
              validator: (String? s) =>
                  !RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                          .hasMatch(s.toString())
                      ? 'Please Enter a valid number'
                      : null,
              controller: provider.phoneNumberController),
          const SizedBox(height: 16),
          Text(
            "Service Address",
            style: Themes.bodyText.copyWith(color: Themes.secondaryColor),
          ),
          CustomTextField(
              text: "Address",
              icon: FluentSystemIcons.ic_fluent_building_regular,
              textType: TextInputType.streetAddress,
              validator: (String? s) =>
                  s!.length < 10 ? 'Enter a valid address' : null,
              controller: provider.addressController),
          const SizedBox(height: 8),
          CustomTextField(
              text: "Apartment # (optional)",
              textType: TextInputType.streetAddress,
              icon: FluentSystemIcons.ic_fluent_home_regular,
              controller: provider.apartmentController),
          const SizedBox(height: 8),
          CustomTextField(
              text: "Postal Code",
              icon: FluentSystemIcons.ic_fluent_location_regular,
              textType: TextInputType.number,
              validator: (String? s) =>
                  !RegExp(RegexPattern.postalCode).hasMatch(s.toString())
                      ? 'Enter a valid zip code'
                      : null,
              controller: provider.postalCodeController),
          const SizedBox(height: 8),
          CustomTextField(
              text: "City",
              icon: FluentSystemIcons.ic_fluent_city_regular,
              validator: (String? s) =>
                  s!.length < 3 ? 'Enter a valid city name' : null,
              controller: provider.cityController),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Center(
            child: DefaultButton(
                function: () async {
                  if (_formKey.currentState!.validate()) {
                    switch (provider.authType) {
                      case AuthType.GOOGLE:
                        _facebookAndGoogleAuth(provider, context);
                        break;
                      case AuthType.EMAIL:
                        _emailAuth(provider, context);
                        break;
                      case AuthType.FACEBOOK:
                        _facebookAndGoogleAuth(provider, context);
                        break;
                      default:
                    }
                  }
                },
                text: "Continue"),
          ),
        ],
      ),
    );
  }

//
//other functions
//

  _facebookAndGoogleAuth(AuthProvider provider, context) async {
    try {
      await provider.updateUser();
      if (provider.stepperScreenIndex != 2) {
        provider.onScreenChange(provider.stepperScreenIndex + 1);
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(text: handelFirebaseAuthError(e)),
      );
    } finally {
      provider.loadingValue(false);
    }
  }

  _emailAuth(AuthProvider provider, context) async {
    try {
      await provider.signupWithEmail(false);
      if (provider.stepperScreenIndex != 2) {
        provider.onScreenChange(provider.stepperScreenIndex + 1);
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(text: handelFirebaseAuthError(e)),
      );
    } finally {
      provider.loadingValue(false);
    }
  }
}
