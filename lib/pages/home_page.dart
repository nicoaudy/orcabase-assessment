import 'package:flutter/material.dart';
import 'package:orcabase/networking/wordpress_api.dart';
import 'package:orcabase/widgets/post_col_item.dart';
import 'package:orcabase/widgets/post_row_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> posts = [];
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

    final response = await fetchWpPosts();
    setState(() {
      posts = response;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "Orcabase",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = posts[index];
                  return PostRowItem(
                    title: post['title'],
                    url: post['short_URL'],
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = posts[index];
                  return PostColItem(
                    title: post['title'],
                    url: post['short_URL'],
                    excerpt: post['excerpt'],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
