import 'package:duitse_gym_app/data/users.dart';
import 'package:duitse_gym_app/pages/homepage.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    setState(() {
      _isButtonDisabled = _usernameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      User? loggedInUser;
      if (_usernameController.text == Users.barbara.first_name &&
          _passwordController.text == Users.barbara.password) {
        loggedInUser = Users.barbara;
      } else if (_usernameController.text == Users.michael.first_name &&
                 _passwordController.text == Users.michael.password) {
        loggedInUser = Users.michael;
      }

      if (loggedInUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(user: loggedInUser!),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset("assets/Icon.png", width: 200),
                ),
                Text(
                  "VierToreGym",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 400,
              child: Card(
                elevation: 8,
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 10,
                      children: [
                        Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: "Username"),
                            validator: (value) {
                              if (value != Users.barbara.first_name &&
                                  value != Users.michael.first_name) {
                                return "Wrong first name";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Password"),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: _isButtonDisabled ? null : _login,
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(Colors.white),
                              backgroundColor: WidgetStatePropertyAll(Colors.green),
                            ),
                            child: Text("Sign in"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text("Not registered yet?", style: TextStyle(fontSize: 18),),
                TextButton(onPressed: null,
                 style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(32),
                      side: BorderSide(
                        color: Colors.green,
                        width: 4
                      )
                      ))
                  ), child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("sign up"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}