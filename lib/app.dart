import 'package:flutter/material.dart';
import 'package:orcabase/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orcabase',
      home: HomePage(),
    );
  }
}
