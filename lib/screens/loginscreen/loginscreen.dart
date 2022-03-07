import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/custom_textfield.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:laundry_lady/widgets/icon_button.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
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
                          const TextSpan(text: 'Log in to your'),
                          TextSpan(
                              text: ' Account',
                              style: Themes.headline
                                  .copyWith(color: Themes.mainColor))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Welcome back! We missed you!",
                      style: Themes.overlayText,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Enter you Email and password",
                        style: Themes.bodyText
                            .copyWith(color: Themes.secondaryColor),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 600
                            ? 500
                            : double.infinity,
                        child: Column(
                          children: [
                            Form(
                              key: _emailForm,
                              child: CustomTextField(
                                  text: "Email",
                                  icon:
                                      FluentSystemIcons.ic_fluent_mail_regular,
                                  textType: TextInputType.emailAddress,
                                  validator: (String? s) =>
                                      !RegExp(RegexPattern.email)
                                              .hasMatch(s.toString())
                                          ? 'Please enter a valid Email'
                                          : null,
                                  controller: provider.emailController),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                                text: "Password",
                                icon: FluentSystemIcons.ic_fluent_lock_regular,
                                textType: TextInputType.visiblePassword,
                                validator: (String? s) => s.toString().isEmpty
                                    ? 'Password is required'
                                    : null,
                                controller: provider.passwordController),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () =>
                                    _forgotPasswrod(provider, context),
                                child: Text(
                                  "forgot password?",
                                  style: Themes.overlayText
                                      .copyWith(color: Themes.secondaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                        function: () => _emailAuth(provider, context),
                        text: "Log in With Email"),

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
                      text: "Log in with FACEBOOK",
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
                              "Log in with Google",
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
                value.isLoading
                    ? Center(
                        child: Container(
                          height: double.infinity,
                          color: Colors.white54,
                          child: LottieBuilder.asset(
                              "assets/images/lf30_editor_woxbbkbs.json"),
                        ),
                      )
                    : const SizedBox(),
          )
        ],
      ),
    );
  }

  _googleAuth(provider, context) async {
    try {
      provider.authType = AuthType.GOOGLE;
      var isNew = await provider.signupWithGoogle(true);
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
      provider.authType = AuthType.FACEBOOK;

      var isNew = await provider.signupWithFacebook(true);
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
        await provider.singInWithEmail();

        Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
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

  _forgotPasswrod(AuthProvider provider, context) async {
    try {
      if (_emailForm.currentState!.validate()) {
        await provider.resetPassword();
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
              color: Colors.green,
              icon: FluentSystemIcons.ic_fluent_checkmark_circle_regular,
              text: "Check your email to reset your password"),
        );
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
