import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final cardDecoration = BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
      ],
      gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.blue,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      borderRadius: BorderRadius.all(Radius.circular(15)));


  final buttonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    gradient: LinearGradient(
        colors: [
          const Color(0xfffcdf8a),
          const Color(0xfff38381),
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );

  final buttonTextStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Screen"),
      ),
      body: CreditCardInputForm(
        cardHeight: 170,
        showResetButton : true,
        onStateChange: (currentState, cardInfo) {
          print(currentState);
          print(cardInfo);
        },
        frontCardDecoration: cardDecoration,
        backCardDecoration: cardDecoration,
        prevButtonDecoration: buttonDecoration,
        nextButtonDecoration: buttonDecoration,
        resetButtonDecoration : buttonDecoration,
        prevButtonTextStyle: buttonTextStyle,
        nextButtonTextStyle: buttonTextStyle,
        resetButtonTextStyle: buttonTextStyle,
        initialAutoFocus: true, // optional

      ),
    );
  }
}
