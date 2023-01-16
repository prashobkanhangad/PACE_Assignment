import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:pace/db/model.dart';

class Newscontroller extends GetxController {
  List newslist = [];
  // List Getnewslist = [];

  ValueNotifier<List<Newsmodel>> newsnotifier = ValueNotifier([]);

  // void oninit() {
  //   fetchdata();
  //   getnewsdata(1);
  //   super.onReady();
  // }

  fetchdata() async {
    final apikey = Uri.parse(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=6c81d0c321574a45a5ad960a38a31ea3');
    try {
      final response = await http.get(apikey);

      if (response.statusCode == 200) {
        final body = response.body;

        final json = jsonDecode(body);

        newslist = json['articles'];
        // log(newslist.toString());
        print('fetch news data');
      }
    } catch (e) {
      print(e);
    }
    print('fecth data');
    // await addnewsdata(0);
    refresh();
  }

  Future<void> addnewsdata(int index) async {
    final newsdb = await Hive.openBox<Newsmodel>('news_db');
    print(newslist.toString());
    if (newslist.isNotEmpty) {
      final data = await newslist[index];
      final title = data['title'];
      final source = data['source']['name'];
      final imgurl = data['urlToImage'];
      final description = data['description'];
      final String publishedat = data['publishedAt'];
      final date = publishedat.split('T')[0];

      final newsdata = Newsmodel(
          date: date,
          description: description,
          imgurl: imgurl,
          newstitle: title,
          sourse: source);

      newsdb.add(newsdata);

      // log(newsdb.values.length.toString());

      newsnotifier.value.add(newsdata);
      newsnotifier.notifyListeners();
    }
    print('addnewsdata');
    // refresh();
  }

  Future getnewsdata() async {
    final newsdb = await Hive.openBox<Newsmodel>('news_db');

    newsnotifier.value.clear();
    newsnotifier.value.addAll(newsdb.values);
    print('getnewsdata');

    Timer.periodic(const Duration(seconds: 2), (timer) {
      addnewsdata(5);
    });

    // refresh();
  }
}
