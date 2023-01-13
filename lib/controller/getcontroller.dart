import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Newscontroller extends GetxController {
  List newslist = [];
  @override
@override
  void oninit() {
    // TODO: implement onReady
    fetchdata();
    super.onReady();
  }

  
  fetchdata() async {
    print('fecth data');
    final apikey = Uri.parse(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=6c81d0c321574a45a5ad960a38a31ea3');
    final response = await http.get(apikey);
    final body = response.body;

    final json = jsonDecode(body);

    newslist = json['articles'];
    // log(newslist.toString());

    refresh();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchdata();
    super.onInit();
  }
  


}
