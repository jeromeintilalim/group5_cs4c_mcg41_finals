import 'package:flutter/material.dart';
import 'package:group5_cs4c_mcg41_finals/screens/home.dart';
import 'package:group5_cs4c_mcg41_finals/screens/pages/contact.dart';
import 'package:page_transition/page_transition.dart';

import 'about.dart';
import 'services.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Scaffold(
              appBar: AppBar(
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
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
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
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 150),
                                child: const ServicesPage()));
                      },
                    ),
                    const ListTile(
                      title: Text(
                        'Projects',
                        style: TextStyle(color: Colors.white),
                      ),
                      tileColor: Color.fromARGB(255, 25, 28, 36),
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
              backgroundColor: const Color(0xFF141414),
              body: const Center(
                child: Text(
                  'Projects Page',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )));
  }
}
