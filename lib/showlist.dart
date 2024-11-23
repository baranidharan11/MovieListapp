import 'package:flutter/material.dart';
import 'package:fetchapi/ShowDetailsScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowListScreen extends StatefulWidget {
  @override
  _ShowListScreenState createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  List<dynamic> _shows = [];

  @override
  void initState() {
    super.initState();
    _fetchShows();
  }

  Future<void> _fetchShows() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));

    if (response.statusCode == 200) {
      setState(() {
        _shows = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 2),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 4)),
          ),
          child: AppBar(
            title: const Text(
              'Movies',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.pinkAccent,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _shows.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(color: Colors.pinkAccent);
          }

          final showIndex = (index / 2).round();

          final show = _shows[showIndex];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Row(
              children: [
                Text(
                  '${showIndex + 1}. ',
                  style: const TextStyle(fontSize: 20),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purpleAccent,
                  backgroundImage: NetworkImage(show['image']['medium']),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    show['name'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetailsScreen(show: show),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
