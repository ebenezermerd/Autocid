import 'dart:math';

import 'package:autocid_version1/components/transaction_card.dart';
import 'package:autocid_version1/screens/home_page.dart';
import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:autocid_version1/components/constants.dart';
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

class DynamicContentBox extends StatefulWidget {
  const DynamicContentBox(
      {Key? key, this.watt, this.price, this.userEmail, this.userPhone})
      : super(key: key);
  final double? watt;
  final String? price;
  final String? userEmail;
  final String? userPhone;

  @override
  State<DynamicContentBox> createState() => _DynamicContentBoxState();
}

Future<void> makePayment() async {
  
}
class _DynamicContentBoxState extends State<DynamicContentBox> {

  Future<void> makeTranscationCard() async {
    try {
      String userEmail =
          Provider.of<DynamicContentProvider>(context, listen: false)
              .currentUserEmail;
      // String dateTimeOfTransaction =
      //     Provider.of<DynamicContentProvider>(context, listen: false)
      //         .getDateTime();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users Data');
      DocumentReference userDocRef = usersCollection.doc(userEmail);

      final TransactionData transactionData = TransactionData(
        title: '${widget.watt} Charging with ${widget.price}',
        date: '${DateTime.now()}',
        amount: widget.price!,
        status: 'Completed',
        stationId: 'AMEN-001',
      );

      await userDocRef.update({
        'transaction': FieldValue.arrayUnion([transactionData.toMap()])
      });
      transactions.add(transactionData);
      print('transaction added');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
      String? userName = Provider.of<DynamicContentProvider>(context, listen: false)
      .currentUserUsername;
    print('${widget.userPhone}: usersPhone');
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(30),
        constraints: const BoxConstraints(
          maxHeight: 250,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Consumer<DynamicContentProvider>(
            builder: (context, provider, child) {
          if (provider.showNewContent == true) {
            return Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.verified_user, size: 30),
                        Text(
                          'Make Sure To Start ',
                          style: kmidTextStyle,
                        ),
                      ],
                    ),
                    Text(' ${widget.price} Birr',
                        style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'oswald',
                            fontWeight: FontWeight.bold)),
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 110,
                        maxWidth: 165,
                      ),
                      child: Image.asset('assets/carpin.png'),
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'It will Take 20min',
                            style: kmidTextStyle,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Confirm To Pay',
                            style: kmidTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      CustomButton(
                        text: 'Confirm',
                        width: 120,
                        maxHeight: 50,
                        color: const Color(0xFF0daa53),
                        textColor: Colors.white,
                        function: () async{
                        String email = Provider.of<DynamicContentProvider>(context, listen: false).currentUserEmail;
                            makeTranscationCard();
                            
                                
                  Chapa result = Chapa.paymentParameters(
                    context: context, // context
                    publicKey: 'CHAPUBK_TEST-oDpdig8RietCutOAQzXT6hAM8eds6Yo8',
                    currency: 'ETB',
                    amount: widget.price!,
                    email: email,
                    // phone: '+251911223344',
                    firstName: userName,
                    lastName: '',
                    txRef:
                        '34shkdjhkjTXTHHgb${Random().nextInt(10)}',
                    title: 'Payment',
                    desc: 'This is description',
                    namedRouteFallBack: HomePage.page, // fall back route name
                  );
                  // result.initPayment();
                  // print(result.title);
                
                          } ),
                        
                      
                    ],
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('${widget.userEmail}', style: kmidTextStyle),
                        Text('${widget.userPhone}', style: kSmallTextStyle),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.watt} W',
                            style: const TextStyle(
                                fontSize: 40,
                                fontFamily: 'oswald',
                                fontWeight: FontWeight.bold)),
                        const Text('Charging Price', style: kSmallTextStyle),
                        Text(' ${widget.price} Birr',
                            style: const TextStyle(
                                fontSize: 35,
                                fontFamily: 'oswald',
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 120,
                          minWidth: 175,
                        ),
                        child: Image.asset('assets/carpin.png'),
                      ),
                      CustomButton(
                        color: const Color(0xFF0daa53),
                        width: 150,
                        maxHeight: 60,
                        function: () {
                          provider.toggleNewContent();
                        },
                        text: 'Make Payment',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            );
          }
        }));
  }
}
