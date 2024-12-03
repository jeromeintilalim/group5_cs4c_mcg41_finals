import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _visible = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final userController = TextEditingController();
  final pwdController = TextEditingController();

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
              Icons.rocket_launch_sharp,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Create your account',
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
                        controller: nameController,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffEA2843)),
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
                          labelText: 'Name',
                          prefixIcon: Icon(
                            Icons.abc,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Enter Name',
                        ),
                        style: const TextStyle(color: Color(0xFFEEEEEE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
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
                        controller: emailController,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffEA2843)),
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
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          hintText: 'Enter Email',
                        ),
                        style: const TextStyle(color: Color(0xFFEEEEEE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                        controller: locationController,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffEA2843)),
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
                          labelText: 'Location',
                          prefixIcon: Icon(
                            Icons.location_pin,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Enter Location',
                        ),
                        style: const TextStyle(color: Color(0xFFEEEEEE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
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
                        controller: userController,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffEA2843)),
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
                          labelText: 'Username',
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
                          hintText: 'Enter Username',
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
                        hintColor: const Color.fromRGBO(
                            84, 87, 90, 0.5),
                      ),
                      child: TextFormField(
                        controller: pwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffEA2843)),
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
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Enter Password',
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
                          if (_formKey.currentState!.validate())
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage())),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registration Successful.'),
                                  backgroundColor: Colors.green,
                                ),
                              )
                            }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Sign Up',
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
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  duration: const Duration(milliseconds: 300),
                                  child: LoginPage()))
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.grey),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Back to Login',
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
