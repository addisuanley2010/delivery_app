import 'package:delivery/pages/Login.dart';
import 'package:flutter/material.dart';

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
                color: Colors.deepPurple,

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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.blue),
                      ),
                      child: Text("Sign In",
                          style: TextStyle(color: Colors.grey[550])),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style:const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black38)
                      ),
                        onPressed: () {},
                        child: const Text(
                          " Create Your Account",
                          style: TextStyle(color: Colors.indigo),
                        )),
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
