import 'package:group5_cs4c_mcg41_finals/screens/register.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;

  final userController = TextEditingController();
  final pwdController = TextEditingController();

  Future userLogin() async {
    // String url = "https://pakainaso.000webhostapp.com/user_login.php";

    setState(() {
      _visible = true;
    });

    var data = {
      'username': userController.text,
      'password': pwdController.text,
    };

    // var client = http.Client();

    // var response = await client.post(Uri.parse(url), body: json.encode(data));

    // if (response.statusCode == 200) {
    if (userController.text == "test" && pwdController.text == "test") {
      // var msg = json.decode(response.body);

      // if (msg['loginStatus'] == true) {
      setState(() {
        _visible = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(uname: userController.text)));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Log in successful.'),
          backgroundColor: Colors.green,
        ),
      );
      // } else {
      //   setState(() {
      //     _visible = false;

      //     showMessage(msg["message"]);
      //   });
      // }
    } else {
      setState(() {
        _visible = false;

        showMessage("Invalid username or password.");
      });
    }
  }

  void showMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: const LinearProgressIndicator(),
              ),
            ),
            Container(
              height: 100.0,
            ),
            Icon(
              Icons.gamepad,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Welcome to Team Allstar!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        primaryColor: const Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: const Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor: const Color.fromRGBO(84, 87, 90, 0.5),
                      ),
                      child: TextFormField(
                        controller: userController,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xFFFF5168)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter Username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Username',
                        ),
                        style: const TextStyle(color: Color(0xFFEEEEEE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: const Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: const Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor: const Color.fromRGBO(84, 87, 90, 0.5),
                      ),
                      child: TextFormField(
                        controller: pwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xFFFF5168)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          hintText: 'Password',
                        ),
                        style: const TextStyle(color: Color(0xFFEEEEEE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          if (_formKey.currentState!.validate()) {userLogin()}
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Login',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()))
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Create an account',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
