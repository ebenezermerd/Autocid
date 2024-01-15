import 'package:autocid_version1/components/constants.dart';
import 'package:autocid_version1/dynamic_provider.dart';
import 'package:autocid_version1/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static const page = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _forgotPass;
  String _email = '';
  String _password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _forgotPasscode() async {
    String email = emailController.text.trim();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSuccessSnackbar('Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(e.message!);
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      User user = userCredential.user!;

      // ignore: use_build_context_synchronously
      Provider.of<DynamicContentProvider>(context, listen: false)
          .setCurrentUser(user.email!);

      Navigator.pushNamed(context, HomePage.page);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                  'Invalid Email or Password',
                  style: kmidTextStyle,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: kmidTextStyle,
                      ))
                ],
              );
            });
      } else {
        print("Something went wrong with the login");
        print(e.code);
      }
    }
  }

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'cargo',
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                      'assets/carpin.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    constraints: const BoxConstraints(minHeight: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                          const Text(
                            'LogIn',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0daa53),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 350,
                            child: const Divider(
                              color: Color(0xFF0ec35e),
                              height: 8,
                              thickness: 5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  label: 'Email',
                                  textEditingController: emailController,
                                  function: (value) {
                                    _email = value;
                                  },
                                ),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  label: 'Password',
                                  textEditingController: passwordController,
                                  function: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: true,
                                            groupValue: _forgotPass,
                                            onChanged: (value) {
                                              _forgotPass = value;
                                            }),
                                        const Text(
                                          'Remeber Me',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff586d62),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          _forgotPasscode();
                                        },
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff586d62),
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                  text: 'Login',
                                  width: 150,
                                  maxHeight: 50,
                                  color: const Color(0xFF0b984a),
                                  textColor: Colors.white,
                                  function: () {
                                    _login();
                                  }),
                              const SizedBox(width: 20),
                              CustomButton(
                                  text: 'SignUp',
                                  width: 150,
                                  maxHeight: 50,
                                  color: const Color(0xFF0b984a),
                                  textColor: Colors.white,
                                  function: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  })
                            ],
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              print('oh');
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.qr_code, size: 35),
                                Text('Use QR Scanner',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff586d62),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: 'Read our',
                                  style: TextStyle(
                                      color: Colors.black, height: 1.5),
                                  children: [
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    TextSpan(
                                      text: 'and have an acess to our',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Terms of services',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
