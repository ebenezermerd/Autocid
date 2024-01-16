import 'package:autocid_version1/components/constants.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:autocid_version1/components/transaction_card.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class _DynamicContentBoxState extends State<DynamicContentBox> {
  
//test

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
                          function: () async {
                            makeTranscationCard();
                            Provider.of<DynamicContentProvider>(context,
                                    listen: false)
                                .navigateToPage(1);
                          }),
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
