import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/repositories/firesotre_user_repository.dart';
import 'package:laundry_lady/screens/accountscreen/providers/profileprovider.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:laundry_lady/widgets/text_field_borderless.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Profile'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.blueGrey.shade800,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              FutureBuilder<UserModel>(
                  future: FirestoreUserRepository()
                      .getUser(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    return child(snapshot, provider, context);
                  }),
              Consumer<ProfileProvider>(
                builder: (context, value, child) =>
                    value.isLoading ? stackLoading : const SizedBox(),
              )
            ],
          ),
        ));
  }

//
//child animation
//
  Widget child(
      AsyncSnapshot<UserModel> snapshot, ProfileProvider provider, context) {
    if (snapshot.hasData) {
      var _formKey = GlobalKey<FormState>();

      provider.assignToController(snapshot.data!);
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
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
                          "Account Information",
                          style: Themes.blueText,
                        ),
                        TextFieldBorderless(
                            text: "first name",
                            validator: (String? s) =>
                                !RegExp(RegexPattern.username)
                                        .hasMatch(s.toString())
                                    ? 'Enter a valid First Name'
                                    : null,
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_person_regular,
                            controller: provider.firstNameController),
                        TextFieldBorderless(
                            text: "last name",
                            validator: (String? s) =>
                                !RegExp(RegexPattern.username)
                                        .hasMatch(s.toString())
                                    ? 'Enter a valid First Name'
                                    : null,
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_person_regular,
                            controller: provider.lastNameController),
                        TextFieldBorderless(
                            text: "email",
                            validator: (String? s) =>
                                !RegExp(RegexPattern.email)
                                        .hasMatch(s.toString())
                                    ? 'Please enter a valid Email'
                                    : null,
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            controller: provider.emailController),
                        TextFieldBorderless(
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            validator: (String? s) =>
                                !RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                        .hasMatch(s.toString())
                                    ? 'Please Enter a valid number'
                                    : null,
                            text: "phone number",
                            icon: FluentSystemIcons
                                .ic_fluent_phone_mobile_regular,
                            controller: provider.phoneNumberController),
                      ],
                    ),
                  ),
                ),
                Card(
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
                          "Service Address",
                          style: Themes.blueText,
                        ),
                        TextFieldBorderless(
                            text: "address",
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_building_regular,
                            controller: provider.addressController),
                        TextFieldBorderless(
                            text: "apartment",
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_home_regular,
                            controller: provider.apartmentController),
                        TextFieldBorderless(
                            text: "zip code",
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_location_regular,
                            controller: provider.postalCodeController),
                        TextFieldBorderless(
                            text: "city",
                            onChange: (String? s) =>
                                onChange(s, provider, snapshot.data!),
                            icon: FluentSystemIcons.ic_fluent_city_regular,
                            controller: provider.cityController),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ProfileProvider>(
                    builder: (context, value, child) => DefaultButton(
                      text: "Save",
                      function: value.isDisabled
                          ? null
                          : () => onTap(provider, context, _formKey),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(child: loading);
    }
  }

  void onTap(
      ProfileProvider provider, context, GlobalKey<FormState> formkey) async {
    if (formkey.currentState!.validate()) {
      try {
        provider.changeLoading(true);
        await provider.save();
        showModal(
          configuration: dialogConfig,
          context: context,
          builder: (_) => const CustomDialog(
            text: "Profile updated successfully",
            icon: FluentSystemIcons.ic_fluent_checkmark_circle_regular,
            color: Themes.mainColor,
          ),
        );
      } on Exception catch (e) {
        showModal(
            configuration: dialogConfig,
            context: context,
            builder: (s) => CustomDialog(text: handelFirebaseAuthError(e)));
      } finally {
        provider.changeLoading(false);
      }
    }
  }

  onChange(s, ProfileProvider provider, UserModel user) {
    provider.hasAnyChanges(user);
  }
}
