import 'package:autocid_version1/components/constants.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:autocid_version1/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Assuming you're using SVG icons

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DynamicContentProvider>(context, listen: false)
        .currentUserUsername;
    print(user);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset('assets/autocid.gif'),
                    ),
                  ),
                  Text(
                    user,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Addis Ababa, Kolfe',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Edit Profile',
                width: 150,
                maxHeight: 60,
                color: Colors.green,
                function: () {},
                textColor: Colors.white,
              )
            ]),
          )),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: ListView(
                children: [
                  // Profile Section
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Settings',
                      style: kLargeTextStyle,
                    ),
                  ),
                  // Navigation Tiles
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Detailed Transaction History',
                        style: kmidTextStyle),
                    trailing: const Icon(Icons.forward),
                    onTap: () => Navigator.pushNamed(context, '/transaction'),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(color: Colors.white),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_attributes),
                    title: const Text('Edit Profile, ', style: kmidTextStyle),
                    trailing: const Icon(Icons.forward),
                    onTap: () => Navigator.pushNamed(context, '/edit-profile'),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(color: Colors.white),
                  ),
                  ListTile(
                    leading: const Icon(Icons.sunny),
                    title: const Text('Appearance', style: kmidTextStyle),
                    trailing: const Icon(Icons.forward),
                    onTap: () => Navigator.pushNamed(context, '/appearance'),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(color: Colors.white),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout', style: kmidTextStyle),
                    trailing: const Icon(Icons.forward),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.green[200],
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Provider.of<DynamicContentProvider>(context,
                                      listen: false)
                                  .setCurrentUser('');
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginPage.page,
                                (route) => false,
                              );
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
