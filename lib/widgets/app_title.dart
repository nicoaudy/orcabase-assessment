import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String appTitle;

  const AppTitle({
    Key? key,
    required this.appTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        appTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
