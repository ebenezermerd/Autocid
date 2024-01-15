import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StreamDisplay extends StatefulWidget {
  static const page = '/stream';

  const StreamDisplay({Key? key, this.watt}) : super(key: key);
  final String? watt;
  @override
  State<StreamDisplay> createState() => _StreamDisplayState();
}

class _StreamDisplayState extends State<StreamDisplay> {
  int voltageReadData = 0;
  FirebaseFirestore store = FirebaseFirestore.instance;

  Future<void> getVoltageData() async {
    DocumentReference userRefer =
        store.collection("Stream Data").doc('readdata');
    try {
      DocumentSnapshot snapshot = await userRefer.get();
      if (snapshot.exists) {
        int voltage = snapshot.get("voltage");
        // ignore: use_build_context_synchronously
        print(voltage);
        setState(() {
          voltageReadData = voltage;
          Provider.of<DynamicContentProvider>(context, listen: false)
              .setCurrentVoltage(voltageReadData);
          int currentVoltage =
              Provider.of<DynamicContentProvider>(context, listen: false)
                  .currentVoltage;
          double calcualtedVoltage =
              Provider.of<DynamicContentProvider>(context, listen: false)
                      .normalizedVoltage() /
                  100.0;
          print(currentVoltage);
          print(calcualtedVoltage);
        });
        print(voltage);
      } else {
        print("No such user and document not found");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getVoltageData();
    int currentVoltage =
        Provider.of<DynamicContentProvider>(context, listen: false)
            .currentVoltage;
    double calcualtedVoltage =
        Provider.of<DynamicContentProvider>(context, listen: false)
                .normalizedVoltage() /
            100;
    return ChangeNotifierProvider(
      create: (context) => DynamicContentProvider(),
      child: Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 300,
                    minWidth: 300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: CircularPercentIndicator(
                      radius: 130,
                      lineWidth: 20,
                      percent: calcualtedVoltage,
                      startAngle: 1,
                      progressColor: Colors.green.shade900,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        currentVoltage.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.transparent,
                      child: Column(children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ExpandedCards(
                              icons: Icons.lock,
                              title: 'Status',
                              subtitle: 'Active',
                            ),
                            ExpandedCards(
                              icons: FontAwesomeIcons.lightbulb,
                              title: 'Honk',
                              subtitle: 'Off',
                            ),
                            ExpandedCards(
                              icons: FontAwesomeIcons.boltLightning,
                              title: 'Charge',
                              subtitle: '28%',
                            ),
                            ExpandedCards(
                              icons: FontAwesomeIcons.truckMonster,
                              title: 'Time',
                              subtitle: '00:00:00',
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            ExpandedCards(
                                icons: FontAwesomeIcons.temperatureHalf,
                                title: "Car Type",
                                subtitle: 'Model: unspecified'),
                            ExpandedCards(
                                icons: FontAwesomeIcons.key,
                                title: "Battery",
                                subtitle: 'Level: 0 EV'),
                          ],
                        ),
                        const Row(
                          children: [
                            ExpandedCards(
                                icons: FontAwesomeIcons.carBattery,
                                title: "Station",
                                subtitle: 'ID: EV-000'),
                            ExpandedCards(
                                icons: Icons.private_connectivity,
                                title: "Warning",
                                subtitle: 'State: unspecified'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        CustomButton(
                          text: 'Get Charging!',
                          width: 360,
                          maxHeight: 60,
                          color: Colors.white,
                          function: () {
                            Provider.of<DynamicContentProvider>(context,
                                    listen: false)
                                .navigateToPage(4);
                          },
                        ),
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedCards extends StatelessWidget {
  const ExpandedCards(
      {super.key,
      required this.icons,
      required this.title,
      required this.subtitle});
  final IconData icons;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icons, color: const Color(0xFF10c662)),
              Text(title,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.green, fontSize: 20)),
              Text(
                subtitle,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
