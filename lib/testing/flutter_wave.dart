import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';

class FlutterWavePaymentGateway extends StatefulWidget {
  const FlutterWavePaymentGateway({Key? key}) : super(key: key);

  @override
  FlutterWavePaymentGatewayState createState() =>
      FlutterWavePaymentGatewayState();
}

class FlutterWavePaymentGatewayState extends State<FlutterWavePaymentGateway> {
  final String currency = FlutterwaveCurrency.KES;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController amount = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter + Flutterwave'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10.0),
              child: Form(
                  key: formKey,
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: fullname,
                        decoration:
                            const InputDecoration(labelText: "Full Name"),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Please fill in Your Name",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: phone,
                        decoration:
                            const InputDecoration(labelText: "Phone Number"),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Please fill in Your Phone number",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(labelText: "Email"),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Please fill in Your Email",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: amount,
                        decoration: const InputDecoration(labelText: "Amount"),
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : "Please fill in the Amount you are Paying",
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Pay with Flutterwave'),
                      onPressed: () {
                        final name = fullname.text;
                        final userPhone = phone.text;
                        final userEmail = email.text;
                        final amountPaid = amount.text;

                        if (formKey.currentState!.validate()) {
                          _makeFlutterwavePayment(
                              context, name, userPhone, userEmail, amountPaid);
                        }
                      },
                    ),
                  ]))),
        ));
  }

  //Add a method to make the flutter wave payment
  //This Method includes all the values needed to create the Flutterwave Instance
  void _makeFlutterwavePayment(BuildContext context, String fullname,
      String phone, String email, String amount) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          //the first 10 fields below are required/mandatory
          context: this.context,
          fullName: fullname,
          phoneNumber: phone,
          email: email,
          amount: amount,
          //Use your Public and Encription Keys from your Flutterwave account on the dashboard
          encryptionKey: 'FLWSECK_TEST535bf09328f1',
          publicKey: 'FLWPUBK_TEST-853f7591843f37429140737ff7a14231-X',
          currency: currency,
          txRef: DateTime.now().toIso8601String(),
          //Setting DebugMode below to true since will be using test mode.
          //You can set it to false when using production environment.
          isDebugMode: false,
          //configure the the type of payments that your business will accept
          acceptCardPayment: true,
          acceptUSSDPayment: false,
          acceptAccountPayment: true,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: false,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);

      final response = await flutterwave.initializeForUiPayments();
      if (response == null) {
        print("Transaction Failed");
      } else {
        if (response.status == "Transaction successful") {
          print(response.data);
          print(response.message);
        } else {
          print(response.message);
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
