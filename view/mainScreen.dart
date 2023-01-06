import 'package:flutter/material.dart';
import 'package:homestay_raya/view/login.dart';
import '../../models/user.dart';
import '../shared/mainmenu.dart';
import 'registrationscreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("HOMESTAY RAYA"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    IconButton(
                        onPressed: _registrationForm,
                        icon: const Icon(Icons.app_registration));
                    IconButton(
                        onPressed: _loginForm, icon: const Icon(Icons.login));
                  },
                  icon: const Icon(Icons.account_circle_rounded),
                ),
              ),
            ],
          ),
          body: const Center(child: Text("Homestay")),
          drawer: MainMenuWidget(user: widget.user),
        ));
  }

  void _registrationForm() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const RegistrationScreen()));
  }

  void _loginForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginScreen()));
  }
}
