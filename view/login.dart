import 'package:flutter/material.dart';
import 'package:homestay_raya/models/user.dart';
import 'package:homestay_raya/view/mainScreen.dart';
import 'package:homestay_raya/view/registrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var screenHeight, screenWidth;

  @override
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Card(
                elevation: 8,
                margin: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    child: Column(children: [
                      TextFormField(
                          controller: _emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".")
                              ? "enter a valid email"
                              : null,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.email),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ))),
                      TextFormField(
                          controller: _passEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _passwordVisible,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.password),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ))),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              }),
                          Flexible(
                              child: GestureDetector(
                            onTap: null,
                            child: const Text('Remember Me',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            minWidth: 116,
                            height: 60,
                            elevation: 10,
                            onPressed: _loginUser,
                            color: Theme.of(context).colorScheme.primary,
                            child: const Text('Login'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: _goLogin,
                        child: const Text(
                          "Dont't have an account. Register Now",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: _goHome,
                        child: const Text(
                          "Go Back Home",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
                  ),
                ))),
      ),
    );
  }

  void _loginUser() {}

  void _goLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const RegistrationScreen()));
  }

  void _goHome() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const MainScreen(user: User)));

    Future<void> autoLogin() async {
      SharedPreferences prefs = await sharedPreferences.getInstance();
      String _email = (prefs.getString('email')) ?? '';
      String _pass = (prefs.getString)('pass') ?? '';
      if (_email.isNotEmpty){
        http.post(Uri.parse("${Config.server}/php/login user.php"),
        body= {"email": _email, "passsword": _pass}).then((response)) {
          var jsonResponse =json.decode(response.body);
          if (response.statusCode ==200 && jsonResponse ['status']== "success"){
            User user =user.fromJson(jsonResponse ['data']);
            Timer(
              const Duration(seconds:3),
              ()=> Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (content)=> MainScreen (user:user)

                )
              )
            );
          }else{
            User user =user(
              id="0",
              email:"notregistered",
              phone:"notregistered",
              name:"notregistered",
              address: "na",
              regdate:"0" );
            Timer(
              const Duration(seconds:3),
              ()=> Navigator.pushReplacement(context
              MaterialPageRoute(builder:(content)
              => const LoginScreen)));
          }
          }
          }  

