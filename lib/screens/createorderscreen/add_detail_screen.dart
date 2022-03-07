import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/models/user_model.dart';
import 'package:laundry_lady/providers/laundry_provider.dart';
import 'package:laundry_lady/providers/preference.dart';
import 'package:laundry_lady/repositories/firesotre_user_repository.dart';
import 'package:laundry_lady/screens/createorderscreen/views/cleaning_preferences.dart';
import 'package:laundry_lady/screens/createorderscreen/views/delivery_preferences.dart';
import 'package:laundry_lady/utils/utils.dart';
import 'package:laundry_lady/widgets/custom_dialog.dart';
import 'package:laundry_lady/widgets/default_button.dart';
import 'package:provider/provider.dart';

class AddDetailScreen extends StatelessWidget {
  const AddDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PreferenceProvider>(context, listen: false);
    var _formKey = GlobalKey<FormState>();
    var laundryProvider = Provider.of<LaundryProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<UserModel>(
                future: FirestoreUserRepository()
                    .getUser(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    provider.addToText(snapshot.data!);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const CleaningPreferences(),
                          const SizedBox(
                            height: 8,
                          ),
                          Form(
                            key: _formKey,
                            child: DeliveryPreferences(
                              data: snapshot.data!,
                              provider: provider,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DefaultButton(
                              function: () {
                                onTap(_formKey, laundryProvider, provider,
                                    context);
                              },
                              text: "Next")
                        ],
                      ),
                    );
                  } else {
                    return Center(child: loading);
                  }
                }),
          ),
          Consumer<LaundryProvider>(
            builder: (context, value, child) =>
                value.isLoading ? stackLoading : const SizedBox(),
          )
        ],
      ),
    );
  }

  onTap(GlobalKey<FormState> _formKey, LaundryProvider laundryProvider,
      PreferenceProvider provider, context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await laundryProvider.makeOrder(
            city: provider.cityController.text,
            postalCode: provider.postalCodeController.text,
            name: provider.nameController.text,
            phone: provider.nameController.text,
            address: provider.addressController.text,
            starch: provider.starch,
            fabricSoftener: provider.fabric,
            detergent: provider.detergent);
      } on Exception catch (e) {
        showDialog(
            context: context, builder: (c) => CustomDialog(text: e.toString()));
      } finally {
        laundryProvider.loadingValue(false);
      }
    }
  }
}
