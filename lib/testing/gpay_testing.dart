import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class Gpay extends StatefulWidget {
  const Gpay({Key? key}) : super(key: key);

  @override
  _GpayState createState() => _GpayState();
}

class _GpayState extends State<Gpay> {
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 40),
            GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            ApplePayButton(
              paymentConfigurationAsset: 'applepay.json',
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onApplePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// import 'package:flutter_pay/flutter_pay.dart';

// class Gpay extends StatefulWidget {
//   const Gpay({Key? key}) : super(key: key);

//   @override
//   _GpayState createState() => _GpayState();
// }

// class _GpayState extends State<Gpay> {
//   FlutterPay flutterPay = FlutterPay();

//   String result = "Result will be shown here";

//   @override
//   void initState() {
//     super.initState();
//   }

//   void makePayment() async {
//     List<PaymentItem> items = [PaymentItem(name: "T-Shirt", price: 2.98)];

//     flutterPay.setEnvironment(environment: PaymentEnvironment.Test);

//     flutterPay.requestPayment(
//       googleParameters: GoogleParameters(
//         gatewayName: "Sri Gayatri Oil Meal",
//         gatewayMerchantId: "BCR2DN6TUWQ4FXZI",
//       ),
//       appleParameters:
//           AppleParameters(merchantIdentifier: "merchant.flutterpay.example"),
//       currencyCode: "USD",
//       countryCode: "US",
//       paymentItems: items,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Container(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   result,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 FlatButton(
//                   child: const Text("Can make payments?"),
//                   onPressed: () async {
//                     try {
//                       bool result = await flutterPay.canMakePayments();
//                       setState(() {
//                         this.result = "Can make payments: $result";
//                       });
//                     } catch (e) {
//                       setState(() {
//                         result = "$e";
//                       });
//                     }
//                   },
//                 ),
//                 FlatButton(
//                   child: Text("Can make payments with verified card: $result"),
//                   onPressed: () async {
//                     try {
//                       bool result =
//                           await flutterPay.canMakePaymentsWithActiveCard(
//                         allowedPaymentNetworks: [
//                           PaymentNetwork.visa,
//                           PaymentNetwork.masterCard,
//                         ],
//                       );
//                       setState(() {
//                         this.result = "$result";
//                       });
//                     } catch (e) {
//                       setState(() {
//                         result = "Error: $e";
//                       });
//                     }
//                   },
//                 ),
//                 FlatButton(
//                     child: const Text("Try to pay?"),
//                     onPressed: () {
//                       makePayment();
//                     })
//               ]),
//         ),
//       ),
//     );
//   }
// }
