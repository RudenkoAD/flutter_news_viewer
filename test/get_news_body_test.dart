import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_news_viewer/data/api/request/get_news_body.dart';

void main() {
  group('GetnewsBody', () {
    test('toJson should return the correct JSON map', () {
      final body = GetnewsBody(
        apiKey: 'apiKey',
        country: 'us',
        category: 'business',
        sources: 'cnn',
        q: 'flutter',
        pageSize: 10,
        page: 1,
      );

      final json = body.toJson();

      expect(json, {
        'country': 'us',
        'category': 'business',
        'sources': 'cnn',
        'q': 'flutter',
        'pageSize': 10,
        'page': 1,
      });
    });

    test('toJson should exclude null values', () {
      final body = GetnewsBody(
        apiKey: 'apiKey',
        pageSize: 10,
        page: 1,
      );

      final json = body.toJson();

      expect(json, {
        'pageSize': 10,
        'page': 1,
      });
    });
  });
}
