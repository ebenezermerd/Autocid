import 'package:autocid_version1/components/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String fullName = '', _email = '', phoneNumber = '', dateOfBirth = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordContorller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  String _password = '';
  final _auth = FirebaseAuth.instance;

  getFullName(String value) {
    fullName = value;
  }

  getEmail(String value) {
    _email = value;
  }

  getPhoneNumber(String value) {
    phoneNumber = value;
  }

  getDateOfBirth(String value) {
    dateOfBirth = value;
  }

  createDataOfUser() async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('Users Data').doc(phoneNumber);

      Map<String, dynamic> userData = {
        'fullName': fullName,
        'email': _email,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'transaction': [],
      };

      await documentReference.set(userData).whenComplete(() {
        print('$fullName created');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.green[200],
            title: const Text('You have successfully signed up!'),
            content: const Text('You can now login to your account'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Proceed to Login'),
              ),
            ],
          ),
        );
      });
    } catch (error) {
      print(error);
      print('error has happened');
    }
  }

  void verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        createDataOfUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter SMS Code'),
              content: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Done'),
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: _password);
                    await _auth.signInWithCredential(phoneAuthCredential);
                    Navigator.pop(context);
                    createDataOfUser();
                  },
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  label: 'Full Name',
                                  textEditingController: fullNameController,
                                  function: (value) {
                                    getFullName(value);
                                  }, // Add validation/actions as needed
                                ),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  label: 'Email',
                                  textEditingController: emailController,
                                  function: (value) {
                                    getEmail(value);
                                    _email = value;
                                  }, // Add validation/actions as needed
                                ),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  label: 'Phone Number',
                                  textEditingController: phoneController,
                                  function: (value) {
                                    getPhoneNumber(value);
                                  }, // Add validation/actions as needed
                                ),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  label: 'Password',
                                  textEditingController: passwordContorller,
                                  function: (value) {
                                    _password = value;
                                  }, // Add validation/actions as needed
                                ),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  label: 'Date of Birth',
                                  textEditingController: dateController,
                                  function: (value) {
                                    getDateOfBirth(value);
                                  }, // Add validation/actions as needed
                                ),

                                // ... other widgets
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                        text: 'Login',
                                        width: MediaQuery.of(context)
                                                .size
                                                .width
                                                .toInt() -
                                            250,
                                        maxHeight: 50,
                                        color: const Color(0xFF0b984a),
                                        textColor: Colors.white,
                                        function: () {
                                          Navigator.pushNamed(
                                              context, '/login');
                                        }),
                                    CustomButton(
                                        text: 'SignUp',
                                        width: MediaQuery.of(context)
                                                .size
                                                .width
                                                .toInt() -
                                            250,
                                        maxHeight: 50,
                                        color: const Color(0xFF0b984a),
                                        textColor: Colors.white,
                                        function: () {
                                          verifyPhoneNumber();
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ])),
                ))
          ]),
        ),
      ),
    );
  }
}
//   _selectDate(BuildContext context) async {
//     final newDate = await showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoDatePicker(
//         initialDateTime: selectedDate ?? DateTime.now(),
//         mode: CupertinoDatePickerMode.date,
//         onDateTimeChanged: (dateTime) {
//           setState(() {
//             selectedDate = dateTime;
//           });
//         },
//       ),
//     );
//     if (newDate != null) {
//       setState(() {
//         selectedDate = newDate;
//       });
//     }
//   }
// }
