import 'package:flutter/material.dart';
import 'package:group5_cs4c_mcg41_finals/screens/modals/floating_modal.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/about.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/contact.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/projects.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'modals/modal.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data =
        Provider.of<UserDataProvider>(context).userData;
    return Scaffold(
      appBar: AppBar(
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
            const ListTile(
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Color.fromARGB(255, 25, 28, 36),
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
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 150),
                        child: const ServicesPage()));
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
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 150),
                        child: const ProjectsPage()));
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
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 150),
                        child: const ContactPage()));
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
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 150),
                        child: const AboutPage()));
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
            child: Center(
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
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => const Modal(),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xff222831)),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0)),
                  ),
                  child: const Text(
                    'Show members',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
              ]),
        ))),
        SizedBox(
            height: 80.0,
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 250),
                          child: LoginPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out.'),
                      backgroundColor: Color(0xff222831),
                    ),
                  );
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
