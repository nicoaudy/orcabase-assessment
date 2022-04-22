import 'package:a_datetime_picker/a_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcabase/networking/wordpress_api.dart';
import 'package:orcabase/pages/post_detail_page.dart';
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
  final TextEditingController _datepickerController = TextEditingController();

  List<dynamic> posts = [];
  List<dynamic> results = [];
  String query = '';
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

  void setResults(String query) {
    results = posts.where((elem) {
      return DateFormat('dd/MM/y HH:mm:ss')
          .format(DateTime.parse(elem['date']))
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }

  void _showModalSheet(String url, String id) {
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(postId: id),
                    ),
                  );
                },
                title: "Open in App",
                icon: Icons.apps,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDateTimePicker(
            context,
            currentTime: query.isEmpty ? DateTime.now() : DateTime.now(),
            showTitleActions: true,
            onChanged: (date) {
              setState(() {
                _datepickerController.text =
                    DateFormat('dd/MM/y HH:mm:ss').format(date);
                query = DateFormat('dd/MM/y HH:mm').format(date);
                setResults(query);
              });
            },
            onConfirm: (date) {
              setState(() {
                _datepickerController.text =
                    DateFormat('dd/MM/y HH:mm:ss').format(date);
                query = DateFormat('dd/MM/y HH:mm').format(date);
                setResults(query);
              });
            },
          );
        },
        child: TextField(
          controller: _datepickerController,
          style: TextStyle(color: Colors.grey[200]),
          enabled: false,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = query.isNotEmpty ? results : posts;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle(appTitle: "Orcabase"),
            const SizedBox(height: 40),
            _searchBox(),
            query.isNotEmpty
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        query = '';
                        setResults(query);
                      });
                    },
                    child: const Text('Clear'))
                : Container(),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = data[index];
                  return GestureDetector(
                    onTap: () => _showModalSheet(
                      post['short_URL'],
                      post['ID'].toString(),
                    ),
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
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = data[index];
                  return PostColItem(
                    title: post['title'],
                    onTap: () => _showModalSheet(
                      post['short_URL'],
                      post['ID'].toString(),
                    ),
                    excerpt: post['excerpt'],
                    publishDate: post['date'],
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
