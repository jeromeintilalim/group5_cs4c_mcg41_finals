import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group5_cs4c_mcg41_finals/screens/modals/floating_modal.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'login.dart';
import 'modals/modal.dart';
import 'update.dart';

class UserDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _userData = [];

  List<Map<String, dynamic>> get userData => _userData;

  void setUserData(List<Map<String, dynamic>> data) {
    _userData = data;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  final String? uname;
  HomePage({Key? key, this.uname}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://pakainaso.000webhostapp.com/get_users.php'));

      if (response.statusCode == 200) {
        final String responseBody = response.body;

        // Check if the response is "No data found"
        if (responseBody.trim().toLowerCase() == 'no data found') {
          // Handle the case where there is no data
          print('No data found');
          Provider.of<UserDataProvider>(context, listen: false).setUserData([]);
        } else {
          // Parse the JSON data
          var decodedData = jsonDecode(responseBody);

          if (decodedData is List) {
            Provider.of<UserDataProvider>(context, listen: false)
                .setUserData(List<Map<String, dynamic>>.from(decodedData));
          } else {
            print('Unexpected JSON format: $decodedData');
          }
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void refreshData() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data =
        Provider.of<UserDataProvider>(context).userData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF141414),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff222831),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: const Color.fromARGB(255, 25, 28, 36),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: const Text(
                'Services',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPage()));
              },
            ),
            ListTile(
              title: const Text(
                'Projects',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPage()));
              },
            ),
            ListTile(
              title: const Text(
                'Contact',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPage()));
              },
            ),
            ListTile(
              title: const Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPage()));
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
            child: data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 4, right: 16, bottom: 4, left: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xff222831),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                data[index]["UNAME"],
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdatePage(
                                      user: data[index],
                                      onUpdate: () {
                                        fetchData();
                                      },
                                      onDelete: () {
                                        fetchData();
                                      },
                                      uname: widget.uname,
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color(0xff2860EA)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'Group 5 - CS4C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle logout action
                              showFloatingModalBottomSheet(
                                context: context,
                                builder: (context) => const Modal(),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 6, 181, 44)),
                            ),
                            child: const Text(
                              'Show members',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ]),
                  ))
            // const Center(
            //     child: CircularProgressIndicator(),
            // ),
            ),
        SizedBox(
            height: 80.0,
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout action
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xffEA2843)),
                ),
                child: const Text(
                  'Log out',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ))
      ]),
    );
  }
}
