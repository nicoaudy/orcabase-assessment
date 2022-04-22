import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class PostColItem extends StatelessWidget {
  final String title;
  final String url;
  final String excerpt;

  const PostColItem({
    Key? key,
    required this.title,
    required this.url,
    required this.excerpt,
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
            Text(
              parse(excerpt).documentElement!.text,
              style: TextStyle(color: Colors.grey[600]),
            ),
            ElevatedButton(
              onPressed: () => launch(url),
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
