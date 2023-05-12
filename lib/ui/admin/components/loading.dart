import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:flutter/material.dart';
class Loadnig extends StatelessWidget {
  const Loadnig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20,),
                  TextCustom(text: 'loading...')
                ],
              ),
            )
           
    );
  }
}