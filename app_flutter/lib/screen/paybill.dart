// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PayBill extends StatefulWidget {
  const PayBill({super.key});

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayBill'),
      ),
      body: Text('PayBill'),
    );
  }
}
