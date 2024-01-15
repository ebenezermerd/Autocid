import 'package:autocid_version1/components/transaction_card.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatefulWidget {
  static const page = '/transaction';

  const TransactionsList({Key? key, this.watt}) : super(key: key);
  final String? watt;
  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  bool _showAllForRecent = false;
  bool _showAllForPrevious = false;
  Future<void> fetchTransactions() async {
    String userEmail =
        Provider.of<DynamicContentProvider>(context, listen: false)
            .currentUserEmail;
    print(userEmail);

    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('Users Data').doc(userEmail);
    userDocRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> userData =
            docSnapshot.data() as Map<String, dynamic>;

        List<dynamic> transactionDataList = userData['transaction'];
        transactions = transactionDataList
            .map((data) => TransactionData.fromMap(data))
            .toList();

        // Display transactions using ListView.builder
      } else {
        // Handle the case where the user document doesn't exist
        print('User document not found');
      }
    }).catchError((error) {
      // Handle errors during Firestore retrieval
      print('Error fetching user data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchTransactions();
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
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Recent Transaction History',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () => setState(
                          () => _showAllForRecent = !_showAllForRecent),
                      child: Text(
                        _showAllForRecent ? 'Show Less' : 'See All',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _showAllForRecent
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    ' Previous Transaction History',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () => setState(
                          () => _showAllForPrevious = !_showAllForPrevious),
                      child: Text(
                        _showAllForPrevious ? 'Show Less' : 'See All',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _showAllForPrevious
                        ? transactions.length
                        : transactions.length > 1
                            ? 2
                            : transactions.isNotEmpty
                                ? 1
                                : 0,
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
