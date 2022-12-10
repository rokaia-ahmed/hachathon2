import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children:const [
             Center(
               child: Text(
                'home',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
            ),
             ),
          ],
      ),
    );
  }
}
