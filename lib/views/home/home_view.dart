import 'package:budgetbuddy/views/login/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void checkUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {}
  }

  String email = "";
  String password = "";
  String budget = "";
  String name = "";
  String method = "";

  void checkData() async {
    var box = await Hive.openBox('user');
    if (box.get('budget') == null || box.get('name') == null) {
      box.clear();
    } else {
      setState(() {
        budget = box.get('budget');
        name = box.get('name');
        email = box.get('email');
        password = box.get('password');
        method = box.get('method');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Home Page"),
              Text("Name: $name"),
              Text("Email: $email"),
              Text("Budget: $budget"),
              Text("Method: $method"),
              Text("Password: $password"),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _singOutAndRedirect();
                    });
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }

  _singOutAndRedirect() async {
    if (method == "hive") {
      var box = await Hive.openBox('user');
      box.put("isSignedIn", "false");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeView()),
          (route) => false);
    } else {
      var box = await Hive.openBox('user');
      box.put("isSignedIn", "false");
      FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeView()),
          (route) => false);
    }
  }
}
