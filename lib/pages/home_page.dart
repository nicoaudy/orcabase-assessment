import 'package:flutter/material.dart';
import 'package:orcabase/networking/wordpress_api.dart';
import 'package:orcabase/widgets/app_title.dart';
import 'package:orcabase/widgets/link_option.dart';
import 'package:orcabase/widgets/post_col_item.dart';
import 'package:orcabase/widgets/post_row_item.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _showModalSheet(String url) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 150.0,
          color: Colors.grey[200],
          child: Column(
            children: [
              const SizedBox(height: 10),
              LinkOption(
                onTap: () => launch(url),
                title: "Open in Browser",
                icon: Icons.open_in_browser,
              ),
              LinkOption(
                onTap: () {},
                title: "Open in App",
                icon: Icons.apps,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle(appTitle: "Orcabase"),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = posts[index];
                  return GestureDetector(
                    onTap: () => _showModalSheet(post['short_URL']),
                    child: PostRowItem(
                      title: post['title'],
                      url: post['short_URL'],
                    ),
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
                    onTap: () => _showModalSheet(post['short_URL']),
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
