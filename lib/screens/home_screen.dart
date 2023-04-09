import 'package:delivery/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("welcome to ur home"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("hey bro!"),
              ),
              ListTile(
                  title: const Text(" data one"),
                  leading: const Icon(
                    Icons.ballot_outlined,
                  ),
                  onTap: () {
                    setState(() {
                      check = false;
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                title: const Text(" data one"),
                leading: const Icon(
                  Icons.ballot_outlined,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(" data one"),
                leading: const Icon(
                  Icons.ballot_outlined,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(" data one"),
                leading: const Icon(
                  Icons.ballot_outlined,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(" data one"),
                leading: const Icon(
                  Icons.ballot_outlined,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(" data one"),
                leading: const Icon(
                  Icons.ballot_outlined,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(" Logout"),
                leading: const Icon(
                  Icons.logout_outlined,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: check
            ? Column(
                children: const [Text("some random text or widget here")],
              )
            : funOne(),
      ),
    );
  }

  Widget funOne() {
    return const Center(
      child: Text("This is function one that have been defined later"),
    );
  }
}
