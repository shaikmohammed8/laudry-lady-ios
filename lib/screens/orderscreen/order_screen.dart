import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundry_lady/models/order_model.dart';
import 'package:laundry_lady/repositories/laundry_firestore.dart';
import 'package:laundry_lady/utils/utils.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Order Status'),
      ),
      body: FutureBuilder<List<OrderModel>>(
          future: LaundryFirestore().getOrders(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ExpansionTile(
                            collapsedBackgroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            leading: CircleAvatar(
                                child: Text(snapshot.data!
                                        .elementAt(index)
                                        .price
                                        .toString() +
                                    '\$')),
                            title: Text(DateFormat('dd MMM yyyy').format(
                                DateTime.parse(snapshot.data![index].date))),
                            children: [
                              Stepper(
                                  elevation: 0,
                                  currentStep: 3,
                                  controlsBuilder: (context, details) =>
                                      const SizedBox(),
                                  steps: const [
                                    Step(
                                        state: StepState.complete,
                                        isActive: true,
                                        title: Text("Ordered"),
                                        content: SizedBox()),
                                    Step(
                                        title: Text("Ready for Pickup"),
                                        content: SizedBox()),
                                    Step(
                                        title: Text("Picked up"),
                                        content: SizedBox()),
                                    Step(
                                        isActive: true,
                                        title: Text("Washing"),
                                        content: SizedBox()),
                                    Step(
                                        title: Text("Out for delivery"),
                                        content: SizedBox())
                                  ]),
                              TextButton(
                                child: Text("cancel"),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ))
              : loading),
    );
  }
}
