import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Ocrabase",
          style: TextStyle(color: Colors.white, fontSize: 38),
        ),
      ),
    );
  }
}
