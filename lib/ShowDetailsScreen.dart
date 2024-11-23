import 'package:flutter/material.dart';

class ShowDetailsScreen extends StatelessWidget {
  final dynamic show;

  const ShowDetailsScreen({Key? key, required this.show}) : super(key: key);

  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> genres = show['genres'];
    String language = show['language'];

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 142, 158, 248),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: AppBar(
                title: Text(
                  show['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent, 
               
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.network(
                show['image']['original'],
                width: 150,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Movie Summary:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent, 
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                removeHtmlTags(show['summary'] ?? ''),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Language: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent, 
                    ),
                  ),
                  _buildLanguageLabel(language),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Genres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent, 
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 8.0,
                children: [..._buildGenreLabels(genres)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageLabel(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent, 
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        language,
        style: TextStyle(color: Colors.black87), 
      ),
    );
  }

  List<Widget> _buildGenreLabels(List<dynamic> genres) {
    return genres.map<Widget>((genre) => _buildGenreLabel(genre)).toList();
  }

  Widget _buildGenreLabel(String genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent, 
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        genre,
        style: TextStyle(color: Colors.white), 
      ),
    );
  }
}
