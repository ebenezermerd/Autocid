import 'package:autocid_version1/components/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/dynamic_provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.width,
      required this.maxHeight,
      required this.color,
      this.textColor = Colors.black,
      this.function});
  final Color color;
  final Color textColor;
  final String text;
  final int width;
  final int maxHeight;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      color: color,
      child: MaterialButton(
        minWidth: width.toDouble(),
        height: maxHeight.toDouble(),
        onPressed: function!,
        child: Text(text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      this.textEditingController,
      this.function});
  final String label;
  final TextEditingController? textEditingController;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          label: Text(label),
          labelStyle: const TextStyle(color: Color(0xff057236), fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF0ec35e), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF10c662), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF10c662), width: 1),
          ),
        ),
        onChanged: function as void Function(String)?);
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionData transactionData;
  const TransactionCard({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DynamicContentProvider(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 50,
                        color: Colors.grey.shade200,
                        child: Image.asset('assets/carpin.png'),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(transactionData.title,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'oswald')),
                      Text(transactionData.date,
                          style: const TextStyle(
                              fontSize: 10, fontFamily: 'oswald'))
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transactionData.amount,
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'oswald')),
                  Text(transactionData.status,
                      style:
                          const TextStyle(fontSize: 12, fontFamily: 'oswald'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
