import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orcabase/networking/wordpress_api.dart';
import 'package:intl/intl.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;
  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Map post = {};
  bool loading = false;

  @override
  void initState() {
    _mounted();
    super.initState();
  }

  _mounted() async {
    setState(() {
      loading = true;
    });

    final response = await fetchWpDetailPost(widget.postId);
    setState(() {
      post = response;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Published at: ${DateFormat('dd/MM/y hh:mm:ss').format(DateTime.parse(post['date']))}",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Html(
                    data: post['content'],
                  ),
                ],
              ),
      ),
    );
  }
}
