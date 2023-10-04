import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_word_search/models/word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordRepoCache {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  Future<WordModel> fetchData(String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cacheKey = 'word_$word';

    try {
      Response<dynamic> response;
      final String? cachedResponse = prefs.getString(cacheKey);

      if (cachedResponse != null) {
        // If cached, parse and return the cached data
        final data = json.decode(cachedResponse);
        final wordModel = WordModel.fromJson(data[0]);
        return wordModel;
      } else {
        // If not cached, fetch fresh data from the API
        response = await _dio.get(baseUrl + word,
            options: Options(
              headers: {
                'Accept': 'application/json',
              },
            ));

        if (response.statusCode == 200) {
          final data = response.data;
          final wordModel = WordModel.fromJson(data[0]);

          // Cache the fresh response
          prefs.setString(cacheKey, json.encode(data));

          return wordModel;
        } else {
          throw Exception('Failed to load word data');
        }
      }
    } catch (e) {
      throw Exception('Failed to load word data: $e');
    }
  }
}
