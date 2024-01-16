import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/screens/start_page.dart';
import 'package:autocid_version1/screens/home_page.dart';
import 'package:autocid_version1/screens/login_page.dart';
import 'package:autocid_version1/screens/stream_page.dart';
import 'package:autocid_version1/screens/price_page.dart';
import 'package:autocid_version1/screens/payment_page.dart';
import 'package:flutter/services.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Autocid());
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class Autocid extends StatelessWidget {
  const Autocid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DynamicContentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: StartPage.page,
        routes: {
          StreamDisplay.page: (context) => const StreamDisplay(),
          StartPage.page: (context) => const StartPage(),
          HomePage.page: (context) => const HomePage(),
          LoginPage.page: (context) => const LoginPage(),
          PaymentPage.page: (context) => const PaymentPage(),
          PricePage.page: (context) => const PricePage(),
        },
      ),
    );
  }
}
