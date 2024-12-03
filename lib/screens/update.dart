import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData {
  String uid;
  String name;
  String email;
  String location;
  String uname;
  String upass;

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.location,
    required this.uname,
    required this.upass,
  });
}

class UpdatePage extends StatefulWidget {
  final Map<String, dynamic> user;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final dynamic uname;

  UpdatePage({
    required this.user,
    required this.onUpdate,
    required this.onDelete,
    required this.uname,
  });

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UserData? userData;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController unameController = TextEditingController();
  TextEditingController upassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateFormData();
  }

  void updateFormData() {
    nameController.text = widget.user['NAME'] ?? '';
    emailController.text = widget.user['EMAIL'] ?? '';
    locationController.text = widget.user['LOCATION'] ?? '';
    unameController.text = widget.user['UNAME'] ?? '';
    upassController.text = widget.user['UPASS'] ?? '';
  }

  Future<void> updateUserData(String uid) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://pakainaso.000webhostapp.com/update_user.php?uid=$uid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': nameController.text,
          'email': emailController.text,
          'location': locationController.text,
          'uname': unameController.text,
          'upass': upassController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('User data updated successfully');
        widget.onUpdate();

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User data updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print(
            'Failed to update user data. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update user data. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating user data. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
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

  Future<void> deleteUserData(String uid) async {
    if (widget.uname == uid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Cannot delete. User currently logged in."),
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
    } else {
      print("NOT LOGGED IN. widget.uname: ${widget.uname}");
      print("NOT LOGGED IN. uname: $uid");
      try {
        final response = await http.get(
          Uri.parse(
              'https://pakainaso.000webhostapp.com/delete_user.php?uid=$uid'),
        );

        if (response.statusCode == 200) {
          print('User data deleted successfully');
          widget.onDelete();

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print(
              'Failed to delete user data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error deleting user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error deleting user. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('User Data Form', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF141414),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon:
                    Icon(Icons.abc, color: Color.fromRGBO(84, 87, 90, 0.5)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelStyle: TextStyle(color: Color(0xFFFF5168)),
                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              style: const TextStyle(color: Color(0xFFEEEEEE)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon:
                    Icon(Icons.email, color: Color.fromRGBO(84, 87, 90, 0.5)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelStyle: TextStyle(color: Color(0xFFFF5168)),
                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              style: const TextStyle(color: Color(0xFFEEEEEE)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_pin,
                    color: Color.fromRGBO(84, 87, 90, 0.5)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelStyle: TextStyle(color: Color(0xFFFF5168)),
                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              style: const TextStyle(color: Color(0xFFEEEEEE)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your location';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: unameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon:
                    Icon(Icons.person, color: Color.fromRGBO(84, 87, 90, 0.5)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelStyle: TextStyle(color: Color(0xFFFF5168)),
                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              style: const TextStyle(color: Color(0xFFEEEEEE)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: upassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon:
                    Icon(Icons.lock, color: Color.fromRGBO(84, 87, 90, 0.5)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(84, 87, 90, 0.5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelStyle: TextStyle(color: Color(0xFFFF5168)),
                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              style: const TextStyle(color: Color(0xFFEEEEEE)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ButtonTheme(
                  minWidth: 200.0,
                  height: 80.0,
                  child: MaterialButton(
                    color: const Color(0xffEA2843),
                    textColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width * 0.47,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    onPressed: () {
                      // Confirm user's intention to delete
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteUserData(widget.user['UID'].toString());
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ButtonTheme(
                    minWidth: 200.0,
                    height: 80.0,
                    child: MaterialButton(
                      color: const Color(0xff2860EA),
                      minWidth: MediaQuery.of(context).size.width * 0.47,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      onPressed: () {
                        updateUserData(widget.user['UID'].toString());
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 24.0,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
