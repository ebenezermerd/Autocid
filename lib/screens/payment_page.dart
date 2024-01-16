import 'package:autocid_version1/components/transaction_card.dart';
import 'package:autocid_version1/screens/dynamic_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:autocid_version1/components/constants.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';

class PaymentPage extends StatefulWidget {
  static const page = '/payment';

  const PaymentPage({Key? key, this.watt}) : super(key: key);
  final String? watt;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _showAllForPrevious = false;

  @override
  Widget build(BuildContext context) {
    final wattValue = Provider.of<DynamicContentProvider>(context).selectedWatt;
    final priceAmount = Provider.of<DynamicContentProvider>(context)
        .calculateWattCost()
        .toStringAsFixed(1);
    final userEmailAddress =
        Provider.of<DynamicContentProvider>(context).currentUserEmail;
    final phone = Provider.of<DynamicContentProvider>(context).currentUserPhone;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0b984a),
              Color(0xFF0daa53),
              Color(0xFF0ec35e),
              Color(0xFF10c662),
              Color(0xFF88e1ae),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(
                        onPressed: () => Provider.of<DynamicContentProvider>(
                                context,
                                listen: false)
                            .navigateToPage(4),
                        icon: const Icon(Icons.arrow_back_ios, size: 30)),
                    const SizedBox(width: 10),
                    const Text('Make other Charging ', style: kmidTextStyle),
                  ]),
                  const Row(
                    children: [
                      Icon(Icons.search, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.message, size: 30),
                    ],
                  )
                ],
              ),
              DynamicContentBox(
                  watt: wattValue,
                  price: priceAmount,
                  userEmail: userEmailAddress,
                  userPhone: phone),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () => setState(
                          () => _showAllForPrevious = !_showAllForPrevious),
                      child: Text(
                        _showAllForPrevious ? 'Show Less' : 'See All',
                        style: const TextStyle(fontSize: 18),
                      ))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _showAllForPrevious
                        ? transactions.length
                        : transactions.length > 1
                            ? 2
                            : 1,
                    itemBuilder: (context, index) {
                      return TransactionCard(
                          transactionData: transactions[index]);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
