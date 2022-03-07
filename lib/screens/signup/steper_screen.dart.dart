import 'package:flutter/material.dart';
import 'package:laundry_lady/providers/authprovider.dart';
import 'package:laundry_lady/screens/signup/views/create_account.dart';
import 'package:laundry_lady/screens/signup/views/payment_method.dart';
import 'package:laundry_lady/screens/signup/views/pick_schedule.dart';
import 'package:laundry_lady/utils/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        await Future.delayed(const Duration(seconds: 0));
        if (provider.stepperScreenIndex == 0) {
          provider.close();
          return true;
        } else {
          provider.onScreenChange(provider.stepperScreenIndex - 1);
          return false;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (provider.stepperScreenIndex == 0) {
                                  Navigator.pop(context);
                                } else {
                                  provider.onScreenChange(
                                      provider.stepperScreenIndex - 1);
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Themes.secondaryColor,
                                size: 20,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 72,
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) => Theme(
                                data: ThemeData(
                                    canvasColor: Colors.white,
                                    colorScheme: Theme.of(context)
                                        .colorScheme
                                        .copyWith(onSurface: Colors.grey)),
                                child: Stepper(
                                  elevation: 0,
                                  currentStep: value.stepperScreenIndex,
                                  steps: [
                                    Step(
                                        state: value.stepperScreenIndex > 0
                                            ? StepState.complete
                                            : StepState.indexed,
                                        title: const SizedBox(),
                                        content: const SizedBox(),
                                        isActive:
                                            value.stepperScreenIndex >= 0),
                                    Step(
                                        state: value.stepperScreenIndex > 1
                                            ? StepState.complete
                                            : StepState.indexed,
                                        title: const SizedBox(),
                                        content: const SizedBox(),
                                        isActive:
                                            value.stepperScreenIndex >= 1),
                                    Step(
                                        title: const SizedBox(),
                                        content: const SizedBox(),
                                        isActive: value.stepperScreenIndex >= 2)
                                  ],
                                  type: StepperType.horizontal,
                                  controlsBuilder: (ctx, details) {
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          switch (value.stepperScreenIndex) {
                            case 0:
                              return const CreateAccount();
                            case 1:
                              return const PickSchedule();
                            case 2:
                              return const PaymentMethod();
                            default:
                              return Container();
                          }
                        },
                      ),
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
      ),
    );
  }
}
