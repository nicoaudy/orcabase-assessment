import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class PostColItem extends StatelessWidget {
  final String title;
  final String excerpt;
  final VoidCallback onTap;

  const PostColItem({
    Key? key,
    required this.title,
    required this.excerpt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Colors.grey[200],
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              parse(excerpt).documentElement!.text,
              style: TextStyle(color: Colors.grey[600]),
            ),
            ElevatedButton(
              onPressed: onTap,
              child: const Text('Read more'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
              ),
            )
          ],
        ),
      ),
    );
  }
}
