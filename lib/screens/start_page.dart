import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:autocid_version1/screens/login_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  static const page = '/home';
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
              Color(0xff1c3326),
              Color(0xff020303),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: 'cargo',
              child: Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 200),
                child: Image.asset(
                  'assets/carpin.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2,
                    child: const Text('Autonomous',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 60,
                            letterSpacing: 1,
                            fontFamily: 'oswald',
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Text('EV Charge Station ',
                      style: TextStyle(
                          fontSize: 40,
                          letterSpacing: 1,
                          fontFamily: 'oswald',
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    'Our real-time charging stream, and access flexibily will make you happy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Get Started!',
                    width: 500,
                    maxHeight: 50,
                    color: Colors.white,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
