import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  Uri url = Uri.parse(
    "https://public-api.wordpress.com/rest/v1.1/sites/orcabase385246134.wordpress.com/posts/",
  );

  final response = await http.get(url, headers: {"Accept": "application/json"});
  var convertDatatoJson = jsonDecode(response.body);
  return convertDatatoJson['posts'];
}
