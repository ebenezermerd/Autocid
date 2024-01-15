import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:autocid_version1/components/transaction_card.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/components/constants.dart';

class PricePage extends StatefulWidget {
  static const page = '/price';

  const PricePage({Key? key}) : super(key: key);

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  double? _selectedWattPrice;
  TextEditingController wattAmountController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
   
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Price',
                    style: kLargeTextStyle,
                  ),
                  Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 35,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 50,
                      child: TextField(
                        controller: wattAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          hintText: 'Enter Watt Amount',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFF10c662), width: 1),
                          ),
                        ),
                        onChanged: (value) {
                          _selectedWattPrice = double.parse(value);
                        },
                      ),
                    ),
                    CustomButton(
                        text: 'GO-ON',
                        width: 100,
                        maxHeight: 20,
                        textColor: const Color.fromARGB(255, 2, 93, 5),
                        color: const Color.fromARGB(255, 7, 253, 69),
                        function: () {
                          print(_selectedWattPrice);
                          
                          Provider.of<DynamicContentProvider>(context,
                              listen: false)
                            ..setWattSelected(_selectedWattPrice!)
                            ..navigateToPage(5);
                        })
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: priceCardDataList.length,
                itemBuilder: (context, index) {
                  final priceCardData = priceCardDataList[index];
                  return PriceCard(
                    watt: priceCardData.watt,
                    minutes: priceCardData.minutes,
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({super.key, required this.watt, required this.minutes});
  final double watt;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DynamicContentProvider(),
      child: GestureDetector(
        onTap: () {
          Provider.of<DynamicContentProvider>(context, listen: false)
            ..setWattSelected(watt)
            ..togglePreviousContent()
            ..navigateToPage(5);

          final check =
              Provider.of<DynamicContentProvider>(context, listen: false)
                  .currentPageIndex;
          print(check);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          constraints: const BoxConstraints(
            minHeight: 180,
          ),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white24,
                  Colors.transparent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${watt.toString()}W',
                        style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'oswald',
                            color: Color(0xFF0daa53),
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Proceed Payment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0daa53),
                        ),
                      ),
                      const Text(
                        'Will be reacharged ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0daa53),
                        ),
                      ),
                      Text(
                        'In the Next $minutes minutes',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0daa53),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      height: 150, child: Image.asset('assets/carpin.png')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
