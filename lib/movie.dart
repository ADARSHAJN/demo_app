import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AppDrawer.dart';
import 'CustomNavigator.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      body: jsonEncode({
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting',
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body)['result'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void _showCompanyInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Company Info'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Company: Forward Biz Pvt'),
              Text('Address Bengaluru-56'),
              Text('Phone: XXXXXXXXX09'),
              Text('Email: XXXXXX@gmail.com'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:DrawerPage(),


      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Movie List'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'company_info') {
                _showCompanyInfo(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'company_info',
                  child: Text('Company Info'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 1,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[index]['title'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Genre: ${movies[index]['genre']}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Director: ${movies[index]['director']}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '${movies[index]['language']} | ${(DateTime.fromMillisecondsSinceEpoch(movies[index]['releasedDate']))}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movies[index]['pageViews']} Views',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Watch Trailer',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
