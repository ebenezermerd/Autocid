import 'package:flutter/material.dart';

class DynamicContentProvider extends ChangeNotifier {
  bool showNewContent = false;

//for little screen interchange
  void toggleNewContent() {
    showNewContent = true;
    notifyListeners();
  }

  void togglePreviousContent() {
    showNewContent = false;
    notifyListeners();
  }

  //for page navigation interchange
  int _currentPageIndex = 1; // Initial page index

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index) {
    if (index >= 0 && index < 5) {
      _currentPageIndex = index;
      notifyListeners();
    } else {
      print('something went wrong with the index');
    }
  }

  void navigateToPage(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  //for watt selection
  double _selectedWatt = 0.0;
  var priceCalculated = 0.0;
  double get selectedWatt => _selectedWatt;

  void setWattSelected(double watt) {
    _selectedWatt = watt;
    notifyListeners();
  }

  //watt vs price calculation
  double energyCostPerWh = 0.3217;
  int duration = 5; // in hours

  double calculateWattCost() {
    return energyCostPerWh * _selectedWatt * duration;
  }

  //signed user data
  String _signedUserEmail = '';
  String _signedUserPhone = '';
  String _signedUserUsername = '';
  void setCurrentUser(String user) {
    _signedUserEmail = user;
    notifyListeners();
  }

  void setCurrentPhone(String phone) {
    _signedUserPhone = phone;
    notifyListeners();
  }

  void setCurrentUsername(String username) {
    _signedUserUsername = username;
    notifyListeners();
  }

  String get currentUserUsername => _signedUserUsername;
  String get currentUserEmail => _signedUserEmail;
  String get currentUserPhone => _signedUserPhone;

  //for stream page voltage data
  int _currentVoltage = 0;
  void setCurrentVoltage(int voltage) {
    _currentVoltage = voltage;
    notifyListeners();
  }

  int get currentVoltage => _currentVoltage;

  double normalizedVoltage() {
    double minVoltage = 0.0;
    double maxVoltage = 100.0;
    return (currentVoltage - minVoltage) / (maxVoltage - minVoltage) * 100.0;
  }

  //make adjustement for the built in dateTime method
  String formattedDate = '';

  String getDateTime() {
    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;
    int day = now.day;
    int hour = now.hour % 12;
    int minute = now.minute;
    int second = now.second;

    return formattedDate = "$year-$month-$day: $hour:$minute:$second";
  }
}

class NavigationService with ChangeNotifier {}
