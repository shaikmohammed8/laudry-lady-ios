import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/custom_textfield.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:laundry_lady/widgets/icon_button.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: MediaQuery.of(context).size.width > 600
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: FlutterLogo(
                        size: 70,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        style: Themes.headline,
                        children: [
                          const TextSpan(text: 'Clean your'),
                          TextSpan(
                              text: ' clothes, ',
                              style: Themes.headline
                                  .copyWith(color: Themes.mainColor)),
                          const TextSpan(text: 'here you come'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Pickup dirty returned clean right to your doorstep",
                      style: Themes.overlayText,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      "Enter you postal code",
                      style: Themes.bodyText
                          .copyWith(color: Themes.secondaryColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    Form(
                      key: _formKey,
                      child: CustomTextField(
                        text: "Postal Code",
                        controller: provider.postalCodeController,
                        textType: TextInputType.number,
                        icon: FluentSystemIcons.ic_fluent_location_regular,
                        validator: (String? s) =>
                            !RegExp(RegexPattern.postalCode)
                                    .hasMatch(s.toString())
                                ? 'Enter a valid zip code'
                                : null,
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    DefaultButton(
                        function: () => _emailAuth(provider, context),
                        text: "Sign up with email"),

                    //this is OR divider

                    Row(children: <Widget>[
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Themes.lightColor,
                          height: 50,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "OR",
                            style: Themes.overlayText,
                          )),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Themes.lightColor,
                          height: 50,
                        ),
                      ),
                    ]),

                    IButton(
                      function: () => _facebookAuth(provider, context),
                      text: "Sign up with facebook",
                      icon: SvgPicture.asset(
                        'assets/images/facebook.svg',
                        height: 30.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      color: Themes.secondaryColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width > 600
                            ? 400
                            : double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () => _googleAuth(provider, context),
                          child: Wrap(children: [
                            Text(
                              "Sign up with google",
                              style:
                                  Themes.bodyText.copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              'assets/images/google.svg',
                              height: 30.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ]),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              side: MaterialStateProperty.all(const BorderSide(
                                  width: 2, color: Colors.black))),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Consumer<AuthProvider>(
            builder: (BuildContext context, value, Widget? child) =>
                value.isLoading ? stackLoading : const SizedBox(),
          )
        ],
      ),
    );
  }

  _googleAuth(AuthProvider provider, context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      provider.authType = AuthType.GOOGLE;
      var isNew = await provider.signupWithGoogle(false);
      isNew
          ? Navigator.of(context).pushNamed('/stepper')
          : Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (r) => false);
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(text: handelFirebaseAuthError(e)),
      );
    } finally {
      provider.loadingValue(false);
    }
  }

  _facebookAuth(AuthProvider provider, context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      provider.authType = AuthType.FACEBOOK;

      var isNew = await provider.signupWithFacebook(false);
      isNew
          ? Navigator.of(context).pushNamed('/stepper')
          : Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (r) => false);
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
      if (_formKey.currentState!.validate()) {
        provider.authType = AuthType.EMAIL;
        await provider.signupWithEmail(true);
        Navigator.of(context).pushNamed('/stepper');
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          text: handelFirebaseAuthError(e),
        ),
      );
    } finally {
      provider.loadingValue(false);
    }
  }
}
