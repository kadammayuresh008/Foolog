
import 'package:flutter/material.dart';

class paymentIntegrations extends StatefulWidget {
  @override
  _paymentIntegrationsState createState() => _paymentIntegrationsState();
}

class _paymentIntegrationsState extends State<paymentIntegrations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
        title:Text(
          'Payment',
           style:TextStyle(
            color: Colors.white,
        ),
        )
      ),
    );
  }
}
