
import 'package:delivery/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/Register.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      icon:const Icon(Icons.login, color: Colors.white),
                      label: const Text("Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed:  () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyWidget(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.5),
                      ),
                      icon:const Icon(Icons.person_add, color: Colors.indigo),
                      label: const Text(
                        " Create Your Account",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
