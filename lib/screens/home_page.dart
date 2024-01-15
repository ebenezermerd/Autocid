import 'package:autocid_version1/components/profile_drawer.dart';
import 'package:autocid_version1/screens/payment_page.dart';
import 'package:autocid_version1/screens/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:autocid_version1/screens/stream_page.dart';
import 'package:autocid_version1/screens/transaction_page.dart';
import 'package:autocid_version1/screens/price_page.dart';
import 'package:provider/provider.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const page = '/start';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 1;

  final FirebaseFirestore store = FirebaseFirestore.instance;

  Future<void> getUserData() async {
    String email =
        Provider.of<DynamicContentProvider>(context).currentUserEmail;

    DocumentReference userRefer = store.collection("Users Data").doc(email);
    try {
      DocumentSnapshot snapshot = await userRefer.get();
      if (snapshot.exists) {
        String phone = snapshot.get("phoneNumber");
        String name = snapshot.get("fullName");
        // ignore: use_build_context_synchronously
        Provider.of<DynamicContentProvider>(context, listen: false)
          ..setCurrentPhone(phone)
          ..setCurrentUsername(name);
      } else {
        print("No such user and document not found");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTranscationData() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return ChangeNotifierProvider(
        create: (_) => NavigationService(),
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: _selectedIndex,
              height: 55,
              backgroundColor: const Color(0xFF88e1ae),
              items: const [
                Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 30,
                ),
                Icon(
                  Icons.battery_3_bar,
                  color: Colors.black,
                  size: 30,
                ),
                Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
              ],
              animationDuration: const Duration(milliseconds: 300),
              onTap: (index) {
                _selectedIndex = index;
                Provider.of<DynamicContentProvider>(context, listen: false)
                    .setCurrentPageIndex(_selectedIndex);
                print(_selectedIndex);
              }),
          body: routeThroughPages(
              Provider.of<DynamicContentProvider>(context).currentPageIndex,
              context),
        ));
  }
}

Widget routeThroughPages(int value, BuildContext context) {
  final currentPageIndex =
      Provider.of<DynamicContentProvider>(context).currentPageIndex;

  final pages = <int, Widget>{
    0: const TransactionsList(),
    1: const StreamDisplay(),
    2: const ProfileDrawer(),
    3: const SignUpPage(),
    4: const PricePage(),
    5: const PaymentPage(),
  };

  return pages[currentPageIndex]!;
}

// Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: BottomNavigationBar(
//               elevation: 5,
//               backgroundColor: Color(0xFF88e1ae),
//               currentIndex: _selectedIndex,
//               items: [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.home, color: Colors.black, size: 30),
//                     label: 'Home'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.qr_code, color: Colors.black, size: 30),
//                     label: 'Scan'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person, color: Colors.black, size: 30),
//                     label: 'Profile'),
//               ],
//               selectedItemColor: Color(0xffffffff),
//               onTap: _onItemTapped,
//             ),
