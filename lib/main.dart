import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:logger/logger.dart';
//TODO figure out how to get the API key from the user instead of hardcoding it


final logger = Logger();
final dio = Dio()..interceptors.add(PrettyDioLogger());



Future<Map<String, dynamic>> getNews() async {
  await Future.delayed(const Duration(seconds: 3));
  final response = await dio.get(
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=${dotenv.env["NEWSAPI_API_KEY"]}',
  );
  logger.i(response.data);
  return response.data;
}

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future _news;

  @override
  void initState() {
    super.initState();
    _news = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _news,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data['totalResults'],
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArticlePage(),
                              settings: RouteSettings(
                                arguments: snapshot.data["articles"][index]
                                  )));
                    },
                    child: Card(
                      elevation: 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints.expand(
                                    height: 150,
                                    width: 200,
                                  ),
                                  child: Image.network(snapshot.data['articles']
                                          [index]['urlToImage'] ??
                                      "https://via.placeholder.com/150")),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      snapshot.data['articles'][index]
                                              ['title'] ??
                                          "No Title",
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textWidthBasis: TextWidthBasis.parent,
                                    ),
                                    Text(
                                        snapshot.data['articles'][index]
                                                ['description'] ??
                                            "No Description",
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700])),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(article["title"]),
      ),
      body: Stack(children: [
        
        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsPage()));}, icon: const Icon(Icons.back_hand)),
        
        SingleChildScrollView(
          child: Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.network(article["urlToImage"], fit: BoxFit.fitHeight),
                Text(article["description"]),
                Text(article["content"]),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}